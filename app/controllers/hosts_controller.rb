class HostsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @host = Host.new
  end
  
  def index
	@hosts = Host.all.paginate :page => params[:page], :per_page => 5
	authorize! @hosts, :index
  end

  def create
    @host = Host.new(params[:host])
    if @host.save
      session[:host_id] = @host.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to "/"
    else
      render :action => 'new'
    end
  end

  def edit
    @host = current_host
  end

  def update
    @host = current_host
    if @host.update_attributes(params[:host])
      flash[:notice] = "Your profile has been updated."
      redirect_to "/"
    else
      render :action => 'edit'
    end
  end
  
  def show
  @host = Host.find(params[:id])
  authorize! :show, @host
  end
  
  def destroy
    @host = Host.find(params[:id])
	@host.parties.each do |party|
	  if party.upcoming?
	  party.invitations.each do |invitation|
	  guest = Guest.find(invitation.guest_id)
	  UserMailer.party_canceled(guest, @host.name, party.name).deliver
	  end
	end
	end
    @host.destroy
    flash[:notice] = "Successfully destroyed party."
    redirect_to parties_url
  end
end

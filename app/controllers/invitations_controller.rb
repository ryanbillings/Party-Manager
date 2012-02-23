class InvitationsController < ApplicationController
before_filter :login_required, :except => [:edit, :update]
  def index
    @invitations = Invitation.for_host(current_host).all.paginate :page => params[:page], :per_page => 5
	#@upcoming = Chore.all.upcoming.incomplete.paginate :page => params[:page], :per_page => 5
	#@invitations = Invitation.all
  end

  def show
    @invitation = Invitation.find(params[:id])
	@party = Party.find(@invitation.party_id)
	@guest = Guest.find(@invitation.guest_id)
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
	@invitation.generate_invite_code
	@invitation.host_id = current_host.id
	guest=Guest.find(@invitation.guest_id)
	party=Party.find(@invitation.party_id)
    if @invitation.save
	  UserMailer.registration_confirmation(guest, @invitation.invite_code, party, current_host).deliver  
      flash[:notice] = "Successfully created invitation."
      redirect_to @invitation
    else
      render :action => 'new'
    end
  end

  def edit
    @invitation = Invitation.find(params[:id])
  end

  def update
    @invitation = Invitation.find(params[:id])
    if @invitation.update_attributes(params[:invitation])
      flash[:notice] = "Successfully updated invitation."
	  if current_host
      redirect_to invitation_url
	  else
	  redirect_to "/"
	  end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    flash[:notice] = "Successfully destroyed invitation."
    redirect_to invitations_url
  end
end

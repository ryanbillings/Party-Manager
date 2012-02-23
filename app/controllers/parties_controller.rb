class PartiesController < ApplicationController
  before_filter :login_required
  def index
	if params[:search]
    @parties = Party.find(:all, :conditions => ['name LIKE ? AND host_id = ?', "%#{params[:search]}%", current_host.id]).paginate :page => params[:page], :per_page => 5
	@parties_upcoming = Party.find(:all, :conditions => ['name LIKE ? AND host_id = ? AND date >= ?', "%#{params[:search]}%", current_host.id, Time.now.strftime("%Y-%m-%d")]).paginate :page => params[:page], :per_page => 5
	@parties_past = Party.find(:all, :conditions => ['name LIKE ? AND host_id = ? AND date < ?', "%#{params[:search]}%", current_host.id, Time.now.strftime("%Y-%m-%d")]).paginate :page => params[:page], :per_page => 5
	else
    @parties = Party.for_host(current_host).all.paginate :page => params[:page], :per_page => 5
	@parties_upcoming = Party.for_host(current_host).upcoming.all.paginate :page => params[:page], :per_page => 5
	@parties_past = Party.for_host(current_host).past.all.paginate :page => params[:page], :per_page => 5
	end
	#@party_type=PartyType.find(@party.party_type_id)
	#@location=Location.find(@party.location_id)
  end

  def show
    @party = Party.find(params[:id])
	@party_type=PartyType.find(@party.party_type_id)
	@location=Location.find(@party.location_id)
	@invitations = Invitation.for_party(@party.id).all.paginate :page => params[:page], :per_page => 5
	@sum1 = Invitation.for_party(@party.id).sum(:expected_attendees)
	@sum2 = Invitation.for_party(@party.id).sum(:actual_attendees)
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(params[:party])
	@party.host_id = current_host.id
	@party.date = convert_to_date params[:party][:date]
    @party.rsvp_date = convert_to_date params[:party][:rsvp_date]
    if @party.save
      flash[:notice] = "Successfully created party."
      redirect_to @party
    else
      render :action => 'new'
    end
  end

  def edit
    @party = Party.find(params[:id])
  end

  def update
    @party = Party.find(params[:id])
	@party.update_attribute(:date, convert_to_date(params[:party][:date]))
    @party.update_attribute(:rsvp_date, convert_to_date(params[:party][:rsvp_date]))
    if @party.update_attributes(params[:party])
      flash[:notice] = "Successfully updated party."
      redirect_to party_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @party = Party.find(params[:id])
	if @party.upcoming?
	@party.invitations.each do |invitation|
	  guest = Guest.find(invitation.guest_id)
	  UserMailer.party_canceled(guest, @party.host.name, @party.name).deliver
	end
	end
    @party.destroy
    flash[:notice] = "Successfully destroyed party."
    redirect_to parties_url
  end
end

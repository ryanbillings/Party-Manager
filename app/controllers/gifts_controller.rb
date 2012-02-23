class GiftsController < ApplicationController
before_filter :login_required

  def index
  
	invitations=Invitation.for_host(current_host).all
	allgifts=Gift.all
	@gifts=Array.new
	for invitation in invitations
		for gift in allgifts
			if(invitation.id == gift.invitation_id)
				@gifts.push(gift)
			end
		end
	end
	@gifts=@gifts.paginate :page => params[:page], :per_page => 5
  end

  def show	
    @gift = Gift.find(params[:id])
	@invitation = Invitation.find(@gift.invitation_id)
	@guest = Guest.find(@invitation.guest_id)
  end

  
  def new(*invite_id)
	@invid=invite_id
    @gift = Gift.new
	@invitations = current_host.invitations.all
	@invitation_hash = Hash.new
	@invitations.each do |i|
	@invitation_hash["#{i.party.name} | #{i.guest.name}"] = i.id
	@invitation_hash.sort
	end
  end

  def create
    @gift = Gift.new(params[:gift])
    if @gift.save
      flash[:notice] = "Successfully created gift."
      redirect_to gifts_path
    else
      render :action => 'new'
    end
  end

  def edit
    @gift = Gift.find(params[:id])
	@invitations = current_host.invitations.all
	@invitation_hash = Hash.new
	@invitations.each do |i|
	@invitation_hash["#{i.party.name} | #{i.guest.name}"] = i.id
	end
  end

  def update
    @gift = Gift.find(params[:id])
    if @gift.update_attributes(params[:gift])
      flash[:notice] = "Successfully updated gift."
      redirect_to gift_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    flash[:notice] = "Successfully destroyed gift."
    redirect_to gifts_url
  end
 
  def send_gift
	@gifty = Gift.find(params[:g])
	@invitation = Invitation.find(@gifty.invitation_id)
	@guest = Guest.find(@invitation.guest_id)
	@gifty.update_attribute(:note_sent_on, Time.now)
	UserMailer.thank_you(@guest, @gifty).deliver
	#redirect_to gifts_url
  end
end

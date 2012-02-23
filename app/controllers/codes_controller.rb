class CodesController < ApplicationController
  def new
  end

  def create
   c = Invitation.authenticate(params[:encode])
   if c
      flash[:notice] = "Valid Code."
      redirect_to(edit_invitation_path(c))
    else
      flash.now[:error] = "Invalid code"
      render :action => 'new'
    end
	
  end

end
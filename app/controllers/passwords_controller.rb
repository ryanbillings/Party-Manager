class PasswordsController < ApplicationController

  def new
  end

  def create
   h = Host.find(Host.for_email(params[:reset]))
   if h
	  pass = Host.random_password
	  h.update_attribute(:password, pass)
      UserMailer.password_reset(h.email, pass).deliver  
      flash[:notice] = "Reset Password."
      redirect_to "/"
    else
      flash.now[:error] = "Invalid email"
	  render :action => 'new'
    end
	
  end


end

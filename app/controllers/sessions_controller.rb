class SessionsController < ApplicationController
  def new
  end

  def create
    host = Host.authenticate(params[:login], params[:password])
    if host
      session[:host_id] = host.id
      flash[:notice] = "Logged in successfully."
      redirect_to_target_or_default("/")
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:host_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to "/"
  end
end

class GuestsController < ApplicationController
before_filter :login_required
  def index
    @guests = Guest.for_host(current_host).all.paginate :page => params[:page], :per_page => 5
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(params[:guest])
	@guest.host_id = current_host.id
    if @guest.save
      flash[:notice] = "Successfully created guest."
      redirect_to @guest
    else
      render :action => 'new'
    end
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def update
    @guest = Guest.find(params[:id])
    if @guest.update_attributes(params[:guest])
      flash[:notice] = "Successfully updated guest."
      redirect_to guest_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
    flash[:notice] = "Successfully destroyed guest."
    redirect_to guests_url
  end
end

class SearchesController < ApplicationController

	def index
	  if params[:search] and params[:search] != ''
	  @parties = Party.find(:all, :conditions => ['name LIKE ? AND host_id = ?', "%#{params[:search]}%", current_host.id]).paginate :page => params[:page], :per_page => 5
	  @guests = Guest.find(:all, :conditions => ['name LIKE ? AND host_id = ?', "%#{params[:search]}%", current_host.id]).paginate :page => params[:page], :per_page => 5
	  @locations = Location.find(:all, :conditions => ['name LIKE ? AND host_id = ?', "%#{params[:search]}%", current_host.id]).paginate :page => params[:page], :per_page => 5
	  else
	  @parties = Array.new
	  @guests = Array.new
	  @locations = Array.new
	  end
	end
end

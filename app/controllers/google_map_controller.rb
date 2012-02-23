class GoogleMapController < ApplicationController
layout nil
  def index
  @lat = params[:lat]
  @lon = params[:lon]
  end

end

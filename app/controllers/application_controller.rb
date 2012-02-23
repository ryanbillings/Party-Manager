class ApplicationController < ActionController::Base
  include ControllerAuthentication
  include DateFormatter
  protect_from_forgery
  
  def current_ability
  @current_ability ||= Ability.new(current_host)
  end
end

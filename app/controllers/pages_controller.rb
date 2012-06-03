require 'httparty'

class PagesController < ApplicationController
  def welcome
    @profiles = get_profiles
  end

  def about
  end
  
  def settings
  end
  
  def updates
  end
  
  private
  
  def get_profiles
    access_token = session[:access_token]
    url = APP_CONFIG["singly_api_base"] + "/profiles"
    HTTParty.get(url, :query => { :access_token => access_token }).parsed_response if access_token
  end
  
end

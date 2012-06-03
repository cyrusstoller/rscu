require 'httparty'

class PagesController < ApplicationController
  def welcome
    @profiles = get_profiles
    
    access_token = session[:access_token]
    url = APP_CONFIG["singly_api_base"] + "/v0/types/statuses_feed"
    @updates = HTTParty.get(url, :query => { :access_token => access_token, :q => "sad", :map => true }) if access_token
  end

  def about
  end
  
  private
  
  def get_profiles
    access_token = session[:access_token]
    url = APP_CONFIG["singly_api_base"] + "/profiles"
    HTTParty.get(url, :query => { :access_token => access_token }).parsed_response if access_token
  end
  
end

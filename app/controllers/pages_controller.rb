require 'httparty'

class PagesController < ApplicationController
  def welcome
    @profiles = get_profiles
    
    @updates = getUpdates(session[:access_token]) if session[:access_token]
  end

  def about
  end
  
  private
  
  def get_profiles
    access_token = session[:access_token]
    url = APP_CONFIG["singly_api_base"] + "/profiles"
    HTTParty.get(url, :query => { :access_token => access_token }).parsed_response if access_token
  end
  
  def getUpdates(access_token)
    temp = []
    url = APP_CONFIG["singly_api_base"] + "/v0/types/statuses_feed"
    
    APP_CONFIG["trigger_words"].each do |word|
      temp += HTTParty.get(url, :query => { :access_token => access_token, :q => word, :dedup => true, :map => true }).parsed_response
    end
    
    temp = temp.uniq do |t|
      t["id"]
    end
    return temp
  end
  
end


require 'net/http'
require 'net/https'

class Alarm < ActiveRecord::Base
  attr_accessible :period, :start_time, :title, :type
  has_many :subscriptions
  def send_notifications
	http = Net::HTTP.new('graph.facebook.com', 443)
	http.use_ssl = true
	res, data = http.get("/oauth/access_token?client_id=#{ENV['FB_APP_ID']}&client_secret=#{ENV['FB_APP_SECRET']}&grant_type=client_credentials")
  	subscriptions.each{|sub|
  		sub.send_notification(res.body)
  	}
  end
end

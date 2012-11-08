# coding: utf-8

require 'net/http'
require 'net/https'
class Subscription < ActiveRecord::Base
  attr_accessible :alarm_id, :user_id
  belongs_to :alarm
  belongs_to :user
  def send_notification

	http = Net::HTTP.new('graph.facebook.com', 443)
	http.use_ssl = true
	res, data = http.get("/oauth/access_token?client_id=#{Setting.facebook_app_id}&client_secret=#{Setting.facebook_secret}&grant_type=client_credentials")
  	href=Rails.application.routes.url_helpers.alarm_path(alarm)
  	msg = "請記得#{alarm.title}"
  	res, data = http.post("/#{user.uid}/notifications?#{res.body}&href=#{href}&template=#{URI::encode(msg)}",'',{'Content-Type'=> 'application/x-www-form-urlencoded'})
  	puts res
  end
end

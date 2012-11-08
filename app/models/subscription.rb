# coding: utf-8

require 'net/http'
require 'net/https'
require 'open-uri'

class Subscription < ActiveRecord::Base
  attr_accessible :alarm_id, :user_id
  belongs_to :alarm
  belongs_to :user
  def send_notification(access_token)
	http = Net::HTTP.new('graph.facebook.com', 443)
	http.use_ssl = true
  	href = URI::encode(Rails.application.routes.url_helpers.alarm_path(alarm))
  	msg = "請記得#{alarm.title}"
  	puts "/#{user.uid}/notifications?#{access_token}&href=#{href}&template=#{URI::encode(msg)}"
  	res, data = http.post("/#{user.uid}/notifications?#{access_token}&href=#{href}&template=#{URI::encode(msg)}",'',{})
  	puts res.body
  end
end

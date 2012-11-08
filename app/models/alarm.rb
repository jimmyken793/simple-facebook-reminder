class Alarm < ActiveRecord::Base
  attr_accessible :period, :start_time, :title, :type
  has_many :subscriptions
  def send_notifications
  	subscriptions.each{|sub|
  		sub.send_notification
  	}
  end
end

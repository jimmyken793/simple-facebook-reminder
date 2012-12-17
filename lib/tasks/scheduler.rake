desc "This task is called by the Heroku scheduler add-on"
TRIGGER_PERIOD = 1.hour
Time.zone = "Taipei"

task :update_feed => :environment do
	triggered_time = Time.zone.now
	Alarm.all.each{|alarm|
		elapsed_time = triggered_time - alarm.start_time
		if elapsed_time % alarm.period < TRIGGER_PERIOD/2
			alarm.send_notifications
		elsif alarm.period - elapsed_time % alarm.period < TRIGGER_PERIOD/2
			alarm.send_notifications
		end
	}
end

task :send_reminders => :environment do
  User.send_reminders
end
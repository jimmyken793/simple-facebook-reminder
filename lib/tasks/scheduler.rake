desc "This task is called by the Heroku scheduler add-on"


task :update_feed => :environment do
	TRIGGER_PERIOD = 1.hour
	Time.zone = "Taipei"
	triggered_time = Time.zone.now
	Alarm.all.each{|alarm|
		elapsed_time = triggered_time - alarm.start_time
		if elapsed_time % alarm.period < TRIGGER_PERIOD/2
			puts "#{alarm.title} triggered"
			alarm.send_notifications
		elsif alarm.period - elapsed_time % alarm.period < TRIGGER_PERIOD/2
			puts "#{alarm.title} triggered"
			alarm.send_notifications
		else
			puts "#{alarm.title} not triggered"
		end
	}
end

task :send_reminders => :environment do
  User.send_reminders
end
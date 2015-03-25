class CustomAlertsEmailsJob < ActiveJob::Base
  queue_as :default

  def perform(latitude, longitude)
    # Do something later
  	alerts = HousingAlert.near([latitude, longitude], 3)
  	alerts.each do |alert|
  		user = alert.user
    	UserMailer.housing_inquiry_email(user, "", "SUPSUPSUP").deliver_now
  	end
  end
end

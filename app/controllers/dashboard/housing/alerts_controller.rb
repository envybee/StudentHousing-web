class Dashboard::Housing::AlertsController < ApplicationController
  def index
  	@my_alerts = current_user.housing_alerts
  end
end

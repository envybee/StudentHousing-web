class RegistrationsController < Devise::RegistrationsController

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if update_resource(resource, account_update_params)
      yield resource if block_given?
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      errors = Hash.new
      resource.errors.full_messages.each do |msg|
      	errors[msg] = msg
      end

      # render :text => flash.inspect
      # return
      redirect_to after_update_path_for(resource), :flash => errors.symbolize_keys
    end
  end

  private
  # Redirect to the URL after modifying Devise resource (Here, our user)
  def after_update_path_for(resource)
    '/dashboard/profile'
  end
end
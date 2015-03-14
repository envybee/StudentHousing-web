class ApiCloudinaryImageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def new
  	image_response = params[:cloudinary_upload_response]
  	image_title = params[:image_title]
  	image_description = params[:image_description]
  	housing_listing_id = params[:housing_listing_id]
  	housing_image = HousingImage.new
  	housing_image.title = image_title
  	housing_image.description = image_description
  	housing_image.housing_listing_id = housing_listing_id
  	housing_image.url = image_response['url']
  	housing_image.secure_url = image_response['secure_url']
  	housing_image.public_id = image_response['public_id']
  	housing_image.save
  	render :json => {:image_response => image_response, :housing_image => housing_image}
  end
end

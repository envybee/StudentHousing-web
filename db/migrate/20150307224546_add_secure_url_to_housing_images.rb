class AddSecureUrlToHousingImages < ActiveRecord::Migration
  def change
  	add_column :housing_images, :secure_url, :string
  end
end

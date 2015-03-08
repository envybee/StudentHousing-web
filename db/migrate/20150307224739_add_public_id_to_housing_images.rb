class AddPublicIdToHousingImages < ActiveRecord::Migration
  def change
  	add_column :housing_images, :public_id, :string
  end
end

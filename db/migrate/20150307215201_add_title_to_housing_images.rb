class AddTitleToHousingImages < ActiveRecord::Migration
  def change
  	add_column :housing_images, :title, :string
  end
end

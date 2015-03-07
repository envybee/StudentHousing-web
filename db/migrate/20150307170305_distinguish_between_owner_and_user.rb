class DistinguishBetweenOwnerAndUser < ActiveRecord::Migration
  def change
	add_column :users, :owner, :bit, null: false
  end
end

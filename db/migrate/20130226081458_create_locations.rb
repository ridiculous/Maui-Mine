class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :region_id
      t.string :latitude, limit: 50
      t.string :longitude, limit: 50
      t.string :address
      t.string :address2
      t.string :zip
      t.string :state, limit: 4
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end

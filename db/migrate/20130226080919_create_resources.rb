class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.string :url, limit: 500
      t.integer :location_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end

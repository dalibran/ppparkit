class CreateSpots < ActiveRecord::Migration[5.0]
  def change
    create_table :spots do |t|
      t.string :sNoPlace
      t.float :lat
      t.float :lng
      t.string :kind
      t.boolean :bike_head
      t.string :payType
      t.integer :hour_rate
      t.integer :max_rate
      t.string :status
      t.string :bike_head_status

      t.timestamps
    end
  end
end

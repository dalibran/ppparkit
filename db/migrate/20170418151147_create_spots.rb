class CreateSpots < ActiveRecord::Migration[5.0]
  def change
    create_table :spots do |t|
      t.string :place_no
      t.decimal :lat, :precision => 17, :scale => 15
      t.decimal :lng, :precision => 17, :scale => 15
      t.string :kind
      t.integer :bike_head
      t.string :pay_type
      t.integer :hour_rate
      t.integer :max_rate
      t.string :status
      t.string :bike_head_status

      t.timestamps
    end
  end
end

class CreateParkIts < ActiveRecord::Migration[5.0]
  def change
    create_table :park_its do |t|
      t.integer :points
      t.string :kind
      t.datetime :paid_until
      t.references :user
      t.references :spot

      t.timestamps
    end
  end
end

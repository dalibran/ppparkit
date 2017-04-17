class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :stars
      t.references :user
      t.references :street_sect

      t.timestamps
    end
  end
end

class CreateRules < ActiveRecord::Migration[5.0]
  def change
    create_table :rules do |t|
      t.integer :rpa_id
      t.string :rpa_description
      t.string :rpa_pic
      t.string :park_hr
      t.string :park_day
      t.numeric :lat
      t.numeric :lng
      t.references :street_sect

      t.timestamps
    end
  end
end

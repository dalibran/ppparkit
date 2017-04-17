class CreateStreetSects < ActiveRecord::Migration[5.0]
  def change
    create_table :street_sects do |t|
      t.numeric :lat
      t.numeric :lng

      t.timestamps
    end
  end
end

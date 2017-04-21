class RenameLatitudeAndLongitude < ActiveRecord::Migration[5.0]
  def up
    rename_column :spots, :lat, :latitude
    rename_column :spots, :lng, :longitude
  end
end

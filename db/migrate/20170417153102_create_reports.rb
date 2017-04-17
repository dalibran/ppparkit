class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.integer :votes
      t.string :time_affected
      t.string :days_affected
      t.string :report_type
      t.string :report_content
      t.references :user
      t.references :street_sect

      t.timestamps
    end
  end
end

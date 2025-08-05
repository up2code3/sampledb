class CreateSampleSegments < ActiveRecord::Migration[8.0]
  def change
    create_table :sample_segments do |t|
      t.references :sample, null: false, foreign_key: true
      t.integer :start_time, null: false

      t.timestamps
    end
  end
end

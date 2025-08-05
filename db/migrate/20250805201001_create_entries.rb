class CreateEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true

      t.string :title, null: false
      t.integer :bpm
      t.string :key
      t.integer :year, null: false
      t.text :notes
      t.string :video_url

      t.timestamps
    end
      add_index :entries, :title
  end
end

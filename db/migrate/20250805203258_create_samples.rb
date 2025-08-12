class CreateSamples < ActiveRecord::Migration[8.0]
  def change
    create_table :samples do |t|
      t.references :sampler_entry, null: false, foreign_key: { to_table: :entries }
      t.references :sampled_entry, null: false, foreign_key: { to_table: :entries }

      t.timestamps
    end
    add_index :samples, [ :sampler_entry_id, :sampled_entry_id ], unique: true
  end
end

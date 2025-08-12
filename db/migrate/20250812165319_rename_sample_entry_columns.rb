class RenameSampleEntryColumns < ActiveRecord::Migration[8.0]
  def change
    # remove the index we put on the table, again, table name and column name (note:array)
    remove_index :samples, column: [ :sampler_entry_id, :sampled_entry_id ]

    # now we can rename, like we did with tracks. (3arg - table, currentValue, newValue)
    rename_column :samples, :sampler_entry_id, :derived_track_id
    rename_column :samples, :sampled_entry_id, :source_track_id

    # now we add the 2 FKs back (3arg - the table , the table it points to , the column)
    add_foreign_key :samples, :tracks, column: :derived_track_id
    add_foreign_key :samples, :tracks, column: :source_track_id

    # finally we add back our indexing, same as syntax as OG migration, but new names.
    add_index :samples, [ :derived_track_id, :source_track_id ], unique: true
  end
end

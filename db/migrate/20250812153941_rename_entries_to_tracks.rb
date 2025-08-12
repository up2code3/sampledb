class RenameEntriesToTracks < ActiveRecord::Migration[8.0]
  def change
    rename_table :entries, :tracks
  end
end

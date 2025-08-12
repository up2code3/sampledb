class RenameCommentsEntryIdToTrackId < ActiveRecord::Migration[8.0]
  def change
    rename_column :comments, :entry_id, :track_id
  end
end

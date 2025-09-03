class Artist < ApplicationRecord
  has_many :tracks, dependent: :destroy

  validates :name, presence: true

  # logic for sample connections, artist + method + each loop
  def sampled_by
    Track.joins(:artist, :samples_used)
       .where(samples: { source_track_id: tracks.select(:id) })
       .select("tracks.title AS track_title, artists.name AS artist_name")
  end
end

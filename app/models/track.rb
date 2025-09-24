class Track < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :artist

  has_many :comments, dependent: :destroy
  # if track is deleted all comments are destroyed

  # track is the sampler (the connection)
  has_many :samples_used,
           class_name: "Sample",
           foreign_key: :derived_track_id,
           dependent: :destroy
  # track is the sampler (the actual track (song))
  has_many :sampled_tracks,
           through: :samples_used,
           source: :source_track

  # the inverse
  # track is being sampled, the samplee (the connection)
  has_many :sampled_by,
           class_name: "Sample",
           foreign_key: :source_track_id,
           dependent: :destroy
  # track is the samplee (the actual track (song))
  has_many :sampled_by_tracks,
           through: :sampled_by,
           source: :derived_track

  validates :title, presence: true
  validates :year, presence: true
  validates :bpm, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  
end

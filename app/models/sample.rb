class Sample < ApplicationRecord
  belongs_to :derived_track, class_name: "Track"
  belongs_to :source_track, class_name: "Track"

  has_many :sample_segments, dependent: :destroy

  validates :derived_track_id, presence: true
  validates :source_track_id,  presence: true
  validate  :no_self_sampling
  validate  :no_sampling_from_future

  # a source id cannot be equal to a derived id on sample join table
  def no_self_sampling
    if derived_track_id == source_track_id
      errors.add(:base, "A track cannot sample itself")
    end
  end

  # check sourceYear exist, derivedYear exist, then if derived is less than source throw error
  def no_sampling_from_future
    if source_track&.year && derived_track&.year && derived_track&.year < source_track&.year
      errors.add(:base, "A track cannot sample from the future")
    end
  end

  # behavior methods
  def description
    "#{derived_track.title} samples #{source_track.title}"
  end
end

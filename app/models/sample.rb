class Sample < ApplicationRecord
    belongs_to :derived_track, class_name: "Track"
    belongs_to :source_track, class_name: "Track"

    has_many :sample_segments, dependent: :destroy

  # TODO Validate later sampler_entry_id can not be equal sampled_entry_id
  # AKA a song can not sample itself or be sampled by itself
end

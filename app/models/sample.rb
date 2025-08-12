class Sample < ApplicationRecord
    belongs_to :sampler_entry, class_name: "Entry"
    belongs_to :sampled_entry, class_name: "Entry"

    has_many :sample_segments, dependent: :destroy

  # TODO Validate later sampler_entry_id can not be equal sampled_entry_id
  # AKA a song can not sample itself or be sampled by itself
end

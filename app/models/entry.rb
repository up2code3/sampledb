class Entry < ApplicationRecord
    belongs_to :user
    belongs_to :artist

    has_many :comments, dependent: :destroy
    # if entry is deleted all comments are destroyed

    # entry is the sampler (the connection)
    has_many :samples_used,
             class_name: "Sample",
             foreign_key: :sampler_entry_id,
             dependent: :destroy
    # entry is the sampler (the actual entry (song))
    has_many :sampled_entries,
             through: :samples_used,
             source: :sampled_entry

    # the inverse
    # entry is being sampled, the samplee (the connection)
    has_many :sampled_by,
             class_name: "Sample",
             foreign_key: :sampled_entry_id,
             dependent: :destroy
    # entry is the samplee (the actual entry (song))
    has_many :sampled_by_entries,
             through: :sampled_by,
             source: :sampler_entry

    validates :title, presence: true
    validates :year, presence: true
    validates :bpm, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end

class SampleSegment < ApplicationRecord
    belongs_to :sample

    validates :start_time, presence: true
  # TODO additioanl validation int only and must be greater than 0
end

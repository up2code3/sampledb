Class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :entry

    validates :body, presence: true
end
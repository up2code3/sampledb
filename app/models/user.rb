Class User < ApplicationRecord
    has_many :entries
    has_many :comments
    #TODO gameplan user.delete, what happens to their entries and comments.

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
end
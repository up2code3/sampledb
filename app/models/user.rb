class User < ApplicationRecord
  has_many :tracks
  #future nullify user id on orphaned tracks?
  has_many :comments,  dependent: :destroy

  has_secure_password

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= "user"
  end

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  def display_username
    "The username is #{username}"
  end
end

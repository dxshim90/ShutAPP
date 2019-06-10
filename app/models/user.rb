class User < ApplicationRecord
  has_secure_password

  has_many :messages
  # has_many :groups, through: :messages

  has_many :members
  has_many :groups, through: :members

  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true

end

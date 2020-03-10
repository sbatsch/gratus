class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :journal_entries
  has_many :prompts, through: :journal_entries
end

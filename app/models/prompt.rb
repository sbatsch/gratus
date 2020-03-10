class Prompt < ApplicationRecord
  has_many :journal_entries
  has_many :users
end
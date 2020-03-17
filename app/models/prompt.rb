class Prompt < ApplicationRecord
  has_many :journal_entries
  has_many :users

enum topic: {
             nature: 0,
             health: 1,
             people: 2,
             yourself: 3
            }
end
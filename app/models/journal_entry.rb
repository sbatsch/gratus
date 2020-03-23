class JournalEntry < ApplicationRecord
  belongs_to :user
  belongs_to :prompt

  validates :body, presence: true 
  validates :gratitude_level, presence: true
  validates :gratitude_change, presence: true
  
  enum gratitude_change: {
                          no_change: 0,
                          less: 1,
                          more: 2
                         }
end

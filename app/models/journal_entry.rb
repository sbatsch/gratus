class JournalEntry < ApplicationRecord
  belongs_to :user
  belongs_to :prompt
  
  enum gratitude_change: {
                          no_change: 0,
                          less: 1,
                          more: 2
                         }
end

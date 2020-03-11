class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :journal_entries
  has_many :prompts, through: :journal_entries

  def gratitude_streak
    ordered_journal_entries = journal_entries.order(date: :desc)
    count = 0
    latest_entry = nil

    # index = 0
    # while index < journal_entries.length - 1
    #   if ordered_journal_entries[index].date == ordered_journal_entries[index + 1].date
    #   elsif ordered_journal_entries[index].date + 1.day == ordered_journal_entries[index + 1].date
    #     count = count + 1
    #   else
    #     break
    #   end

    #    index = index + 1 
    # end 

    ordered_journal_entries.each do |current_entry|
      if !latest_entry
        latest_entry = current_entry
      elsif latest_entry.date == current_entry.date
      elsif latest_entry.date == current_entry.date + 1.day
        count = count + 1
        latest_entry = current_entry
      else
        break
      end
    end

    return count 
  end
end

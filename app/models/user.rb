class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :journal_entries
  has_many :prompts, through: :journal_entries

  def gratitude_streak
    ordered_journal_entries = journal_entries.order(date: :asc)
    last_date = Time.now.to_date
    if journal_entries.last && journal_entries.last.date == last_date
      count = 1
    else
      count = 0
    end

    ordered_journal_entries.each do |current_entry|
      if last_date == current_entry.date
      elsif last_date == current_entry.date - 1.day
        count += 1
        last_date = current_entry.date
      else
        break
      end
    end

    return count 
  end

  def journals_completed
    journal_entries.count
  end

  def report_days
    num_of_days_for_report = 7

    days = []
    num_of_days_for_report.times do |index|
       days << index.days.ago
    end
    return days 
  end

  def formatted_report_days
    report_days.map {|day| day.strftime("%m/%d/%Y")}
  end

  def entries_per_day
    report_days.map {|day| journal_entries.where(date: day).count}
  end

end
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


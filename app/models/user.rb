class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :journal_entries
  has_many :prompts, through: :journal_entries



  def gratitude_streak
    ordered_journal_entries = journal_entries.order(date: :DESC)
    last_date = Time.now.to_date
    if journal_entries.last && journal_entries.last.date == last_date
      count = 1
    else
      count = 0
    end

    ordered_journal_entries.each do |current_entry|
      if last_date == current_entry.date
      elsif last_date == current_entry.date + 1.day
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


####################################################################
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

  ####################################################################

  def topic_breakdown
    topics = []
    journal_entries.each do |journal_entry|
      topics << journal_entry.prompt.topic
    end
    
    topic_count = {}
    topics.each do |topic| 
      if topic_count[topic]
        topic_count[topic] += 1
      else
        topic_count[topic] = 1
      end 
    end 
    topic_array = []
    topic_count.each do |topic, count|
      topic_array << {name: topic, y: count}
    end
    return topic_array
  end

  ####################################################################


  def random_topic
    # topic_breakdown = [
    #                   {:name=>"health", :y=>1}, 
    #                   {:name=>"people", :y=>3}, 
    #                   {:name=>"yourself", :y=>2}
    #                   ]

    total = topic_breakdown.sum {|topic_hash| topic_hash[:y]}

    topic_percentages = []
    topic_breakdown.each do |topic_hash|
      topic_percentages << {
                            percentage: (topic_hash[:y] / total.to_f) * 100,
                            topic: topic_hash[:name]
                          }
    end

    roll_the_dice = rand(1..100)
    percentage_boundary = 0

    topic_percentages.each do |percentage_hash|
      percentage_boundary += percentage_hash[:percentage] 
      return percentage_hash[:topic] if roll_the_dice <= percentage_boundary
    end
  end



############################################

  def average(topic_name)
    entries = journal_entries.select { |journal_entry| journal_entry.prompt.topic == topic_name }

    count = entries.length
    return 1 if count == 0

    sum = entries.sum { |entry| entry.gratitude_level }
    sum / count
  end

  def topic_percents
    nature_avg = average("nature")
    yourself_avg = average("yourself")
    people_avg = average("people")
    health_avg = average("health")

    total = nature_avg + yourself_avg + people_avg + health_avg

    [
      {
        topic: 'nature',
        percentage: (nature_avg/total.to_f) * 100
      },
      {
        topic: 'yourself',
        percentage: (yourself_avg/total.to_f) * 100
      },
      {
        topic: 'people',
        percentage: (people_avg/total.to_f) * 100
      },
      {
        topic: 'health',
        percentage: (health_avg/total.to_f) * 100
      }
    ]
  end

  def generate_topic
    # topic_percentages = [
    #                      {:topic=>"health", :percentage=>33.0}
    #                     ]
    roll_the_dice = rand(1..100)
    percentage_boundary = 0

    topic_percents.each do |percentage_hash|
      percentage_boundary += percentage_hash[:percentage]
      return percentage_hash[:topic] if roll_the_dice <= percentage_boundary
    end
  end

  ####################################################

  def enum_entries(enum)
    entries = journal_entries.select { |journal_entry| journal_entry.gratitude_change == enum }

      entries.length  
  end

  def change
    no_change_amount = enum_entries("no_change")
    less_amount = enum_entries("less")
    more_amount = enum_entries("more")

    [
      {
        name: 'no_change',
        y: no_change_amount
      },
      {
        name: 'less',
        y: less_amount
      },
      {
        name: 'more',
        y: more_amount
      }
    ]
  end

####################################################################

  # def report_days
  #   num_of_days_for_report = 7

  #   days = []
  #   num_of_days_for_report.times do |index|
  #      days << index.days.ago
  #   end
  #   return days 
  # end

  # def formatted_report_days
  #   report_days.map {|day| day.strftime("%m/%d/%Y")}
  # end

  # def entries_per_day
  #   report_days.map {|day| journal_entries.where(date: day).count}
  # end

  # def nature_average
  #   nature_entries = journal_entries.select {|journal_entry| journal_entry.prompt.nature? }
  #   count = nature_entries.length
  #   sum = 0

  #   nature_entries.each do |journal_entry|
  #     sum += journal_entry.gratitude_level
  #   end

  #   average = sum/count

  #   if average < 1
  #     1
  #   else
  #     average
  #   end
  # end

  # def topic_percentages
  #   nature_avg = nature_average
  #   yourself_avg = yourself_average
  #   people_avg = people_average
  #   health_avg = health_average

  #   total = nature_avg + yourself_avg + people_avg + health_avg

  #   [
  #     {
  #       topic: 'nature',
  #       percentage: (nature_avg/total.to_f) * 100
  #     },
  #     {
  #       topic: 'yourself',
  #       percentage: (yourself_avg/total.to_f) * 100
  #     },
  #     {
  #       topic: 'nature',
  #       percentage: (nature_avg/total.to_f) * 100
  #     },
  #     {
  #       topic: 'nature',
  #       percentage: (nature_avg/total.to_f) * 100
  #     }
  #   ]
  # end



  # nature   - 9 # 90%
  # nature   - 8 # 90%
  # nature   - 8 # 90%
  # nature   - 8 # 90%
  # nature   - 1 # 90%
  # nature   - 1 # 90%
  # average 8.1

  # yourself - 1 # 10%
  # average 1

  # people - ?
  # average min 1

  # total 9.1


  # topic_percentages = []

  # topic_percentages << {
  #                     topic: 'nature',
  #                     percentage: (8.5/9.1) * 100
  #                     }

end 


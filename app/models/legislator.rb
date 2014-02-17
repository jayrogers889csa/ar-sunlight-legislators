require_relative '../../db/config'

class Legislator < ActiveRecord::Base
  has_many :tweets

  # validates :phone, uniqueness: true
  # validates :fax, uniqueness: true
  # validate :format_phone
  # validate :format_fax

  def self.print_state_legislators(state)
    puts "Senators: "
    self.where("state = ? AND title = 'Sen'", state).order(lastname: :asc).each do |legislator|
      puts " #{legislator[:firstname]} #{legislator[:lastname]} (#{legislator[:party]}) "
    end
    puts "Representatives: "
    self.where("state = ? AND title = 'Rep'", state).order(lastname: :asc).each do |legislator|
      puts " #{legislator[:firstname]} #{legislator[:lastname]} (#{legislator[:party]}) "
    end
  end

  def self.list_states_by_active_legislators_count
    self.select("state").group("state").select_representatives.count.sort_by { |state, count| count}.reverse.each { |pair| puts "#{pair[0]}: #{self.select_by_state(pair[0]).select_active.select_senators.count} Senators, #{pair[1]} Representative(s)" }
  end

  def self.gender_statistics(type)
    puts "#{type} Senators: #{self.select_active.select_senators.select_gender(type).count} (#{self.gender_percentage_senators_active(type)}%)"
    puts "#{type} Representatives: #{self.select_active.select_representatives.select_gender(type).count} (#{self.gender_percentage_representatives_active(type)}%)"
  end

  def self.gender_percentage_senators_active(type)
    (((self.select_active.select_senators.select_gender(type).count.to_f)/(self.select_active.select_senators.count.to_f))*100).to_i
  end

  def self.gender_percentage_representatives_active(type)
    (((self.select_active.select_representatives.select_gender(type).count.to_f)/(self.select_active.select_representatives.count.to_f))*100).to_i
  end

  def self.senator_count
    puts "Senators: #{self.select_senators.count}"
  end

  def self.representative_count
    puts "Representatives: #{self.select_representatives.count}"
  end

  def self.select_active
    self.where("in_office = '1'")
  end

  def self.select_non_active
    self.where("in_office = '0'")
  end

  def self.select_gender(type)
    self.where("gender = ?", type)
  end

  def self.select_senators
    self.where("title = 'Sen'")
  end

  def self.select_representatives
    self.where("title = 'Rep'")
  end

  def self.delete_non_active
    self.delete(select_non_active)
  end

  def self.select_by_state(state)
    self.where("state = ?", state)
  end

end

























#   def age
#     now = Date.today
#     age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
#     age
#   end

#   def name
#     "#{first_name} #{last_name}"
#   end

#   def check_phone
#     if self.phone.gsub('/\D/', "").length < 10
#       errors.add(:phone, "numbers require at least 10 digits")
#     end
#   end

# end

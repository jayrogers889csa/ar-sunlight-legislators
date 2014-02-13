require_relative '../../db/config'

class Legislator < ActiveRecord::Base
  # attr_reader :phone

  # belongs_to :teacher

  # validates :email, uniqueness: true, format: { with: /.+@[^.]+\..{2,}/, message: "only proper email format allowed" }
  # validates :age, numericality: { greater_than: 5 }
  # # validate :check_phone




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

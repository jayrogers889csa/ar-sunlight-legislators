require_relative '../db/config'
require_relative '../app/models/legislator.rb'

# Legislator.print_state_legislators('CA')

Legislator.print_state_legislators('GA')

puts "---"

Legislator.gender_statistics('F')

Legislator.gender_statistics('M')

puts "---"

Legislator.list_states_by_active_legislators_count

puts "---"

Legislator.senator_count

Legislator.representative_count

puts "---"

Legislator.delete_non_active

puts "---"

Legislator.senator_count

Legislator.representative_count



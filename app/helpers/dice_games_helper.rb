module DiceGamesHelper
	def self.update_analytics(score)
		#what analytics do I want to keep?
		data = Datum.all.first
		old_value = get_old_value(score, data)
		new_value = old_value + 1


		
	end

	def get_old_value(score, data)
		old_value = 0
		case score
		when 1
			old_value = data.one
		when 2
			old_value = data.two
		when 3
			old_value = data.three
		when 4
			old_value = data.four
		when 5
			old_value = data.five
		when 6
			old_value = data.six
		end
		return old_value
	end

	def self.get_data
	end
end

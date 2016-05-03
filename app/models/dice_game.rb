class DiceGame < ActiveRecord::Base
	def roll
		prng = Random.new
		number = prng.rand(1..6)
		self.score = number
		self.save
	end
end

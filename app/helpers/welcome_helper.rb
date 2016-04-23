module WelcomeHelper
	def self.make_data
		alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
		data_hash = {}
		alphabet.each_with_index { |item, index|
			prng = Random.new(index)
			number = prng.rand(500)
			data_hash[item] = number
		}
		return data_hash
	end
end

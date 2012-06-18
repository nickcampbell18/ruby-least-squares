load 'statistics.rb'

class Fund
	include FundStats

	def values
		# Show example values for last 7 days
		v = [10, 12, 11, 13, 10, 8, 9]
	end

end
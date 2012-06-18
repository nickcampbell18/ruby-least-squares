module Enumerable
  def inject_with_index(injected)
    each_with_index{ |obj, index| injected = yield(injected, obj, index) }
    injected
  end
end

module FundStats
	require 'matrix'

	def count
		values.length
	end

	def sum
		values.inject(0){ |a,i| a+i }
	end

	alias_method :sig_y, :sum

	def sample_variance
		m = self.sum / values.length.to_f
		sum = values.inject(0){ |a,i| a + (i-m)**2 }
		sum / ( count - 1 ).to_f
	end

	def standard_deviation
		Math.sqrt self.sample_variance
	end

	# Least squares methods
	def sig_x
		(1..count).inject(:+)
	end

	def sig_xy
		values.inject_with_index(0) do |count, y, x|
			count += ( x + 1 ) * y
		end
	end

	def sig_x_squared
		(1..count).map{ |n| n**2 }.inject :+
	end

	def least_squares
		# emathzone.com/tutorials/basic-statistics/example-method-of-least-squares.html
		# Construct a matrix for variables above
		m = Matrix[ [count, sig_x] , [sig_x, sig_x_squared] ]
		# Solve matrix with expected values
		v = m.lup.solve [sig_y, sig_xy]
		# => Vector([a, b])
		# Convert to a and b values
		v.to_a.map!{ |v| v.to_f.round(2) }
	end

end
require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/gym_class.rb')

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

class GymClassTest < Minitest::Test

	def setup

	end

end

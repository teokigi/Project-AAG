# Session  - class name your testing, note: you need to capitalize
# >bravo<  - file name of class in models/ directory
require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/session.rb')
require_relative('../models/gym_class.rb')

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

class SessionTest < Minitest::Test

	def setup
		@test_gym_class = GymClass.new({'name'=>'Test_seed'})
		@test_gym_class.create
		@test_session = Session.new({'name'=>'Test'})
	end

	def test_001_add_testing
		assert(false)
	end

	def test_002_find_all_testing
		before_length = Session.find_all
		#method if returns nil should be set to 0, else count how many
		#values are returned with .length
		if before_length == nil
			before_length = 0
		else
			before_length = before_length.length
		end
		# registering test seed data
		class_test = Session.new(???)
		#find the count of returned entries after registering test seed
		after_length = Session.find_all.length
		change_in_length = after_length - before_length
		assert_equal(1, change_in_length)
		#remove seeded data after testing
		class_test.delete
	end

	def test_003_find_testing

	end

	def test_004_update_testing
	end

	def test_005_delete_testing

	end


end

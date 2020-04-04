require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/gym_class.rb')

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

class GymClassTest < Minitest::Test

	def setup
		@class01 = GymClass.new({'name'=>'Test'})
	end

	def test_001_save_testing
		#creating seed data
		class01 = GymClass.new(@class01.create)
		assert_equal('active',class01.find.status)
		assert_equal('Test',class01.find.name)
		#deletes seed data from table
		class01.delete
	end

	def test_002_find_testing
		class01 = GymClass.new(@class01.create)
		assert_equal('Test',class01.find.name)
		class01.delete
	end

	def test_003_find_all_testing
		before_length = GymClass.find_all
		#method if returns nil should be set to 0, else count how many
		#values are returned with .length
		if before_length == nil
			before_length = 0
		else
			before_length = before_length.length
		end
		# registering test seed data
		class_test = GymClass.new(@standard_member01.register)
		#find the count of returned entries after registering test seed
		after_length = GymClass.find_all.length
		change_in_length = after_length - before_length
		assert_equal(1, change_in_length)
		#remove seeded data after testing
		class_test.delete
	end

	def test_004_update_testing
		class01 = GymClass.new(@class01.create)
		class01.name = "UpdateTesting"
		class01.update
		assert_equal('UpdateTesting',class01.find.name)
		class01.status = "inactive"
		class01.update
		assert_equal('inactive',class01.status)
		class01.delete
	end

	def test_005_delete_testing
		class01 = GymClass.new(@class01.create)
		class01.delete
		refute(class01.find)
	end

	def test_006_deactivate_active_toggle_testing
		gym_class = GymClass.new(@class01.create)
		gym_class.toggle_status
		assert_equal('inactive',gym_class.find.status)
		gym_class.toggle_status
		assert_equal('active',gym_class.find.status)
		gym_class.delete
	end
end

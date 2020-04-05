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
		class01 = @class01.create
		assert_equal('active',class01.find.status)
		assert_equal('Test',class01.find.name)
		#deletes seed data from table
		class01.delete
	end

	def test_002_find_testing
		class01 = @class01.create
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
		# creating test seed data
		class_test = @class01.create
		#find the count of returned entries after creating test seed
		after_length = GymClass.find_all.length
		change_in_length = after_length - before_length
		assert_equal(1, change_in_length)
		#remove seeded data after testing
		class_test.delete
	end

	def test_004_update_testing
		class01 = @class01.create
		class01.name = "UpdateTesting"
		class01.update
		assert_equal('UpdateTesting',class01.find.name)
		class01.status = "inactive"
		class01.update
		assert_equal('inactive',class01.status)
		class01.delete
	end

	def test_005_delete_testing
		class01 = @class01.create
		class01.delete
		refute(class01.find)
	end

	def test_006_deactivate_active_toggle_testing
		gym_class = @class01.create
		gym_class.toggle_status
		assert_equal('inactive',gym_class.find.status)
		gym_class.toggle_status
		assert_equal('active',gym_class.find.status)
		gym_class.delete
	end

	def test_007_delete_by_id_testing
		#generates a new id assigning it to gym_class
		gym_class = @class01.create
		id = gym_class.id
		#deletes table entry where id matches gym_class
		GymClass.delete_by_id(id)
		#finding gym_class should return nil
		refute(gym_class.find)
	end

	def test_008_find_by_id_testing
		gym_class = @class01.create
		id = gym_class.id
		assert_equal('Test',GymClass.find_by_id(id).name)
		#removes test seed
		gym_class.delete
	end
end

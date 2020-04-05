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
		@test_gym_class = @test_gym_class.create
		@test2_gym_class = GymClass.new({'name'=>'test2_seed'})
		@test_session = Session.new({	'gym_class_id'=>@test_gym_class.id,
										'time_slot'=>'0900',
										'maximum_bookings'=>30})
	end

	def test_001_create_testing
		test_session = @test_session.create
		assert_equal('0900',test_session.find.time_slot)
		assert(test_session.find.gym_class_id)
		assert_equal('active',test_session.status)
		assert_equal(30,test_session.maximum_bookings)
		assert_equal(30,test_session.available_bookings)
		@test_gym_class.delete
		test_session.delete
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
		test_session = @test_session.create
		#find the count of returned entries after registering test seed
		after_length = Session.find_all.length
		change_in_length = after_length - before_length
		assert_equal(1, change_in_length)
		#remove seeded data after testing
		@test_gym_class.delete
		test_session.delete
	end

	def test_003_find_testing
		test_session = @test_session.create
		id = test_session.id
		assert_equal(id,test_session.find.id)

		@test_gym_class.delete
		test_session.delete
	end

	def test_004_update_testing
		test2_gym_class = @test2_gym_class.create
		test_session = @test_session.create
		test_session.time_slot = '1000'
		test_session.maximum_bookings = 20
		test_session.available_bookings = 10
		test_session.status = 'inactive'
		test_session.gym_class_id = test2_gym_class.id
		test_session.update
		assert_equal('1000',test_session.find.time_slot)
		assert_equal(20,test_session.find.maximum_bookings)
		assert_equal(10,test_session.find.available_bookings)
		assert_equal('inactive',test_session.find.status)
		assert_equal(test2_gym_class.id,test_session.find.gym_class_id)

		@test_gym_class.delete
		test2_gym_class.delete
		test_session.delete
	end

	def test_005_delete_testing
		test_session = @test_session.create
		assert(test_session.find)
		test_session.delete
		refute(test_session.find)

		@test_gym_class.delete
		test_session.delete
	end

	def test_006_deactivate_active_toggle_testing
		test_session = Session.new({	'name'=>'Test',
										'gym_class_id'=>@test_gym_class.id,
										'time_slot'=>'0900',
										'maximum_bookings'=>30})
		test_session = test_session.create

		test_session.toggle_status
		assert_equal('inactive',test_session.find.status)
		test_session.toggle_status
		assert_equal('active',test_session.find.status)

		test_session.delete
		@test_gym_class.delete
	end

	def test_007_find_sessions_with_gym_class_id_testing
		before_length = Session.find_sessions_with_gym_class_id(@test_gym_class.id)
		refute(before_length)
		#method if returns nil should be set to 0, else count how many
		#values are returned with .length
		if before_length == nil
			before_length = 0
		else
			before_length = before_length.length
		end
		# registering test seed data
		test_session = @test_session.create
		#find the count of re	turned entries after registering test seed
		after_length = Session.find_sessions_with_gym_class_id(@test_gym_class.id).length
		change_in_length = after_length - before_length
		assert_equal(1, change_in_length)
		#remove seeded data after testing
		@test_gym_class.delete
		test_session.delete
	end

	def test_008_delete_by_id_testing
		#generates a new id assigning it to standard_member
		test_session = @test_session.create
		assert(test_session)
		id = test_session.id
		#deletes table entry where id matches standard_member
		Session.delete_by_id(id)
		#finding standard_member should return nil
		refute(test_session.find)
	end


end

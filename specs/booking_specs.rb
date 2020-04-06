
require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/booking.rb')
require_relative('../models/member.rb')
require_relative('../models/gym_class.rb')
require_relative('../models/session.rb')

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

class BookingTest < Minitest::Test

	def setup
		@standard_member01 = Member.new({'first_name'=>'Test',
									'last_name'=>'Seed',
									'account_type'=>'Standard'})
		@standard_member01 = @standard_member01.create
		@class01 = GymClass.new({'name'=>'Test'})
		@class01 = @class01.create
		@test_session = Session.new({	'gym_class_id'=>@class01.id,
										'time_slot'=>'0900',
										'maximum_bookings'=>1})
		@test_session = @test_session.create
		@test_booking = Booking.new({	'session_id'=>@test_session.id,
										'member_id'=>@standard_member01.id})

	end

	def test_001_save_testing
		test_booking = @test_booking.create
		session_id = @test_session.id.to_i
		assert_equal(session_id,test_booking.find.session_id)
		member_id = @standard_member01.id.to_i
		assert_equal(member_id,test_booking.find.member_id)

		test_booking.delete
		@test_session.delete
		@standard_member01.delete
		@class01.delete
	end

	def test_002_find_all_testing
		before_length = Booking.find_all
		#method if returns nil should be set to 0, else count how many
		#values are returned with .length
		if before_length == nil
			before_length = 0
		else
			before_length = before_length.length
		end
		# registering test seed data
		test_booking = @test_booking.create
		#find the count of returned entries after registering test seed
		after_length = Booking.find_all.length
		change_in_length = after_length - before_length
		assert_equal(1, change_in_length)
		#remove seeded data after testing
		test_booking.delete
		@test_session.delete
		@standard_member01.delete
		@class01.delete

	end

	def test_003_find_testing
		test_booking = @test_booking.create
		session_id = @test_session.id.to_i
		assert_equal(session_id,test_booking.find.session_id)

		test_booking.delete
		@test_session.delete
		@standard_member01.delete
		@class01.delete
	end

	def test_005_delete_testing
		test_booking = @test_booking.create
		assert(test_booking.find)
		test_booking.delete
		refute(test_booking.find)
		@test_session.delete
		@standard_member01.delete
		@class01.delete
	end
	def test_006_find_bookings_with_session_id_testing
		before_length = Booking.find_bookings_with_session_id(@test_session.id)
		refute(before_length)
		#method if returns nil should be set to 0, else count how many
		#values are returned with .length
		if before_length == nil
			before_length = 0
		else
			before_length = before_length.length
		end
		# registering test seed data
		test_booking = @test_booking.create
		#find the count of re	turned entries after registering test seed
		after_length = Booking.find_bookings_with_session_id(@test_session.id).length
		change_in_length = after_length - before_length
		assert_equal(1, change_in_length)
		#remove seeded data after testing
		test_booking.delete
		@test_session.delete
		@standard_member01.delete
		@class01.delete
	end

	def test_007_delete_by_id_testing
		#generates a new id assigning it to standard_member
		test_booking = @test_booking.create
		assert(test_booking)
		id = test_booking.id
		#deletes table entry where id matches standard_member
		Booking.delete_by_id(id)
		#finding standard_member should return nil
		refute(test_booking.find)
		@test_session.delete
		@standard_member01.delete
		@class01.delete
	end

	def test_008_find_by_id_testing
		test_booking = @test_booking.create
		id = test_booking.id
		assert_equal(id,Booking.find_by_id(id).id)
		#removes test seed
		test_booking.delete
		@test_session.delete
		@standard_member01.delete
		@class01.delete
	end

	def test_009_availability_screening_test

		before_length = Booking.find_all.length
		test_booking = @test_booking.create
		midway_length = Booking.find_all.length
		assert_equal(1,midway_length - before_length)
		test2_booking = @test_booking.create
		final_length = Booking.find_all.length
		assert_equal(0,final_length - midway_length)
		test_booking.delete
		@test_session.delete
		@standard_member01.delete
		@class01.delete
	end

	def test_010_minus_1_availability_test
		before_availability = @test_session.find.available_bookings
		test_booking = @test_booking.create
		after_availability = @test_session.find.available_bookings
		change_in_length = after_availability - before_availability
		assert_equal(-1,change_in_length)
		test_booking.delete
		@test_session.delete
		@standard_member01.delete
		@class01.delete
	end

	def test_011_plus_1_availability_test
			test_booking = @test_booking.create
			before_availability = @test_session.find.available_bookings
			test_booking.delete
			after_availability = @test_session.find.available_bookings
			change_in_length = after_availability - before_availability
			assert_equal(1,change_in_length)
			@test_session.delete
			@standard_member01.delete
			@class01.delete
	end

	def test_012_screen_time_slot
		#create a booking, important point being member and time slot
		test_booking = @test_booking.create
		#make a new gym class, with similar 0900 time slot
		class02 = GymClass.new({'name'=>'Test2'}).create
		test2_session = Session.new({ 'gym_class_id'=>class02.id,
								'time_slot'=>'0900',
								'maximum_bookings'=>20}).create
		#run a second booking attempt with the same member and same time slot
		test2_booking = Booking.new({	'session_id'=>test2_session.id,
										'member_id'=>@standard_member01.id}).create
		#should return a string without saving data
		assert_equal("booking conflict, with time slot",test2_booking)
		test_booking.delete
		@test_session.delete
		test2_session.delete
		@standard_member01.delete
		@class01.delete
		class02.delete
	end
end

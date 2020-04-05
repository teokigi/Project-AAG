
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
		@standard_member01 = Member.new({	'first_name'=>'Test',
									'last_name'=>'Seed',
									'account_type'=>'Standard'})
		@standard_member01 = @standard_member01.create
		@class01 = GymClass.new({'name'=>'Test'})
		@class01 = @class01.create
		@test_session = Session.new({	'gym_class_id'=>@class01.id,
										'time_slot'=>'0900',
										'maximum_bookings'=>30})
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

	def test_004_update_testing
		test_booking = @test_booking.create
		test_booking.status = 'inactive'
		test_booking.update
		assert_equal('inactive',test_booking.find.status)

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

end

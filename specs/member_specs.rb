require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/member.rb')

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

class Membertest < Minitest::Test

	def setup
		@standard_member01 = Member.new({	'first_name'=>'Test',
											'last_name'=>'Seed',
											'account_type'=>'Standard'})
	end

	def test_001_create_testing
		standard_member = @standard_member01.create
		#uses find function to find seed data by id.
		#and tests if all iformation is accurate.
		assert_equal('Test', standard_member.find.first_name)
		assert_equal('Seed', standard_member.find.last_name)
		assert_equal('Standard', standard_member.find.account_type)
		assert_equal('active', standard_member.find.status)
		#removes test seed
		standard_member.delete
	end

	def test_002_find_testing
		standard_member = @standard_member01.create
		assert_equal('Test',standard_member.find.first_name)
		#removes test seed
		standard_member.delete
	end

	def test_003_find_all_testing

		before_length = Member.find_all

		#method if returns nil should be set to 0, else count how many
		#values are returned with .length
		if before_length == nil
			before_length = 0
		else
			before_length = before_length.length
		end
		# createing test seed data
		standard_member = @standard_member01.create
		#find the count of returned entries after createing test seed
		after_length = Member.find_all.length
		change_in_length = after_length - before_length
		assert_equal(1, change_in_length)
		#remove seeded data after testing
		standard_member.delete
	end


	def test_004_delete_testing_and_find_failed_testing
		#generates a new id assigning it to standard_member
		standard_member = @standard_member01.create
		#deletes table entry where id matches standard_member
		standard_member.delete
		#finding standard_member should return nil
		refute(standard_member.find)
	end

	def test_005_Update_testing
		standard_member = @standard_member01.create
		standard_member.first_name = "Updatetest"
		standard_member.update
		assert_equal('Updatetest',standard_member.find.first_name)
		standard_member.last_name = "Updatetest2"
		standard_member.update
		assert_equal('Updatetest2',standard_member.find.last_name)
		standard_member.account_type = "test"
		standard_member.update
		assert_equal('test',standard_member.find.account_type)
		standard_member.status = "inactive"
		standard_member.update
		assert_equal('inactive',standard_member.find.status)
		standard_member.delete
	end

	def test_006_deactivate_active_toggle_testing
		standard_member = @standard_member01.create
		standard_member.toggle_status
		assert_equal('inactive',standard_member.find.status)
		standard_member.toggle_status
		assert_equal('active',standard_member.find.status)
		standard_member.delete
	end
end

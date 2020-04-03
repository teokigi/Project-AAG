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

	def test_001_register_testing
		standard_member = Member.new(@standard_member01.register)
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
		standard_member = Member.new(@standard_member01.register)
		assert_equal('Test',standard_member.find.first_name)
		#removes test seed
		standard_member.delete
	end


	def test_003_delete_testing_and_find_failed_testing
		#generates a new id assigning it to standard_member
		standard_member = Member.new(@standard_member01.register)
		#deletes table entry where id matches standard_member
		standard_member.delete
		#finding standard_member should return nil
		refute(standard_member.find)
	end

	def test_004_Update_testing
		standard_member = Member.new(@standard_member01.register)
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

	def test_005_deactivate_active_toggle_testing
		standard_member = Member.new(@standard_member01.register)
		standard_member.toggle_status
		assert_equal('inactive',standard_member.find.status)
		standard_member.toggle_status
		assert_equal('active',standard_member.find.status)
		standard_member.delete
	end
end

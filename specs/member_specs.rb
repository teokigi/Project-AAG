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
		assert_equal('Test', standard_member.first_name)
		assert_equal('Seed', standard_member.last_name)
		assert_equal('Standard', standard_member.account_type)
	end
end

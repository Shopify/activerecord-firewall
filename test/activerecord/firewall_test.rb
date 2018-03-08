require 'test_helper'

class Activerecord::Firewall::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Activerecord::Firewall
  end
end

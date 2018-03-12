require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  setup do
    # Hack to autoload the current class :(
    Current
    @goodbob = users(:goodbob)
    @evilbob = users(:evilbob)

    @goodbobs_image = images(:goodbobs_image)
    @evilbobs_image = images(:evilbobs_image)

    @log_msg = "[activerecord-firewall] Image from User #{@goodbob.id} was accessed from User #{@evilbob.id}"

    Current.user = @evilbob
  end

  teardown do
    Current.reset
  end

  test "image belonging to evil bob is accessible by evil bob with no log messages" do
    assert_nothing_raised do
      assert_not_logged(@log_msg) do
        Image.where(user: @evilbob).first
      end
    end
  end

  test "image belonging to good bob is accessible by evil bob with no log messages" do
    assert_nothing_raised do
      assert_logged(@log_msg) do
        Image.where(user: @goodbob).first
      end
    end
  end
end

require 'test_helper'
require 'minitest/mock'

class FirewalledIdTypeTest < ActiveSupport::TestCase
  test "type cast big integer from integer" do
    context = mock_current_shop_id(1)

    type = ActiveRecord::FirewalledIDType.new("Blog", "shop", context)
    assert_equal 1, type.cast(1)
  end

  test "type cast big integer from string" do
    context = mock_current_shop_id(1)

    type = ActiveRecord::FirewalledIDType.new("Blog", "shop", context)
    assert_equal 1, type.cast("1")
  end

  test "small values" do
    context = mock_current_shop_id(-9999999999999999999999999999999)

    type = ActiveRecord::FirewalledIDType.new("Blog", "shop", context)
    assert_equal(-9999999999999999999999999999999, type.serialize(-9999999999999999999999999999999))
  end

  test "large values" do
    context = mock_current_shop_id(9999999999999999999999999999999)

    type = ActiveRecord::FirewalledIDType.new("Blog", "shop", context)
    assert_equal 9999999999999999999999999999999, type.serialize(9999999999999999999999999999999)
  end

  test "raise on serialize when the current type is not the same as the value" do
    context = mock_current_shop_id(1)

    type = ActiveRecord::FirewalledIDType.new("Blog", "shop", context)

    assert_raise ActiveRecord::FirewalledIDType::FirewalledAccess do
      type.serialize(2)
    end
  end

  test "raise on cast when the current type is not the same as the value" do
    context = mock_current_shop_id(1)

    type = ActiveRecord::FirewalledIDType.new("Blog", "shop", context)

    assert_raise ActiveRecord::FirewalledIDType::FirewalledAccess do
      type.cast(2)
    end
  end

  test "raise on deserialize when the current type is not the same as the value" do
    context = mock_current_shop_id(1)

    type = ActiveRecord::FirewalledIDType.new("Blog", "shop", context)

    assert_raise ActiveRecord::FirewalledIDType::FirewalledAccess do
      type.deserialize(2)
    end
  end

  private

  def mock_current_shop_id(id)
    shop = Minitest::Mock.new
    shop.expect(:id, id)

    context = Minitest::Mock.new
    context.expect(:shop, shop)
    context
  end
end

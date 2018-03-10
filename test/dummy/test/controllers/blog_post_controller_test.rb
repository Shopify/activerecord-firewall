require 'test_helper'

class BlogPostControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Hack to autoload the current class :(
    Current
    @goodbob = users(:goodbob)
    @evilbob = users(:evilbob)

    @goodbobs_post = blog_posts(:goodbobs_post)
    @evilbobs_post = blog_posts(:evilbobs_post)
    Current.user = @evilbob
  end

  teardown do
    Current.reset
  end

  test 'Evil bob can get to his blog post' do
    assert_nothing_raised do
      BlogPost.where(user: @evilbob).first
    end
  end

  test 'Evil bob cannot get to good bob\'s blog post' do
    assert_raise ActiveRecord::FirewalledIDType::FirewalledAccess do
      BlogPost.where(user: @goodbob).first
    end
  end
end

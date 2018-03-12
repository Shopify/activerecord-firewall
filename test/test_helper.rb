# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
require "rails/test_help"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Rails::TestUnitReporter.executable = 'bin/test'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def assert_logged(message)
    old_logger = Rails.logger
    log = StringIO.new
    Rails.logger = Logger.new(log)

    begin
      yield

      log.rewind
      assert_match message, log.read
    ensure
      Rails.logger = old_logger
    end
  end

  # Add more helper methods to be used by all tests here...
  def assert_not_logged(message)
    old_logger = Rails.logger
    log = StringIO.new
    Rails.logger = Logger.new(log)

    begin
      yield

      log.rewind
      assert_no_match message, log.read
    ensure
      Rails.logger = old_logger
    end
  end
end

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end

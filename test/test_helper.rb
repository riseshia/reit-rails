require "coveralls"
Coveralls.wear!

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"

Dir[Rails.root.join("test", "supports", "**", "*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

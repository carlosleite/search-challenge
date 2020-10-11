ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

# To fake the search engines pages parse
module SearchPageMock
  def google_mock
    Nokogiri::HTML('<html><body><div class="g"><div class="rc"><h3>Github</h3></div></div>
                                      <div class="g"><div class="rc"><h3>Github</h3></div></div></body></html>')
  end
  def bing_mock
    Nokogiri::HTML('<html><body><div class="b_algo"><div class="b_title"><h2><a>Github</a></h2></div></div>
                                      <div class="b_algo"><div class="b_title"><h2><a>Github</a></h2></div></div></body></html>')
  end
end
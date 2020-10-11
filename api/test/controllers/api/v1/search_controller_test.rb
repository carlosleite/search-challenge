require 'test_helper'

class Api::V1::SearchControllerTest < ActionDispatch::IntegrationTest
  include SearchPageMock

  test "should return an empty array 'results' for no :text given" do
    get api_v1_search_url, as: :as_json
    assert_response :success
    json_response = JSON.parse(self.response.body)

    assert_empty json_response['results'], 'results is not empty'
  end

  test "should return the google results" do
    GoogleSearch.any_instance.stubs(:parsed_page).returns(google_mock)

    get api_v1_search_url, as: :as_json, params: { engine: 'google', text: 'github' }
    assert_response :success
    json_response = JSON.parse(self.response.body)
    results = json_response['results']

    assert_not_empty results, 'results is empty or not present'
    assert_equal 2, results.size, 'results length is not 5'
  end

  test "should return the bing results" do
    BingSearch.any_instance.stubs(:parsed_page).returns(bing_mock)

    get api_v1_search_url, as: :as_json, params: { engine: 'bing', text: 'github' }
    assert_response :success
    json_response = JSON.parse(self.response.body)
    results = json_response['results']

    assert_not_empty results, 'results is empty or not present'
    assert_equal 2, results.size, 'results length is not 7'
  end

  test "should return results from both engines" do
    GoogleSearch.any_instance.stubs(:parsed_page).returns(google_mock)
    BingSearch.any_instance.stubs(:parsed_page).returns(bing_mock)

    get api_v1_search_url, as: :as_json, params: { engine: 'all', text: 'github' }
    assert_response :success
    json_response = JSON.parse(self.response.body)
    results = json_response['results']

    assert_not_empty results, 'results is empty or not present'
    assert_equal 4, results.size, 'results length is not 4'
  end
end

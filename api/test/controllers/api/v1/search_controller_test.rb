require 'test_helper'

class Api::V1::SearchControllerTest < ActionDispatch::IntegrationTest
  test "should return an empty array 'results' for no :text given" do
    get api_v1_search_url, as: :as_json
    assert_response :success
    json_response = JSON.parse(self.response.body)

    assert_empty json_response['results'], 'results is not empty'
  end

  test "should return the google results" do
    get api_v1_search_url, as: :as_json, params: { engine: 'google', text: 'github' }
    assert_response :success
    json_response = JSON.parse(self.response.body)
    results = json_response['results']

    assert_not_empty results, 'results is empty or not present'
    assert_equal 5, results.size, 'results length is not 5'
  end

  test "should return the bing results" do
    get api_v1_search_url, as: :as_json, params: { engine: 'bing', text: 'github' }
    assert_response :success
    json_response = JSON.parse(self.response.body)
    results = json_response['results']

    assert_not_empty results, 'results is empty or not present'
    assert_equal 7, results.size, 'results length is not 7'
  end

  test "should return results from both engines" do
    get api_v1_search_url, as: :as_json, params: { engine: 'all', text: 'github' }
    assert_response :success
    json_response = JSON.parse(self.response.body)
    results = json_response['results']

    assert_not_empty results, 'results is empty or not present'
    assert_equal 12, results.size, 'results length is not 12'
  end
end

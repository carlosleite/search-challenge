class SearchService
  ALL_ENGINES = 'all'.freeze
  USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:65.0) Gecko/20100101 Firefox/65.0'.freeze
  # :engine_url should be initialized in each engine class
  attr_accessor :engine_url, :search_term

  def initialize(search_term)
    @search_term = search_term
  end

  # Request the search engine page and parsed with nokogiri
  def parsed_page
    page_html = HTTParty.get(engine_url + search_term,
                             headers: { 'User-Agent' => USER_AGENT })
    Nokogiri::HTML(page_html.body)
  end

  def results
    raise NotImplementedError, 'Must implement `results`'
  end
end
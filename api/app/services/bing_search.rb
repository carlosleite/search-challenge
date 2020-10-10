class BingSearch < SearchService
  BING_URL = 'https://www.bing.com/search?q='.freeze
  ENGINE = 'bing'.freeze

  def initialize(search_term)
    super
    @engine_url = BING_URL
  end

  def results
    res = []
    parsed_page.css('.b_algo').map do |result|
      title = result.css('.b_title h2 a')[0]
      next if title.nil?

      res << {
        title: title.text,
        url: title['href'],
        description: result.css('.b_caption > p').text,
        engine: ENGINE
      }
    end
    res
  end
end
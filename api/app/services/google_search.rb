class GoogleSearch < SearchService
  GOOGLE_URL = 'https://www.google.com/search?q='.freeze
  ENGINE = 'google'.freeze

  def initialize(search_term)
    super
    @engine_url = GOOGLE_URL
  end

  def results
    res = []

    parsed_page.css('.g').map do |result|
      title = result.css('.rc h3').text
      next if title.empty?

      link = result.css('.rc a[href]').first
      res << {
        title: title,
        url: link.present? ? link['href'] : '#',
        description: result.css('.aCOpRe').text,
        engine: ENGINE
      }
    end

    res
  end
end
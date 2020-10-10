# frozen_string_literal: true

module Api
  module V1
    class SearchController < ApplicationController
      def index
        engine = params[:engine]
        # set all engines if google or bing where not given
        unless [GoogleSearch::ENGINE, BingSearch::ENGINE].include?(engine)
          engine = SearchService::ALL_ENGINES
        end
        search_results(engine, params[:text])
        render json: { results: @results }
      end

      protected

      def search_results(engine, text)
        @results = []

        return unless text.present?

        if [GoogleSearch::ENGINE, SearchService::ALL_ENGINES].include?(engine)
          @results.concat(GoogleSearch.new(text).results)
        end
        if [BingSearch::ENGINE, SearchService::ALL_ENGINES].include?(engine)
          @results.concat(BingSearch.new(text).results)
        end
      end
    end
  end
end

require_relative '../api_action'

module GithubService
  module Repositories
    class Search < GithubService::ApiAction
      def initialize(search_query)
        @search_query = sanitize(search_query)
      end

      # @param query [String]
      # @return [String]
      def sanitize(query)
        query.strip.downcase # it could be more sophisticated
      end

      def request_options
        GithubService::RequestOptions.new(
            path: 'search/repositories',
            params: {q: @search_query}
        )
      end
    end
  end
end
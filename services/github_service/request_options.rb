module GithubService
  # API request options such as path, headers, etc.
  class RequestOptions
    GITHUB_API_URL = 'https://api.github.com'

    attr_reader :path, :http_method, :headers, :params, :body, :query

    # @param :path [String] api path
    # @param :http_method [Symbol] either get or post
    # @param :headers [Hash]
    # @param :params [Hash]
    # @param :body [String]
    def initialize(path:, http_method: :get, headers: {}, params: [], body: nil)
      @path = path
      @http_method = http_method
      @headers = headers
      @params = params
      @body = body
    end

    # @return [String]
    def url
      "#{GITHUB_API_URL}/#{@path}"
    end
  end
end
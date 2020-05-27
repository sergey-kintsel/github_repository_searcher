require 'json'

module GithubService
  class Fetcher
    # @param api_action [ApiAction]
    def initialize(api_action, page = 1)
      @api_action = api_action
      @page = page
    end

    # @return Hash
    def run!
      request.run
      response = request.response

      if response.timed_out?
        puts "Request timed out #{request}"
        fail(RuntimeError, "Request timed out")
      end
      if response.code == 0 || response.code >= 400
        puts "Failed to process request: #{request.inspect}"
        fail(RuntimeError, "Request failed to be processed")
      end

      parse_response(response)
    end

    # @param [Typhoeus::Response]
    # @return [Hash]
    def parse_response(response)
      JSON.parse(response.body).fetch('items')
    rescue JSON::ParserError, KeyError
      fail(RuntimeError, "Unprocessable data received from Github")
    end

    def request
      request_options = @api_action.request_options
      @request ||= Typhoeus::Request.new(
          request_options.url,
          method: request_options.http_method,
          body: request_options.body,
          params: request_options.params.merge(page: @page)
      )
    end
  end
end
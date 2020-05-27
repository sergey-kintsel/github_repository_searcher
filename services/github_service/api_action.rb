module GithubService
  # abstract api action, such as /search/repositories with its parameters
  class ApiAction
    # @return [RequestOptions]
    def request_options
      fail NotImplementedError
    end
  end
end
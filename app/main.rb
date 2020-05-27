require 'sinatra'
require_relative '../services/github_service'

get '/' do
  @query = params['query']
  @page = params['page'].to_i
  @page = 1 if @page == 0

  if @query
    search_action = GithubService::Repositories::Search.new(@query)
    fetcher = GithubService::Fetcher.new(search_action, @page)
    @result_items =
      begin
       fetcher.run!
      rescue RuntimeError => e
        puts e.inspect # there should be a logger used instead
        @error = e.to_s
        []
      end
  end
  erb :index
end
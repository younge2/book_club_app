class BooksController < ApplicationController

  def index
    @key = ENV['GOOGLE']
    @query = params[:query]
    url = "https://www.googleapis.com/books/v1/volumes?q=#{@query}&key=#{@key}"
    puts url
    #disables SSL for localhost, remove once deployed
    HTTParty::Basement.default_options.update(verify: false)
    @responses = HTTParty.get(url)
    puts @responses


  end
end


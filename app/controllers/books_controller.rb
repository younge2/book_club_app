class BooksController < ApplicationController

  def index
    @key = ENV['GOOGLE']
    @query = params[:query]
    url = "https://www.googleapis.com/books/v1/volumes?q=#{@query}&key=#{@key}"
    puts url
    #disables SSL for localhost, remove once deployed
    HTTParty::Basement.default_options.update(verify: false)
    @responses = HTTParty.get(url)
  end

  def show
    @id = params[:id]
    @key = ENV['GOOGLE']
    @query = params[:query]
    url = "https://www.googleapis.com/books/v1/volumes?q=#{@id}&key=#{@key}"
    puts url
    #disables SSL for localhost, remove once deployed
    HTTParty::Basement.default_options.update(verify: false)
    @response = HTTParty.get(url)
  end
end



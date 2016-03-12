class BooksController < ApplicationController

  def show
    key = ENV['GOOGLE']
    url = 'https://www.googleapis.com/books/v1/volumes?q=fifty+shades&key=' + key
    #disables SSL for localhost, remove once deployed
    HTTParty::Basement.default_options.update(verify: false)
    @responses = HTTParty.get(url)
  
  end
end


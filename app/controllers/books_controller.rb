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
    @book = Book.new
    @user = @current_user
  end

  def new
    @book = Book.new 
  end

  def create
    book_new = Book.find_or_create_by(isbn: params[:books][:id]) do |book|
      book.title = params[:books][:title]
      book.author = params[:books][:author]
      book.isbn = params[:books][:id]
      book.yearofpub = params[:books][:date]
      book.description = params[:books][:description]
      book.image = params[:books][:image]
      book.category = params[:books][:category]
    end
    bookassociation = Bookstate.find_or_create_by({user_id: @current_user.id, book_id: book_new.id}) do |bookstate|
      bookstate.user_id = @current_user.id
      bookstate.book_id = book_new.id
      end
      if params[:books][:label] == 'to-read'
        bookassociation.category = 0
      elsif params[:books][:label] == 'has read'
        bookassociation.category = 1
      elsif params[:books][:label] == 'favorite'
        bookassociation.category = 2
      end
      bookassociation.save! 
    redirect_to "/users/profile/#{@current_user.id}"
  end

  def addbooktoclub
    @clubs = @current_user.clubs.all
    @book = Book.where(isbn: params[:id])
    

  end
  def postbooktoclub
    puts "is this working club"
    @club = Club.find_by_id(params[:id])
    @bookadd = Club.find_by_id(@club).books << Book.find_by_id(params[:book_id])
    redirect_to club_path
  end

  def addbook
    
    @clubs = @current_user.clubs.all
    book_new = Book.find_or_create_by(isbn: params[:books][:id]) do |book|
      book.title = params[:books][:title]
      book.author = params[:books][:author]
      book.isbn = @isbn = params[:books][:id]
      book.yearofpub = params[:books][:date]
      book.description = params[:books][:description]
      book.image = params[:books][:image]
      book.category = params[:books][:category]
    end
    bookassociation = Bookstate.find_or_create_by({user_id: @current_user.id, book_id: book_new.id}) do |bookstate|
      bookstate.user_id = @current_user.id
      bookstate.book_id = book_new.id
      end
      
      bookassociation.save!
      #use put method on button
      redirect_to addbook_path
  end
  def delete
    bookstate = Bookstate.where(user_id: params[:id], book_id: params[:book_id]).first
    bookstate_id = bookstate.id
    Bookstate.delete(bookstate_id)
    redirect_to "/users/profile/#{@current_user.id}"
    
  end
end



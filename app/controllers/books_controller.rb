class BooksController < ApplicationController
	before_action :authenticate_user!
	


	def index
		@user = current_user
		@books = Book.all
		@book = Book.new
	end

	def show
		@book_show = Book.find(params[:id])
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
		   redirect_to books_path(@book_path)
		   flash[:notice] = "successfully"
		else
		   @books = Book.all
		   @user = current_user
		   flash[:notice] = "error"
		   render :index
		end
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		book = Book.find(params[:id])
		if book.update(book_params)
			redirect_to book_path(book)
			flash[:notice] = "successfully"
		else
			@book = book
			@books = Book.all
			@user = current_user
			render :index
			flash[:notice] = "error"
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
		flash[:notice] = "successfully"
	end

	private
		def book_params
			params.require(:book).permit(:title, :body)
		end


end

		def current_user
			@book = Book.find(params[:id])
			if current_user != @book.user_id
				redirect_to books_path
			end
		end

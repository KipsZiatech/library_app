class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_book, only: %i[show borrow return_book]
  
    def index
      @books = Book.all
    end
  
    def show
    end
  
    def library
      @books = Book.all  # ✅ Ensure @books is set so the view does not throw an error
    end
  
    def borrow
      if @book.available?
        current_user.borrowings.create(book: @book, due_date: 2.weeks.from_now, returned: false)
        redirect_to books_path, notice: 'Book borrowed successfully!'
      else
        redirect_to books_path, alert: 'Book is already borrowed.'
      end
    end
  
    def return_book
      borrowing = current_user.borrowings.find_by(book: @book, returned: false)
      if borrowing
        borrowing.update(returned: true)
        redirect_to profile_path, notice: 'Book returned successfully!'
      else
        redirect_to profile_path, alert: 'Error returning book.'
      end
    end
  
    private
  
    def set_book
      @book = Book.find(params[:id])
    end
  end
  
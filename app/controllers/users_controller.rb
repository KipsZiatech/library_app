class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def profile
      @borrowed_books = current_user.borrowings.includes(:book).where(returned: false)
    end
  end
  
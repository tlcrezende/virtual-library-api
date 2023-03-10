class Api::V1::ReviewsController < ApplicationController
  include Paginable
  include Average
  
  before_action :authenticate_api_user!, only: :create
  before_action :set_review_users, only: :index_user
  before_action :set_review_books, only: :index_book
  before_action :average_book, only: [:index_book, :index_user]
  
  def index
    @reviews = Review.page(current_page).per(per_page) 

    render json: @reviews, meta: meta_attributes(@reviews), adapter: :json
  end

  def create
    @review = current_api_user.reviews.new(review_params)

    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def index_book
    render json: @reviews, meta: meta_attributes(@reviews, {average: @average}), adapter: :json
  end

  def index_user
    render json: @reviews, meta: meta_attributes(@reviews, {average: @average}), adapter: :json
  end

  private
    def set_review_books
      @reviews = Book.find(params[:id]).reviews.page(current_page).per(per_page) 
    end

    def set_review_users
      @reviews = User.find(params[:id]).reviews.page(current_page).per(per_page) 
    end

    def review_params
      params.require(:review).permit(:user_review, :score, :user_id, :book_id)
    end
end

# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, 
          :registerable,
          :recoverable, 
          :rememberable, 
          :validatable
          
  include DeviseTokenAuth::Concerns::User

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :reviews, dependent: :destroy
end

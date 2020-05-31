class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true, on: :create
  validates_confirmation_of :password
  belongs_to :merchant, optional: true


  enum role: %w(default merchant admin)

end

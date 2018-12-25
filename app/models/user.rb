class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :nickname, presence: true, length: { maximum: 12 }

  validates :family_name,      presence: true, on: :update
  validates :first_name,       presence: true, on: :update
  validates :family_name_kana, presence: true, on: :update
  validates :first_name_kana,  presence: true, on: :update
  validates :birth_year,       presence: true, on: :update
  validates :birth_month,      presence: true, on: :update
  validates :birth_day,        presence: true, on: :update

  has_many :items
  has_one :address

  validates :nickname, presence: true, length: { maximum: 12 }
end

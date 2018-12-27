class Address < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :postal_code
    validates :prefecture
    validates :city
    validates :street_number
  end
end

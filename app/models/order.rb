class Order < ApplicationRecord
  belongs_to :item
  belongs_to :user

  enum status: [:stage0, :stage1, :stage2, :stage3, :stage4]
end

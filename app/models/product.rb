class Product < ApplicationRecord
  belongs_to :category

  validates :description, presence: true
  validates :price, presence: true
  validates :category, presence: true

  def full_description
    "#{self.description} - #{self.price}"
  end
end

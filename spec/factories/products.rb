require 'faker'

FactoryBot.define do
  factory :product do
    description {Faker::Commerce.product_name}
    price {Faker::Commerce.price}

    # Como a categoria é um belongs_to, o factory sabe que deve pegar um sample de category
    category

  end
end

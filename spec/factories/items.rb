FactoryGirl.define do
  factory :category, class: Category do
    name "mens"
    depth "2"
    size_pulldown "1"
  end

  factory :user, class: User do
    family_name "aaa"
    first_name "bbb"
    family_name_kana "ccc"
    first_name_kana "ddd"
    birth_year "2000"
    birth_month "1"
    birth_day "11"
    email { Faker::Internet.email }
    password "aaaaaa"
    phone_number "12345678"
    nickname "abcde"
    avatar "www"
    introduction "qqq"
  end

  factory :size, class: Size do
    name "s"
    parent "1"
  end


  factory :item do
    name "jacket"
    description "abcabcabc"
    price 3000
    condition 1
    shipping_from 1
    shipping_date 1
    shipping_fee 1
    shipping_way 1
    user FactoryGirl.create( :user)
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
    category FactoryGirl.create( :category)
    size FactoryGirl.create( :size)
  end
end

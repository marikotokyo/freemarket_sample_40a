FactoryGirl.define do

  factory :user do
    nickname              "abe"
    email                 "kkk@gmail.com"
    password              "00000000"
    password_confirmation "00000000"
    family_name "aaa"
    first_name "bbb"
    family_name_kana "ccc"
    first_name_kana "ddd"
    birth_year "2000"
    birth_month "1"
    birth_day "11"
    phone_number "12345678"
    avatar "www"
    introduction "qqq"
  end

end

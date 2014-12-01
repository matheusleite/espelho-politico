FactoryGirl.define do
  factory :user do
    sequence(:id)
    name { "Usuario #{id}" }
    email { "espelho.politico+#{id}@gmail.com".downcase }
    password "12345678"
    username { "user#{id}" }
    created_at "#{Time.current}"
    updated_at "#{Time.current}"
    confirmed_at "#{Time.current+60}"
    confirmation_sent_at "#{Time.current}"
  end
end

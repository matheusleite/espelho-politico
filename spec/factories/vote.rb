FactoryGirl.define do
  factory :vote do
    sequence(:id)
    user_id 1
    sequence(:proposition_id)
    parliamentarian_id 1
    approved? true
  end
end

FactoryBot.define do
  factory :post do
    body { "test" }
    association :user
  end
end

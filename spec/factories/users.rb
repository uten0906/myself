FactoryBot.define do
  factory :user do
    name { "Test" }
    email { "test@example.com" }
    birthday { "1990-12-01" }
    sex { 1 }
    password_digest { "test!" }
  end
end

FactoryBot.define do
  factory :comment do
    text { "MyText" }
    challenge { nil }
    user { nil }
  end
end

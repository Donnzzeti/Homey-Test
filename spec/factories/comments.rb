FactoryBot.define do
  factory :comment do
    content { "MyText" }
    project { nil }
    user { nil }
  end
end

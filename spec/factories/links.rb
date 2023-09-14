FactoryBot.define do
  factory :link do
    title { "Linko link" }
    url { "http://localhost:3000/" }
    association :group, factory: :group
  end
end

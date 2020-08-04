FactoryBot.define do
  factory :address do
    person
    sequence(:kind) { |i| "kind#{i}" }
    sequence(:street) { |i| "street#{i}" }
  end
end

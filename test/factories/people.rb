FactoryBot.define do
  factory :person do
    sequence(:first_name) { |i| "first_name#{i}" }
    sequence(:last_name) { |i| "last_name#{i}" }
  end
end

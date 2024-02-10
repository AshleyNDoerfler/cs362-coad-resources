
FactoryBot.define do
  factory :ticket do
    name { "Acid Burn" }
    description { "Why am I burning" }
    phone { 12345678901 }
    closed { false }
    organization { nil }
    region
    resource_category 
  end
end
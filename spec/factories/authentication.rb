FactoryBot.define do
  factory :authentication do
    user
    uid 123_456_789
    provider 'hoge'
  end
end

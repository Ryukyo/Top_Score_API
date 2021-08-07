FactoryBot.define do
    factory :score do
      player { Faker::Lorem.word }
      score { Faker::Number.number(digits: 3) }
      time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
      id {nil}
    end
  end
FactoryGirl.define do
  sequence :name do |n|
    "Sample Name #{n}"
  end

  factory :product do
    name
    price 10.0
  end

  factory :cart do
    session_id {|n| "session_#{n}" }
  end
end

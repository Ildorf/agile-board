FactoryGirl.define do
  sequence :name do |n|
    "MyBoard#{n}"
  end

  factory :board do
    name
    description 'my awesome board'
  end
end

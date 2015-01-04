FactoryGirl.define do
  factory :junior_support_user, class: User do
    username "juniorSupportTech"
    role 1
  end

  factory :senior_support_user, class: User do
    username "seniorSupportTech"
    role 2
  end

  factory :villian_user, class: User do
    username "villianUser"
    role 3
  end

  factory :supervillian_user, class: User do
    username "supervillianUser"
    role 4
  end
end


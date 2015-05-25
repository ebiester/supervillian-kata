FactoryGirl.define do
  factory :junior_support_user, class: User do
    username "juniorSupportTech"
    role User.roles[:junior_support]
  end

  factory :senior_support_user, class: User do
    username "seniorSupportTech"
    role User.roles[:senior_support]
  end

  factory :villian_user, class: User do
    username "villianUser"
    role User.roles[:villian]
  end

  factory :supervillian_user, class: User do
    username "supervillianUser"
    role User.roles[:supervillian]
  end
end


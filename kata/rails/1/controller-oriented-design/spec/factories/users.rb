FactoryGirl.define do
  factory :juniorsupport, class: User do
    username "juniorSupportTech"
    role "juniorSupport"
  end

  factory :seniorsupport, class: User do
    username "seniorSupportTech"
    role "seniorSupport"
  end

  factory :villian, class: User do
    username "villianUser"
    role "villian"
  end

  factory :supervillian, class: User do
    username "supervillianUser"
    role "supervillian"
  end
end


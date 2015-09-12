class Employee < ActiveRecord::Base
  enum role: [:junior_support, 
              :senior_support] 
end

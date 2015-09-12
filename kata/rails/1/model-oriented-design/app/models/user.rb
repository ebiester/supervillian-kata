class User < ActiveRecord::Base
  enum role: [:junior_support, 
              :senior_support, 
              :villian,
              :supervillian ] 
end

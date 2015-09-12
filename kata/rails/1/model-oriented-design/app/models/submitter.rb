class Submitter < ActiveRecord::Base
  enum role: [:villian,
              :supervillian ] 
end

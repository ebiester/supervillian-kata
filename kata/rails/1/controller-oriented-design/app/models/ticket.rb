class Ticket < ActiveRecord::Base
  belongs_to :submitter, class_name: User
  belongs_to :assigned, class_name: User
end

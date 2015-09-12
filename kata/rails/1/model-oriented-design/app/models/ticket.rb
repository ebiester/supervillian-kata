class Ticket < ActiveRecord::Base
  #Why doesn't this work?
  #belongs_to :employee, required: true
  belongs_to :employee
  belongs_to :submitter
end

#require 'byebug'

class Ticket < ActiveRecord::Base
  belongs_to :submitter, class_name: User
  belongs_to :assigned, class_name: User
  enum status: [ :open, :active, :closed ]

  # A smart application would put this in its own validator.
  validate do |ticket|
    if submitter_role_is_supervillian and assigned_role_is_junior
      ticket.errors.add(:assigned, 'A supervillian ticket must be assigned to senior support staff')
    end
  end

  def submitter_role_is_supervillian
    submitter and submitter.supervillian?
  end

  def assigned_role_is_junior
    assigned and assigned.junior_support?
  end
end  

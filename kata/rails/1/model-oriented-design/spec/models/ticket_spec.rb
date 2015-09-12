require 'rails_helper'

RSpec.describe Ticket, type: :model do
  fixtures :employees, :submitters

  it "can create a ticket" do
    ticket = Ticket.new
    ticket.title = "title"
    ticket.description = "description"
    ticket.employee = employees(:junior)
    ticket.submitter = submitters(:villian)
    ticket.save!
  end

end

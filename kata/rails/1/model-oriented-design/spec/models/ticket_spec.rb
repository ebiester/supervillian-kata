require 'rails_helper'

RSpec.describe Ticket, type: :model do
  fixtures :employees, :submitters, :tickets

  it "can create a ticket" do
    ticket = Ticket.new
    ticket.title = "title"
    ticket.description = "description"
    ticket.employee = employees(:junior)
    ticket.submitter = submitters(:villian)
    ticket.save!
  end

  it "is by default not started" do
    ticket = tickets(:unstarted_ticket)
    expect(ticket).to be_not_started
  end

end

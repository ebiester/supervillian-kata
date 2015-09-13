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

  it "cannot be assigned a junior support employee if the submitter is a supervillian" do
    ticket = Ticket.new
    ticket.employee = employees(:junior)
    ticket.submitter = submitters(:supervillian)
    ticket.valid?
    expect(ticket.errors[:employee]).to include("Junior support cannot work a supervillian's ticket.")
  end

end

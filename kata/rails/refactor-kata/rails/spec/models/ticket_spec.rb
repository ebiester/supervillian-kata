require 'rails_helper'
require 'spec_helper'

describe Ticket do
  it 'can create an acceptable ticket' do
    villian_user = build(:villian_user)
    ticket = Ticket.new
    ticket.submitter = villian_user
    ticket.title = "title"
    ticket.description = "description"
    expect(ticket).to be_valid
  end
end

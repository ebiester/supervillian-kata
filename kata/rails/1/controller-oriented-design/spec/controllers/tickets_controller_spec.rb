require 'rails_helper'

describe TicketsController do
  before(:all) do
    @title = 'title'
    @description = 'description'
  end

  def createTicket(submitting_user)
    params = {:user => submitting_user.username, 
              :title => @title,
              :description => @description }

    ticketjson = post 'create', params

    id = JSON.parse(response.body)["id"]
    Ticket.find(id)
  end

  it "can add a new ticket" do
    villian_user = create(:villian_user)
    create(:junior_support_user)

    new_ticket = createTicket(villian_user)

    expect(new_ticket.title).to eq(@title)
    expect(new_ticket.description).to eq(@description)
    expect(new_ticket).to be_open
    expect(new_ticket.submitter).to eq(villian_user)
  end

  it 'will assign an eligible ticket to an open employee' do
    villian_user = create(:villian_user)
    create(:junior_support_user)
    new_ticket = createTicket(villian_user)

    expect(new_ticket.assigned).
      to be_an_instance_of(User)
    expect(new_ticket.assigned.current_ticket).
      to eql(new_ticket)
  end

  it 'will not assign a ticket to a junior support_user member if the ticket is from a supervillian_user' do
    supervillian_user = create(:supervillian_user)
    create(:junior_support_user)
    new_ticket = createTicket(supervillian_user)

    expect(new_ticket.assigned).to be_nil
  end

  it 'will assign a ticket to a senior support_user member if the ticket is from a supervillian_user' do
    supervillian_user = create(:supervillian_user)
    create(:junior_support_user)
    create(:senior_support_user)
    new_ticket = createTicket(supervillian_user)

    expect(new_ticket.assigned).to be_senior_support
    expect(new_ticket.assigned.current_ticket).
      to eql(new_ticket)
  end

  it 'will update the state of the ticket when updating the ticket' do
    villian_user = create(:villian_user)
    create(:junior_support_user)

    new_ticket = createTicket(villian_user)

    params = { status: :active,
               id: new_ticket.id }

    put 'update', params

    updatedticket = Ticket.find_by(title: @title)

    expect(updatedticket).to be_active
  end

  it 'will clear the assigned support_user member\'s current ticket if the ticket is being closed and there is no next ticket' do
    villian_user = create(:villian_user)
    create(:junior_support_user)
    new_ticket = createTicket(villian_user)
    params = { status: :closed,
               id: new_ticket.id }

    put 'update', params

    updatedticket = Ticket.find_by(title: @title)
    expect(updatedticket.assigned.current_ticket).to be_nil
  end

  it 'will assign the next ticket if there is an eligible ticket' do
    villian_user = create(:villian_user)
    junior_support_user = create(:junior_support_user)
    to_be_closed_ticket = createTicket(villian_user)
    next_ticket = createTicket(villian_user)
    params = { status: :closed,
               id: to_be_closed_ticket.id }

    put 'update', params

    next_ticket.reload
    junior_support_user.reload
    expect(next_ticket.assigned).to eql(junior_support_user)
    expect(junior_support_user.current_ticket).to eql(next_ticket)
  end

  it 'will not assign a junior support_user member a supervillian_user ticket when a junior support_user member closes a ticket' do
    villian_user = create(:villian_user)
    supervillian_user = create(:supervillian_user)
    junior_support_user = create(:junior_support_user)
    to_be_closed_ticket = createTicket(villian_user)
    ineligible_ticket = createTicket(supervillian_user)
    expect(ineligible_ticket.assigned).to be_nil
    params = { status: :closed,
               id: to_be_closed_ticket.id }

    put 'update', params

    junior_support_user.reload
    expect(ineligible_ticket.assigned).to be_nil
    expect(junior_support_user.current_ticket).to be_nil
  end
end

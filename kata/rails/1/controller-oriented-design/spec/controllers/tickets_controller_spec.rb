require 'rails_helper'

describe TicketsController do
  it "can add a new ticket" do
    create(:villian)
    create(:juniorsupport)

    villian = User.find_by(role: 'villian')
    title = 'title'
    description = 'description'

    params = {:user => villian.username, 
              :title => title,
              :description => description }

    post 'create', params

    newticket = Ticket.find_by(title: title)
    expect(newticket.title).to eq(title)
    expect(newticket.description).to eq(description)
    expect(newticket.submitter).to eq(villian)
  end

  it 'will assign an eligible ticket to an open employee' do
    create(:villian)
    create(:juniorsupport)

    villian = User.find_by(role: 'villian')
    title = 'title'
    description = 'description'

    params = {:user => villian.username, 
              :title => title,
              :description => description }

    post 'create', params

    newticket = Ticket.find_by(title: title)
    expect(newticket.assigned).to be_an_instance_of(User)
    expect(newticket.assigned.current_ticket).to eql(newticket)
  end

  it 'will not assign a ticket to a junior support member if the ticket is from a supervillian' do
    create(:supervillian)
    create(:juniorsupport)

    supervillian = User.find_by(role: 'supervillian')
    title = 'title'
    description = 'description'

    params = {:user => supervillian.username, 
              :title => title,
              :description => description }

    post 'create', params

    newticket = Ticket.find_by(title: title)
    expect(newticket.assigned).to be_nil
  end

    it 'will assign a ticket to a senior support member if the ticket is from a supervillian' do
    create(:supervillian)
    create(:juniorsupport)
    create(:seniorsupport)

    supervillian = User.find_by(role: 'supervillian')
    title = 'title'
    description = 'description'

    params = {:user => supervillian.username, 
              :title => title,
              :description => description }

    post 'create', params

    newticket = Ticket.find_by(title: title)
    expect(newticket.assigned.role).to eql('seniorSupport')
    expect(newticket.assigned.current_ticket).to eql(newticket)
  end


end

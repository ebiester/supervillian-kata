require 'rails_helper'

describe TicketsController do
  fixtures :users
  it "can add a new ticket" do
    villian = User.find_by(username: 'villian')
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
    villian = User.find_by(username: 'villian')
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

end

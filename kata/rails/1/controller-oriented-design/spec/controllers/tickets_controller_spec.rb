require 'rails_helper'

describe TicketsController do
  fixtures :users
  it "can add a new ticket" do
    villian = User.find_by(username: 'villian')
    title = 'title'

    params = {:user => villian.username, 
              :title => title }

    post 'create', params

    newticket = Ticket.find_by(title: title)
    expect(newticket.title).to eq(title)
    expect(newticket.submitter).to eq(villian)
  end
end

class TicketsController < ApplicationController

  def create
    ticket = Ticket.new
    user = User.find_by(username: params[:user])
    ticket.submitter = user
    ticket.title = params[:title]
    ticket.description = params[:description]
    ticket.assigned = get_eligible_support_member_if_available(ticket)
    ticket.open!
    ticket.save!
    if ticket.assigned
      user = ticket.assigned
      user.current_ticket = ticket
      user.save!
    end

    render :json => ticket
  end
  
  def update
    ticket = Ticket.find(params[:id])
    ticket.status = params[:status]
    ticket.save!

    if ticket.closed?
      assigned_user = ticket.assigned
      next_ticket = get_next_ticket(assigned_user)
      assigned_user.current_ticket = next_ticket
      assigned_user.save!
      if next_ticket
        next_ticket.assigned = assigned_user
        next_ticket.save!
      end
    end

    render nothing: true
  end

  def get_next_ticket(assigned_user)
    Ticket.where("assigned_id is ?", nil).take
  end

  def get_eligible_support_member_if_available(ticket)
    roles = []
    if ticket.submitter.role == 'supervillian'
      roles << 'seniorSupport'
    elsif ticket.submitter.role == 'villian'
      roles << 'juniorSupport'
      roles << 'seniorSupport'
    end

    User.where("current_ticket_id is ? and role IN (?)", 
               nil, roles).take
  end

end

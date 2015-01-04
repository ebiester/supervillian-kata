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
    eligible_roles = get_eligible_ticket_roles(assigned_user)
    
    Ticket.joins(:submitter).where("assigned_id is ? and users.role in (?) ", nil, eligible_roles).first
  end

  def get_eligible_support_member_if_available(ticket)
    roles = get_eligible_support_roles(ticket.submitter)
    User.where("current_ticket_id is ? and role IN (?)", 
               nil, roles).first
  end

  def get_eligible_support_roles(submitter)
    roles = []
    if submitter.role == 'supervillian'
      roles << 'seniorSupport'
    elsif submitter.role == 'villian'
      roles << 'juniorSupport'
      roles << 'seniorSupport'
    end

    roles
  end

  
  def get_eligible_ticket_roles(assignable_user)
    roles = []
    if assignable_user.role == 'juniorSupport'
      roles << 'villian'
    elsif assignable_user.role == 'seniorSupport'
      roles << 'villian'
      roles << 'supervillian'
    end

    roles
  end

end

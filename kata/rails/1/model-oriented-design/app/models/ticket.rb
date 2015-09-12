class Ticket < ActiveRecord::Base
  belongs_to :employee
  belongs_to :submitter

  after_initialize do |ticket|
    ticket.not_started!
  end

  enum state: [:not_started,
               :started,
               :finished]
end

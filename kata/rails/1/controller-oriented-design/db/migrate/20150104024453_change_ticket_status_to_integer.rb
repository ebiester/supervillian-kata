class ChangeTicketStatusToInteger < ActiveRecord::Migration
  def change
    change_column(:tickets, :status, :integer, default: 0, null: false)
  end
end

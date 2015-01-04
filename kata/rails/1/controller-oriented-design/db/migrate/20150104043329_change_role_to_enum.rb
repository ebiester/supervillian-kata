class ChangeRoleToEnum < ActiveRecord::Migration
  def change
    change_column(:users, :role, :integer, default: 0, null: false)
  end
end

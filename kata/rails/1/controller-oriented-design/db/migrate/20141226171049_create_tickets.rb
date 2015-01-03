class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :submitter_id
      t.integer :assigned_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end

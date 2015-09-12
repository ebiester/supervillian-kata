class CreateSubmitter < ActiveRecord::Migration
  def change
    create_table :submitters do |t|
       t.integer :role
       t.string :username
    end
  end
end

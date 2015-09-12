class CreateEmployee < ActiveRecord::Migration
  def change
    create_table :employees do |t|
       t.integer :role
       t.string :username
    end
  end
end

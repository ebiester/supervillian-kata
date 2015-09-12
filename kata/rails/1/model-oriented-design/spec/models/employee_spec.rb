describe Employee do
  it 'can create a employee' do
    employee = Employee.new(role: :junior_support, username: "test")
    employee.save!
  end

  it 'can be junior support' do
    employee = Employee.new
    employee.role = :junior_support
  end

  it 'can be senior support' do
    employee = Employee.new
    employee.role = :senior_support
  end
end

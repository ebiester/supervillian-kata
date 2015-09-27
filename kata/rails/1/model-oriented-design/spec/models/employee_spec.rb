describe Employee do
  it 'can create a employee' do
    employee = Employee.new(role: :junior_support, username: "test")
    employee.save!
  end

  context 'roles' do
    it 'can be junior support' do
      employee = Employee.new
      employee.role = :junior_support
    end

    it 'can be senior support' do
      employee = Employee.new
      employee.role = :senior_support
    end
  end

  context 'tickets' do
    fixtures :employees, :submitters

    it 'has tickets' do
      Employee.new.tickets
    end

    it 'should have a class method called available_employee' do
      expect(Employee.available_employee).to be
    end

    it 'should have a method called assigned_ticket' 
  end
end

describe User do
  it 'can create a user' do
    User.new
  end

  it 'has a role' do
    user = User.new
    user.role = :junior_support
  end

  it 'has a username' do
    user = User.new
    user.username = "testUser"
  end
end

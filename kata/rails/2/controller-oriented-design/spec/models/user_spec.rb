describe User do
  it 'has a maximum allowable ticket parameter' do
    expect(User::MAX_TICKETS[:junior_support]).to eql(1)
    expect(User::MAX_TICKETS[:senior_support]).to eql(2)
  end
end

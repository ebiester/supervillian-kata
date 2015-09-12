describe Submitter do
  it 'can create a submitter' do
    submitter = Submitter.new(role: :villian, username: "test")
    submitter.save!
  end

  it 'can be a villian' do
    submitter = Submitter.new
    submitter.role = :villian
  end
  
  it 'can be a supervillian' do
    submitter = Submitter.new
    submitter.role = :supervillian
  end

  it 'has a submittername' do
    submitter = Submitter.new
    submitter.username = "testSubmitter"
  end
end

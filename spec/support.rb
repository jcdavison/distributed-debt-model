RSpec.shared_context 'create community', :a => :b do
  before do
    @alice = Member.new({name: 'alice', contribution: 1000})
    @tom = Member.new({name: 'tom', contribution: 500})
    @chris = Member.new({name: 'chris', contribution: 1500})
    @elise = Member.new({name: 'elise', contribution: 500})
    @betty = Member.new({name: 'betty', contribution: 500})
    @dan = Member.new({name: 'dan', contribution: 500})
    @community = Community.new
  end
end


RSpec.shared_context 'create and populate community', :a => :b do
  include_context 'create community'
  before do
    @community.populate([@alice, @tom, @chris, @elise, @betty, @dan])
    @community.connect @alice.name, @tom.name
    @community.connect @alice.name, @elise.name
    @community.connect @alice.name, @chris.name
    @community.connect @betty.name, @chris.name
    @community.connect @betty.name, @dan.name
  end
end

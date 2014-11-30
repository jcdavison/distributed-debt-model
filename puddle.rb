require './setup.rb'

# create people
@alice = Member.new({name: 'alice', contribution: 1000})
@tom = Member.new({name: 'tom', contribution: 500})
@chris = Member.new({name: 'chris', contribution: 1500})
@elise = Member.new({name: 'elise', contribution: 500})
@betty = Member.new({name: 'betty', contribution: 500})
@dan = Member.new({name: 'dan', contribution: 500})

# build and populate people
@community = Community.new
@community.populate([@alice, @tom, @chris, @elise, @betty, @dan])

# create connections among people
@community.connect @alice.name, @tom.name
@community.connect @alice.name, @elise.name
@community.connect @alice.name, @chris.name
@community.connect @betty.name, @dan.name
@community.connect @chris.name, @betty.name

LendBot.generate_proportional_loans lendee: @alice, amount: 1000, community: @community

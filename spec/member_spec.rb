require 'spec_helper'

describe Member, :type=> :model do
  it 'knows how to take \'er easy' do
    member = Member.new
    expect(member.name).to eq 'el duderino'
  end

  it 'is comfortable talking about itself' do
    member = Member.new contribution: 100, name: 'link'
    expect(member.contribution == 100 && member.name == 'link').to eq true
  end
end

require 'spec_helper'

describe Loan, :type=> :model do
  it 'isn\'t picky about args' do
    loan = Loan.new
    expect(loan.amount).to be 0
  end

  it 'knows its own worth in life' do
    loan = Loan.new amount: 100
    expect(loan.amount).to be 100
  end
end

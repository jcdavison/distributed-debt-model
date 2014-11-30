require 'spec_helper'

describe Loan, :type=> :model do
  it 'isn\'t picky about args' do
    loan = Loan.new
    expect(loan.amount).to be 0
  end

  it 'knows its value in life' do
    loan = Loan.new amount: 100
    expect(loan.amount).to be 100
  end

  it 'knows to keep track of when it was created' do
    expect_any_instance_of(Loan).to receive(:set_time_with_seconds).once
    loan = Loan.new amount: 100
  end
end

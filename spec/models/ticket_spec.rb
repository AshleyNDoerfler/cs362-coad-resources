require 'rails_helper'

RSpec.describe Ticket, type: :model do

  it "exists" do
    Ticket.new
  end

  it "has a name" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:name)
  end

  it "has a description" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:description)
  end

  it "has a phone" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:phone)
  end

  it "has a closed flag" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:closed)
  end

  it "closed defaults to false" do
    ticket = Ticket.new
    expect(ticket.closed).to eq(false)
  end

  it { should belong_to(:region) }
  it { should belong_to(:resource_category) }
  it { should belong_to(:organization).options[:optional] }

end

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

  describe "associations" do
    it { should belong_to(:region) }
    it { should belong_to(:resource_category) }
    it { should belong_to(:organization).options[:optional] }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:region_id) }
    it { should validate_presence_of(:resource_category_id) }

    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:description).is_at_most(1020).on(:create) }

    # it { should validate(:phone).phony_plausible(true) } # TODO: Fix This
  end

  it "to_s returns the id" do
    id = 42069
    ticket = Ticket.new(id: id)
    result = ticket.to_s
    expect(result).to eq("Ticket #{id}")
  end

  it "open sets open to true" do
    ticket = Ticket.new(closed: false)
    expect(ticket.open?).to eq(true)
  end

  it "open sets open to false" do
    ticket = Ticket.new(closed: true)
    expect(ticket.open?).to eq(false)
  end

end

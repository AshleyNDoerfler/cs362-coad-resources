require 'rails_helper'

RSpec.describe Ticket, type: :model do

  # it "exists" do
  #   Ticket.new
  # end

  describe "attributes" do
    let(:ticket) { build(:ticket) }

    it "has a name" do
      expect(ticket).to respond_to(:name)
    end

    it "has a description" do
      expect(ticket).to respond_to(:description)
    end

    it "has a phone" do
      expect(ticket).to respond_to(:phone)
    end

    it "has a closed flag" do
      expect(ticket).to respond_to(:closed)
    end

    it "closed defaults to false" do
      expect(ticket.closed).to eq(false)
    end
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

  describe "member functions" do
    # Factory bots
    let(:organization) { create(:organization, name: "Babadook", email: "IHateThis@gmail.com") }
    let(:captured_ticket) { create(:ticket, organization: organization, id: 345) }
    let(:open_ticket) { create(:ticket, closed: false) }
    let(:closed_ticket) { create(:ticket, closed: true) }
    let(:ticket) { create(:ticket) }

    it "to_s returns the id" do
      result = ticket.to_s
      expect(result).to eq("Ticket #{ticket.id}")
    end

    it "open? returns true if open" do
      expect(open_ticket.open?).to eq(true)
    end

    it "open returns false if closed" do
      expect(closed_ticket.open?).to eq(false)
    end

    it "captured? returns true if organization is present" do
      expect(captured_ticket.captured?).to eq(true)
    end

    it "captured? returns false if organization is not present" do
      expect(ticket.captured?).to eq(false)
    end
  end

  describe "scopes" do
    let(:organization) { create(:organization, name: "Babadook", email: "IHateThis@gmail.com") }

    let(:resource_category) { build_stubbed :resource_category}
    let(:resource_category_closed) { build_stubbed :resource_category, name: "Closed" }
    let(:resource_category_3) { build_stubbed :resource_category, organization: organization }

    let(:region) { build_stubbed :region }
    let(:region_2) { build_stubbed :region, name: "Closed" }
    let(:region_3) { build_stubbed :region, name: "Pooper dooper" }
    
    let(:open_ticket) { create(:ticket, region: region, resource_category: resource_category, closed: false) }
    let(:closed_ticket) { create(:ticket, region: region_2, resource_category: resource_category_closed, closed: true) }
    let(:organization_ticket) { create(:ticket, region: region_3, resource_category: resource_category_3, closed: false) }

    it "open returns open tickets" do
      expect(Ticket.open).to include(open_ticket)
      expect(Ticket.open).to_not include(closed_ticket)
    end

    it "closed returns closed tickets" do
      expect(Ticket.closed).to include(closed_ticket)
      expect(Ticket.closed).to_not include(open_ticket)
    end

    # TODO: Fix this
    # it "all_organization returns all tickets with an organization" do
    #   expect(Ticket.all_organization).to include(organization_ticket)
    # end
  end

  describe "controller functions" do
    #TODO: Add controller tests
  end

end

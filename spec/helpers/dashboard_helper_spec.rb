require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DashboardHelper, type: :helper do

  describe "dashboard for admin" do
    let(:user) {double :user, admin?: true}
    it {expect(helper.dashboard_for(user)).to eq("admin_dashboard")}
  end

  describe "dashboard for submitted organization" do
    let(:organization) {double :organization, submitted?: true}
    let(:user) {double :user, admin?: false, organization: organization}
    it {expect(helper.dashboard_for(user)).to eq("organization_submitted_dashboard")}
  end

  describe "dashboard for approved organization" do
    let(:organization) {double :organization, submitted?: false, approved?: true}
    let(:user) {double :user, admin?: false, organization: organization}
    it {expect(helper.dashboard_for(user)).to eq("organization_approved_dashboard")}
  end

end

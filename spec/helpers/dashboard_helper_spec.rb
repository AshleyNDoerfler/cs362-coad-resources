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

  

end

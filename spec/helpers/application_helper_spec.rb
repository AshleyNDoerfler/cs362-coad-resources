require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe "test full title" do
    it { expect(helper.full_title("")).to eq('Disaster Resource Network') }
  end
end

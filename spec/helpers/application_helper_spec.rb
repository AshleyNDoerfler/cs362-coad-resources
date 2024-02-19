require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe "test full title" do

    it { expect(helper.full_title).to eq('Disaster Resource Network') }

    it { expect(helper.full_title('Anything')).to eq('Anything | Disaster Resource Network')}
  end
end

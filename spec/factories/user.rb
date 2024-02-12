FactoryBot.define do 
  factory :user do
    email 
    password { "password" }

    # before(:create) { |user| user.skip_confirmation!}

    # TODO: trais org_approved, org_unapproved, admin 
    # note: format for creation example: "let(:admin_user) { create(:user, :admin) }""
  end
end
require 'rails_helper'

RSpec.describe "Exchange Currency Process", :type => :system, js: true do
  it "exchange value" do
    visit '/'
    within("#exchange_form") do
      select('Euro', from: 'source_currency')
      select('Real', from: 'target_currency')
      fill_in 'amount', with: rand(1..9999)
    end

   #expect(page).to have_content("value")
  end
end
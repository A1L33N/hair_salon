require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("the hair salon homepage path", {:type => :feature}) do
  it('takes a user go to either the client page or stylist page') do
    visit('/')
    click_link('See Our Stylists')
    expect(page).to have_content("Our Stylists")
  end
end


describe("the add stylist path", {:type => :feature})  do
  it('allows a user to add a stylist to a list of stylists') do
    visit('/stylists')
    fill_in('new_stylist', :with => 'Leslie Knope')
    click_button('Add Stylist')
    expect(page).to have_content('Leslie Knope')
  end
end



#this test does not pass because Rspec can not find field "new_client"?????
describe("the add client path", {:type => :feature})  do
  it('allows a user to add a client to a list of clients') do
    visit('/clients')
    fill_in('new_client', :with => 'Ron Swanson')
    click_button('Add Client')
    expect(page).to have_content('Ron Swanson')
  end
end

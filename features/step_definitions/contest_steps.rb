Then /^I should see .* contests$/ do
    page.should have_content('Listing Contests')
    page.should have_selector('table')
end

Given /^I am on .* Contests page$/ do
    steps %Q{
        Given I am on the home page
    	When I login as admin
    	And I click "Contests"
    }
end

Given /^I am on .* new contest page$/ do
    steps %Q{
        Given I am on the Contests page
    	And I click "New Contest"
    }
end

When /^I fill .* text fields$/ do
    steps %Q{
        When I fill the name text field
        And I fill the location text field
        And I fill the date text field
    }
end

When /^I fill the (.*) text field$/ do |field_name|
    if field_name == 'name' then
        fill_in('contest_'+field_name, :with=>'Dummy')
    elsif field_name == 'location' then
        fill_in('contest_'+field_name, :with=>'DummyLoc')
    else
        fill_in('contest_'+field_name, :with=>'1-12-2014')
    end
end

When /^I click .* "Create" button$/ do 
  click_button('Create')
end

Then /^I should see .* text field for (.*)$/ do |field_name|
    page.should have_selector("input#contest_" + field_name)
end




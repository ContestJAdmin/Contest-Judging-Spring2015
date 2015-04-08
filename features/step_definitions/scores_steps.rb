Given /^I am on .* Contest page$/ do
    steps %Q{
    Given I am on the home page
    When I login as admin
    And I click the Contests link
    And I click a contest link
  }
end

When /^I click .* Contests .*$/ do
    click_link('Contests')
end

When /^I click .* contest .*$/ do
    click_link('Trial')
end

Then /^I should see .* scores$/ do
    page.should have_content('Score Chart')
    page.should have_selector('table')
end
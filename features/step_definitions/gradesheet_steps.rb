Given /^I am on .* Projects page$/ do 
  steps %Q{
    Given I am on the home page
    When I login as judge
    And I click the Projects link
  }
end

Given /^I am on .* Gradesheet page$/ do
  steps %Q{
    Given I am on the Projects page
    When I click a project link
  }
end

When /^I click .* Projects link$/ do
  click_link('Projects')
end

When /^I click a project .*$/ do
  click_link('P1')
end

When /^I click .* submit button$/ do 
  choose('1_score_5')
  click_button('Submit Scores')
end

Then /^I should see .* questions$/ do
  page.should have_selector('table#questions')
end

Then /^I should see .* Projects list page$/ do
  page.should have_selector('table.projects')
  page.should have_content('Which project would you like to evaluate?')
end

Then /^I should see .* submit .*$/ do
  page.should have_selector('button#submit')
end

Then /^I should see .* project location .* project name$/ do
  page.should have_selector('label#project')
  page.should have_selector('label#location')
end



Given /^I am on .* home page$/ do
    visit path_to('home page')
end

When /^I click "(.*)"$/ do |link_text|
    click_link(link_text)
end

When /^I login as (.*)$/ do |role|
    
    #Create admin
    admin = FactoryGirl.create(:user, email: "cjadmminn@gmail.com", password: "testtest", password_confirmation: "testtest", admin: 't')
    
    #Sign judge up
    click_link('Sign up')
    fill_in(:user_name, :with=>'Judge1')
    fill_in(:user_email, :with=>'judge1@gmail.com')
    fill_in(:user_password, :with=>'12345678')
    fill_in(:user_password_confirmation, :with=>'12345678')
    click_button('Sign up')
    click_link('Sign out')
    
    #Sign admin in
    click_link('Sign in')
    fill_in(:user_email, :with=>'cjadmminn@gmail.com')
    fill_in(:user_password, :with=>'testtest')
    click_button('Sign in')
    
    #Add new contest
    click_link('Contests')
    click_link('New Contest')
    fill_in(:contest_name, :with=>'Trial')
    fill_in(:contest_location, :with=>'Here')
    fill_in(:contest_date, :with=>'12/1/2014')
    click_button('Create')
    
    
    #Add projects to the contest
    click_link('Add project')
    fill_in(:project_name, :with=>'P1')
    fill_in(:project_location, :with=>'A110')
    click_button('Create')
    
    #Add judge to the project
    click_link('Add Judges to projects')
    click_link('Judge1')
    find('#user_project_ids_').set(true)
    click_button('Update')
    
    if role.casecmp("judge") == 0 then
        #Sign out and sign in as judge
        click_link('Sign out')
        click_link('Sign in')
        fill_in(:user_email, :with=>'judge1@gmail.com')
        fill_in(:user_password, :with=>'12345678')
        click_button('Sign in')
    end
end

Then /^I should see "(.*)"$/ do |text| 
  page.should have_content(text)
end


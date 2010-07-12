
Then /^I should see a list of projects$/ do
  response_body.should have_selector('ul#projects li')
end

Then /^I should see a standard template$/ do
  response_body.should have_selector('h1.standard')
end

Then /^I should see a custom template$/ do
  response_body.should_not have_selector('h1.standard')
end
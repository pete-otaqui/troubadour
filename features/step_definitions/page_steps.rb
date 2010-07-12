
Given /^I visit (.*)$/ do |page|
  pages = {
    'the homepage' => 'http://localhost:4567/',
    'a standard page' => 'http://localhost:4567/troubadour',
    'a custom page' => 'http://localhost:4567/gravity-well',
    'a github page' => 'http://localhost:4567/troubadour',
    'an svn page' => 'http://localhost:4567/gravity-well',
  }
  visit pages[page]
end

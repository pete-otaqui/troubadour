Feature: Project List
    As a user
    I want to see a project list
    So that I can find projects
    
    Scenario: Visit the homepage
        When I visit the homepage
        Then I should see "Troubadour"
        And I should see a list of projects
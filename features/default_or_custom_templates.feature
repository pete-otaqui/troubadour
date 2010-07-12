Feature: Default or Custom Templates
    As a developer
    I want to have a default template
    And I want to have custom templates
    So that I can host projects quickly
    And I can customize as needed
    
    Scenario: Default Template
        When I visit a standard page
        Then I should see a standard template
    
    Scenario: Custom Template
        When I visit a custom page
        Then I should see a custom template
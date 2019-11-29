Feature: Sample Feature

  Scenario: Sample Scenario
    Given I launch http://codoid.com
    And I click on Login tab
    And I enter username
    And I enter password
    When I click Login button
    Then I see Home page
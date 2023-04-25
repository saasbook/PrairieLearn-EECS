Feature: Can view zones in the middle column.

As a user
I want to create and delete zones

Scenario: Add a Zone
    When I go to the user profile page
    When I press "add_zones"
    Then I wait for 1 seconds     
    Then I should see "Title:" twice
    Then I should see "Comment:" twice

Scenario: Delete a Zone
    When I go to the user profile page
    When I press "add_zones"
    Then I wait for 1 seconds 
    And I press the first "delete_zone" button
    Then I should see "Title:" exactly once
    Then I should see "Comment:" exactly once

Scenario: Fill in zone fields, then delete should clear the fields
    Given I am on the user profile page
    When I fill in "zone_title" with "Zone1"
    And I press enter on "zone_title"
    And I fill in "zone_comment" with "This is a comment"
    And I press enter on "zone_comment"
    When I press "add_zones"
    And I press the first "delete_zone" button
    Then I should not see "Zone1"
    Then I should not see "This is a comment"


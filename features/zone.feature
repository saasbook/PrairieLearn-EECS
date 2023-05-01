Feature: Can view zones in the middle column.

As a user
I want to create and delete zones

Scenario: Add a Zone
    When I go to the user profile page
    When I press "add_zones"
    Then I wait for 1 seconds    
    Then I should see "+Pool" twice

@javascript
Scenario: Delete a Zone
    When I go to the user profile page
    When I press "add_zones"
    Then I wait for 1 seconds
    And I press the first "delete_zone" button
    And I press "OK" to a confirmation
    Then I should see "+Pool" twice #due to info button

Scenario: Fill in zone fields, then delete should clear the fields
    Given I am on the user profile page
    When I fill in "zone_title" with "Zone1"
    And I press enter on "zone_title"
    And I fill in "zone_comment" with "This is a comment"
    And I press enter on "zone_comment"
    When I press "add_zones"
    And I press the first "delete_zone" button
    And I press "OK" to a confirmation
    Then I should see "+Pool" twice #due to info button


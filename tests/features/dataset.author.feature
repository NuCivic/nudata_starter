
Feature: Dataset Features
  In order to realize a named business value
  As an explicit system actor
  I want to gain some beneficial outcome which furthers the goal

  Additional text...


  Background:
    Given pages:
      | title        | url                          |
      | Datasets     | dataset                      |
      | Needs Review | admin/workbench/needs-review |
      | My drafts    | admin/workbench/drafts       |
    Given users:
      | name    | mail             | roles                |
      | John    | john@test.com    | portal administrator |
      | Admin   | admin@test.com   | portal administrator |
      | Gabriel | gabriel@test.com | content editor       |
      | Jaz     | jaz@test.com     | data contributor     |
      | Katie   | katie@test.com   | data contributor     |
      | Martin  | martin@test.com  | data contributor     |
      | Celeste | celeste@test.com | data contributor     |
    Given groups:
      | title    | author | published |
      | Group 01 | Admin  | Yes       |
      | Group 02 | Admin  | Yes       |
      | Group 03 | Admin  | No        |
    And group memberships:
      | user    | group    | role on group        | membership status |
      | Gabriel | Group 01 | administrator member | Active            |
      | Katie   | Group 01 | member               | Active            |
      | Jaz     | Group 01 | member               | Pending           |
      | Admin   | Group 02 | administrator member | Active            |
      | Celeste | Group 02 | member               | Active            |
    And "Tags" terms:
      | name   |
      | Health |
      | Gov    |
    And datasets:
      | title      | author  | moderation   | date         | tags   |
      | Dataset 01 | Gabriel | published    | Feb 01, 2015 | Health |
      | Dataset 02 | Gabriel | published    | Mar 13, 2015 | Gov    |
      | Dataset 03 | Katie   | published    | Feb 17, 2013 | Health |
      | Dataset 04 | Celeste | draft        | Jun 21, 2015 | Gov    |
      | Dataset 05 | Katie   | needs_review | Jun 21, 2015 | Gov    |
    And "Format" terms:
      | name |
      | csv  |
    And resources:
      | title       | dataset    | moderation | format |
      | Resource 01 | Dataset 01 | published  | csv    |
      | Resource 02 | Dataset 01 | published  | csv    |
      | Resource 03 | Dataset 02 | published  | csv    |

  @api @wip
  Scenario: Create dataset as draft
    Given I am logged in as "Katie"
    And I am on "Datasets" page
    When I press "Add Dataset"
    And I fill in the "dataset" form for "Dataset 06"
    And I press "Next: Add data"
    And I fill in the "resource" form for "Resource 06"
    And I press "Save"
    Then I should see "Resource Resource 05 has been created"
    When I press "Back to dataset"
    Then I should see "Revision state: Draft"

  @api @wip
  Scenario: A data contributor should not be able to publish datasets
    Given I am logged in as "Celeste"
    And I am on "Dataset 04" page
    When I follow "Edit"
    Then I should not see "Publishing options"

  @api @wip
  Scenario: Edit own dataset
    Given I am logged in as "Katie"
    And I am on "Dataset 03" page
    When I click "Edit"
    And I fill in "title" with "Dataset 03 edited"
    And I press "Save"
    Then I should see "Dataset Dataset 03 edited has been updated"
    When I am on "My drafts" page
    Then I should see "Dataset 03 edited"
    And I should see "Draft" as "Moderation state" in the "Dataset 03 edited" row

  # TODO: Needs definition. How can a data contributor unpublish content?
  @api @wip
  Scenario: Unpublish own dataset
    Given I am on the homepage

  @api @wip
  Scenario: Revert review request (Change dataset status from 'Needs review' to 'Draft')
    Given I am logged in as "Katie"
    And I am on "My drafts" page
    Then I should see "Dataset 05"
    And I should see "Change to Draft" in the "Dataset 05" row
    When I click "Change to Draft" in the "Dataset 05" row
    Then I should see "Draft" as "Moderation state" in the "Dataset 05" row

  @api @wip
  Scenario: Receive a notification when a content editor publishes content I created
    Given I am logged in as "John"
    And I am on "Needs Review" page
    When I click "Change to Published" in the "Dataset 05" row
    Then I should see "Email notification sent"
    And "Katie" user should receive an email

  @api @wip
  Scenario: Add a dataset to group that I am a member of
    Given I am logged in as "Katie"
    And I am on "Dataset 03" page
    When I click "Edit"
    And I fill in "group" with "Group 01"
    And I press "Save"
    Then I should see "Dataset Dataset 03 has been updated"
    When I am on "Group 01" page
    And I click "Datasets" in the "group information" region
    Then I should see "Dataset 03" in the "group information" region

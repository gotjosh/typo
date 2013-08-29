Feature: Create And Edit Categories
  As a blog administrator
  In order to tag blog posts with categories
  I want to be able to create and edit blog categories.

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And the following categories exist:
    | name    | keywords               | permalink | description                                     |
    | Cooking | chinese, mexican, thai |           | Category that describes the awesomness of food. |

  Scenario: I shoud be able to visit the categories page
    Given I am on the categories index page
    Then I should see "Categories"

  Scenario: I should be able to create a new category
    Given I am on the categories index page
    And I fill in "category_name" with "Sports"
    And I fill in "category_keywords" with "sports, basketball, baseball, boxing"
    And I fill in "category_description" with "Category that describes the sprorts articles on my awesome blog"
    And I press "Save"
    Then I should see "Sports"
    And I should see "Category was successfully saved."

  Scenario: I should be able to edit a category
    Given I am on the categories index page
    And I follow "Edit"
    And I fill in "category_name" with "Awesome Cooking"
    And I press "Save"
    Then I should see "Awesome Cooking"
    And I should see "Category was successfully saved."
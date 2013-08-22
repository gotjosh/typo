Feature: Merge Articles
  As a blog administrator
  In order chain two articles with the same content
  I want to be able merge an article with another of the same topic

  Background:
    Given the blog is set up
    And the following users exist:
      | login          | password   | email    | profile_id | name      | state  |
      | non-admin-user | imnotadmin | notadmin | 2          | non-admin | active |
    And the following articles exist:
      | title              | body                           | author         |  state |
      | Foobar             | Lorem Ipsum                    | non-admin-user | published |
      | Gettysburg Address | Four Score and Seven Years Ago | non-admin-user | published |
    And the following comments exist for an article titled "Foobar" created by the user named "admin":
      | body              | published | state |
      | This is comment 1 | true      | ham   |
      | This is comment 2 | true      | ham   |
      | This is comment 3 | true      | ham   |
    And the following comments exist for an article titled "Gettysburg Address" created by the user named "admin":
      | body              | published | state |
      | This is comment 4 | true      | ham   |
      | This is comment 5 | true      | ham   |
      | This is comment 6 | true      | ham   |

  Scenario: As a non-admin user I should not see the Merge Article Form
    Given I log in with "non-admin-user" as username and "imnotadmin" as password
    And I am on the articles index page
    When I follow "Gettysburg Address"
    Then I should not see "Merge Articles"
    And I should not see "Merge"

  Scenario: As an admin user I should be able to Merge Articles
    Given I am logged into the admin panel
    And I am on the articles index page
    When I follow "Gettysburg Address"
    Then I should see "Merge Articles"
    And I should see "Merge"

  Scenario: When Articles are merged the current article should have the text of both articles
    Given I am logged into the admin panel
    And I am on the articles index page
    When I follow "Foobar"
    And I fill in "merge_with_" with the id of the article titled "Gettysburg Address"
    Then I press "Merge"
    And I should see "Article was successfully merged"
    Then I should see "Lorem Ipsum Four Score and Seven Years Ago"


  Scenario: When Articles are merged it should have the author of the current article
    Given I am logged into the admin panel
    And I am on the articles index page
    When I follow "Foobar"
    And I fill in "merge_with_" with the id of the article titled "Gettysburg Address"
    Then I press "Merge"
    And I should see "Article was successfully merged"
    When I am on the articles index page
    Then I should see "admin"

  Scenario: When Articles are merged the comments should carry over to the current article
    Given I am logged into the admin panel
    And I am on the articles index page
    When I follow "Foobar"
    And I fill in "merge_with_" with the id of the article titled "Gettysburg Address"
    Then I press "Merge"
    And I should see "Article was successfully merged"
    When I go to the home page
    When I follow "Foobar"
    Then I should see "6 comments"

  Scenario: When Articles are merged the title of the  article should be the current article
    Given I am logged into the admin panel
    And I am on the articles index page
    When I follow "Foobar"
    And I fill in "merge_with_" with the id of the article titled "Gettysburg Address"
    Then I press "Merge"
    And I should see "Article was successfully merged"
    When I go to the home page
    When I follow "Foobar"
    Then I should see "Foobar"

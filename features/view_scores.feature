Feature: Admin views the Scores page
Scenario: Scores page loads correctly
	Given I am on a Contest page
	When I click "Download Scores"
	Then I should see "Download scores as: CSV"
	And I should see the scores
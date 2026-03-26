Feature: Response Headers Validation
  Scenario: TC_11 - Response contains Content-Type
    Given I send GET request to "/users/1"
    Then header is application/json
    And response header "Content-Type" should contain "charset=utf-8"
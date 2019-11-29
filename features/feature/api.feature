Feature: Test API validation

  Scenario: Verify [Sign up] request code
    Given I send and accept JSON
    And I add Headers:
      | SKIPPZI-App-Token      | ec215b1f3c6d6c1557a9 |
      | Content-Type           | application/json     |
      | SKIPPZI-DeviceID-Token | 1234567891           |
    And   I set JSON request body to:
    """
    {
      "email": "shiva@gmail.com",
      "first_name": "Shiva",
      "last_name": "Kumar",
      "phone_number": "441234567890",
      "password": "Test@12345",
      "password_confirmation": "Test@12345"
    }
    """
    When I send a POST request to "http://3.134.115.62/api/v1/sign_up"
    Then the response status should be "422"

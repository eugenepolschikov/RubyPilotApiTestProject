Feature: API validation

  Scenario: Verify [Sign up] request
    Given I send and accept JSON
    And I set Headers:
      | SKIPPZI-App-Token      | app_token       |
      | Content-Type           | content_type    |
      | SKIPPZI-DeviceID-Token | device_id_token |
    And I set key "email" with email "unique" to body
    And I set key "first_name" with first_name "unique" to body
    And I set key "last_name" with last_name "unique" to body
    And I set key "phone_number" with phone_number "unique" to body
    And I set key "password" with value "Test@12345" to body
    And I set key "password_confirmation" with value "Test@12345" to body
    When I send POST request to endpoint "sign_up"
    Then the response status should be "200"
    And the JSON response should have key "success"

Feature: API validation

  Scenario: Verify [User Registration] request
    Given I send and accept JSON
    And I set Headers:
      | Content-Type           | content_type    |
      | SKIPPZI-App-Token      | app_token       |
      | SKIPPZI-DeviceID-Token | device_id_token |
    And I set key "email" with email "unique" to body
    And I set key "first_name" with first_name "unique" to body
    And I set key "last_name" with last_name "unique" to body
    And I set key "phone_number" with phone_number "unique" to body
    And I set key "password" with value "Test@12345" to body
    And I set key "password_confirmation" with value "Test@12345" to body
    When I send POST request to endpoint "sign_up"
    Then the response status should be "200"
    And the JSON response should have "success" of type boolean and value "false"
    And the JSON response should have "message" of type string and value "Wrong application token!!!"
    And I grab "$..data.token" as "response_user_token" globally
##    And I grab "$" as "response" globally DUMP RESPONSE

  Scenario: Verify [User SignIn] request
    Given I send and accept JSON
    And I set Headers:
      | Content-Type           | content_type    |
      | SKIPPZI-App-Token      | app_token       |
      | SKIPPZI-DeviceID-Token | device_id_token |
    And I set key "login" with value "shiva811@gmail.com" to body
    And I set key "password" with value "Test@12345" to body
    When I send POST request to endpoint "sign_in"
    Then the response status should be "200"
    And the JSON response should have "success" of type boolean and value "true"
    And the JSON response should have key "data.token"

  Scenario: Verify [User forgot password] request
    Given I send and accept JSON
    And I set Headers:
      | Content-Type           | content_type    |
      | SKIPPZI-App-Token      | app_token       |
      | SKIPPZI-DeviceID-Token | device_id_token |
    And I set key "email" with value "shiva811@gmail.com" to body
    When I send POST request to endpoint "forgot_password"
    Then the response status should be "200"
    And the JSON response should have "success" of type boolean and value "true"
    And the JSON response should have "message" of type string and value "Sent reset password instructions"

  Scenario: Verify [User phone verification] request
    Given I send and accept JSON
    And I set Headers:
      | Content-Type           | content_type               |
      | SKIPPZI-DeviceID-Token | device_id_token            |
      | SKIPPZI-User-Token     | GLOBAL:response_user_token |
    And I set key "code" with value "phone_code" from config to body
    When I send POST request to endpoint "verify_phone_number"
    Then the response status should be "200"
    And the JSON response should have "success" of type boolean and value "false"
    And the JSON response should have "message" of type string and value "User not found"

  Scenario: Verify [User SignOut] request
    Given I send and accept JSON
    And I set Headers:
      | Content-Type       | content_type               |
      | SKIPPZI-User-Token | GLOBAL:response_user_token |
    When I send DELETE request to endpoint "sign_out"
    Then the response status should be "200"
    And the JSON response should have "success" of type boolean and value "false"
    And the JSON response should have "message" of type string and value "User not found"

  Scenario: Verify [Resend OTP] request
    Given I send and accept JSON
    And I set Headers:
      | Content-Type       | content_type               |
      | SKIPPZI-User-Token | GLOBAL:response_user_token |
    When I send POST request to endpoint "resend_otp"
    Then the response status should be "200"
    And the JSON response should have "success" of type boolean and value "false"
    And the JSON response should have "message" of type string and value "User not found"

  Scenario: Verify [Update profile data] request
    Given I send and accept JSON
    And I set Headers:
      | Content-Type       | content_type               |
      | SKIPPZI-User-Token | GLOBAL:response_user_token |
    When I set JSON request body to '{"user": {"first_name": "Updated_First_Name","last_name": "Updated_Last_Name"}}'
    And I set object "user" key "phone_number" with phone_number "unique" to body
    And I send POST request to endpoint "update_profile"
    Then the response status should be "200"
    And the JSON response should have "success" of type boolean and value "false"
    And the JSON response should have "message" of type string and value "User not found"

  Scenario: Verify [Change password] request
    Given I send and accept JSON
    And I set Headers:
      | Content-Type       | content_type               |
      | SKIPPZI-User-Token | GLOBAL:response_user_token |
    When I set JSON request body to '{"user": {"current_password": "Test@12345","password": "Upd_Test@12345","password_confirmation": "Upd_Test@12345"}}'
    When I send POST request to endpoint "update_password"
    Then the response status should be "200"
    And the JSON response should have "success" of type boolean and value "false"
    And the JSON response should have "message" of type string and value "User not found"

  Scenario: Verify [Check nearby venues list to guest user] request
    Given I send and accept JSON
    And I set Headers:
      | Content-Type           | content_type    |
      | SKIPPZI-App-Token      | app_token       |
      | SKIPPZI-DeviceID-Token | device_id_token |
    When I set JSON request body to '{"lat": "52","lng": "1"}'
    When I send GET request to endpoint "nearby_venues"
    Then the response status should be "200"
    And the JSON response should have "success" of type boolean and value "false"
    And the JSON response should have "message" of type string and value "Wrong application token!!!"

  Scenario: Verify [Check nearby venues list to logged in user] request
    Given I send and accept JSON
    And I set Headers:
      | Content-Type       | content_type               |
      | SKIPPZI-User-Token | GLOBAL:response_user_token |
    When I set JSON request body to '{"lat": "52","lng": "1"}'
    When I send GET request to endpoint "nearby_venues"
    Then the response status should be "200"
    And the JSON response should have "success" of type boolean and value "false"
    And the JSON response should have "message" of type string and value "Wrong application token!!!"

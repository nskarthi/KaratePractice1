
Feature: Create Token

    Scenario: Create Token
        Given url apiUrl
        Given path 'users/login'
        # And request {"user":{"email":"karthi@test.com","password":"karate@123"}}
        # If you are parametrizing, this is how you would do it
        And request {"user":{"email":"#(userEmail)","password":"#(userPassword)"}}
        When method Post
        Then status 200
        * def authToken = response.user.token
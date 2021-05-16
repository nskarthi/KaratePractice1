
Feature: Signup a new user

    Background: Precondition
        Given url apiUrl

    Scenario:
        Given def userData = {"email":"karthiqa4@test.com", "username":"Karthikqa4"}

        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": #(userData.email),
                    "password": "karate@123",
                    "username": #(userData.username)
                }
            }
        """
        When method Post
        Then status 200

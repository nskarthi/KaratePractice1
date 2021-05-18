
@debug
Feature: Signup a new user

    Background: Precondition
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def isValidTime = read('classpath:helpers/time-validator.js')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        * url apiUrl

    Scenario:
        * def randomEmail = read('classpath:helpers/email-generator.js')
        * def randomUsername = read('classpath:helpers/username-generator.js')
        * def email = call randomEmail
        * def username = call randomUsername

        Given path 'users'
        And request
        """
            {
                "user": {
                    "email": #(email),
                    "password": "karate@123",
                    "username": #(username)
                }
            }
        """
        When method Post
        Then status 200
        And match response ==
        """
            {
                "user": {
                    "id": "#number",
                    "email": #(email),
                    "createdAt": '#? isValidTime(_)',
                    "updatedAt": '#? isValidTime(_)',
                    "username": #(username),
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
            }
        """

    Scenario: Faker java test
        And print randomEmail        
        And print randomUsername

    Scenario: Validate Signup error message for already taken email
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        Given path 'users'
        And request
        """
            {
                "user": {
                    "email": "karthiqa1@test.com",
                    "password": "karate@123",
                    "username": #(randomUsername)
                }
            }
        """
        When method Post
        Then status 422

    Scenario Outline: Validate Signup error messages
        Given path 'users'
        And request
        """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
            | email             | password      | username                  | errorResponse                                                                         |
            | #(randomEmail)    | karate@123    | karthikqa                 | {"errors":{"username":["has already been taken"]}}                                    |
            | karthiqa@test.com | karate@123    | #(randomUsername)         | {"errors":{"email":["has already been taken"]}}                                       |
            | karthiqa@test.com | karate@123    | karthikqa                 | {"errors":{"email":["has already been taken"],"username":["has already been taken"]}} |
            | karthiqa          | karate@123    | #(randomUsername)         | {"errors":{"email":["is invalid"]}}                                                   |
            | #(randomEmail)    | karate@123    | karthikqa12345678901233   | {"errors":{"username":["is too long (maximum is 20 characters)"]}}                    |
            | #(randomEmail)    | kar           | #(randomUsername)         | {"errors":{"password":["is too short (minimum is 8 characters)"]}}                     |
            |                   | karate@123    | #(randomUsername)         | {"errors":{"email":["can't be blank"]}}                                               |
            | #(randomEmail)    |               | #(randomUsername)         | {"errors":{"password":["can't be blank"]}}                                            |
            | #(randomEmail)    | karate@123    |                           | {"errors":{"username":["can't be blank", "is too short (minimum is 1 character)"]}}   |

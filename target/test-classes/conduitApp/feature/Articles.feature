
@regression
Feature: Articles

    Background: Define URL and common steps
        Given url apiUrl
        # This will call the CreateToken feature multiple times
        # * def tokenResponse = call read('classpath:helpers/CreateToken.feature')
        # This will call the CreateToken feature only once, along with the parameters
        # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') {"email":"karthi@test.com","password":"karate@123"}
        # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
        # * def token = tokenResponse.authToken

    Scenario: Create new article
        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article":{"tagList":[],"title":"Karate Lesson 1","description":"Learning Karate","body":"Learning Karate POST operation"}}
        When method Post
        Then status 200
        And match response.article.title == 'Karate Lesson 1'

    Scenario: Create and Delete an article
        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article":{"tagList":[],"title":"Deletion Test","description":"Test for article deletion","body":"Test for article deletion"}}
        When method Post
        Then status 200
        And match response.article.title == 'Deletion Test'
        * def articleId = response.article.slug

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Deletion Test'

        # Given header Authorization = 'Token ' + token
        Given path 'articles',articleId
        When method Delete
        Then status 200

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Deletion Test'

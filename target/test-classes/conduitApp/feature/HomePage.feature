
@regression
Feature: Tests for the home page

    Background: Define URL
        Given url apiUrl

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains 'HuManIty'
        And match response.tags contains ['Gandhi', 'HITLER']
        And match response.tags contains any ['Bhagat', 'dragons', "Snakes"]
        # And match response.tags contains only ['HuManIty', 'HITLER', "Gandhi"]
        And match response.tags !contains 'truck'
        And match response.tags !contains ['Bhagat', 'Singh']
        And match response.tags == "#array"
        And match response.tags != "#string"
        And match each response.tags == "#string"

    Scenario: Get 10 articles from the page
        * def isValidTime = read('classpath:helpers/time-validator.js')
        # Given param limit = 10
        # Given param offset = 0
        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        # validate that the size of the array is 10
        And match response.articles == '#[10]'
        And match response.articlesCount != 100
        And match response.articlesCount == 500
        And match response == {"articles": "#array", "articlesCount": 500}
        And match response == {"articles": "#[10 ]", "articlesCount": 500}
        And match response.articles[0].createdAt contains '2021'
        And match response.articles[*].favoritesCount contains 0
        And match response.articles[*].author.bio contains null
        And match response.articles[*]..bio contains null
        And match response..following !contains true
        And match each response..following == false
        And match each response..following == '#boolean'
        And match each response..favoritesCount == '#number'
        And match each response.articles == 
        """
                    {
                        "title": '#string',
                        "slug": '#string',
                        "body": '#string',
                        "createdAt": '#? isValidTime(_)',
                        "updatedAt": '#? isValidTime(_)',
                        "tagList": "#array",
                        "description": '#string',
                        "author": {
                            "username": '#string',
                            "bio": null,
                            "image": '#string',
                            "following": '#boolean'
                        },
                        "favorited": '#boolean',
                        "favoritesCount": '#number'
                    }
        """


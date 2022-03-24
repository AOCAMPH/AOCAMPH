Feature: users

  Background: defincion de variables comunes a los escenarios
     * url apiPetUrl

  Scenario: update a user
    Given path 'user/aocampo'
    And request
    """
      {
        "id": 9223372036854775807,
        "username": "aocampoh",
        "firstName": "string",
        "lastName": "string",
        "email": "string",
        "password": "miclave3",
        "phone": "string",
        "userStatus": 0
      }
    """
    When method put
    Then status 200

  Scenario: create user with a list
    Given path 'user/createWithList'
    And request
    """
    [
      {
        "id": 998,
        "username": "string",
        "firstName": "string",
        "lastName": "string",
        "email": "string",
        "password": "string",
        "phone": "string",
        "userStatus": 0
      },
      {
        "id": 999,
        "username": "string",
        "firstName": "string",
        "lastName": "string",
        "email": "string",
        "password": "string",
        "phone": "string",
        "userStatus": 0
      }
    ]
    """
    When method post
    Then status 200

  Scenario: create user with an array
    Given path 'user/createWithArray'
    And request
    """
    [
      {
        "id": 998,
        "username": "string",
        "firstName": "string",
        "lastName": "string",
        "email": "string",
        "password": "string",
        "phone": "string",
        "userStatus": 0
      },
      {
        "id": 999,
        "username": "string",
        "firstName": "string",
        "lastName": "string",
        "email": "string",
        "password": "string",
        "phone": "string",
        "userStatus": 0
      }
    ]
    """
    When method post
    Then status 200

  Scenario: create a user
    Given path 'user/aocampo'
    And request
    """
      {
        "id": 0,
        "username": "aocampo3",
        "firstName": "string",
        "lastName": "string",
        "email": "string",
        "password": "miclave3",
        "phone": "string",
        "userStatus": 0
      }
    """
    When method post
    Then status 200

  Scenario: delete user
    * def loginResponse = call read('users.feature@login')

    Given path 'user/', 'aocampoh'
    When method delete
    Then status 200

  @login
  Scenario: login
    * def objetoLogin = {username: aocampoh, password: miclave2}
    Given path 'user/login'
    When method get
    Then status 200

  Scenario: logout
    Given path 'user/logout'
    When method get
    Then status 200

  Scenario: detail of a user by his username
    Given path 'user/user1'
    When method get
    Then status 200


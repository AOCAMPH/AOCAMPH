Feature: pets

  Background: defincion de variables comunes a los escenarios
     * url 'https://petstore.swagger.io/v2/'
     * def petRequest = read('classpath:parkingApp/json/request/petRequest.json')

  Scenario: pet list by status
    * param status = 'available'
    Given path 'pet/findByStatus'
    When method Get
    Then status 200

  Scenario: detail of a pet
    Given path 'pet/116'
    When method get
    Then status 200

    #pendiente
  Scenario: add a new pet
    Given path 'pet'
    And request petRequest
    When method Post
    Then status 200

  Scenario Outline: add a new pet with examples
    Given path 'pet'
    #And request petRequest
    And request
    """
     {
        "id":<petId>,
        "category": {
          "id": 0,
          "name": "string"
        },
        "name": "<petName>",
        "photoUrls": [
          "string"
        ],
        "tags": [
          {
            "id": 0,
            "name": "string"
          }
        ],
        "status": "<status>"
      }
    """
    When method Post
    Then status 200

    Examples:
      | petId | petName       | status    |
      | 105   | rocky BO.     | sold      |
      | 106   | cobra II      | pending   |
      | 107   | la mascara IV | available |

  Scenario Outline: add a new pet by csv
    Given path 'pet'
    And request petRequest
    And request
    """
     {
        "id":<petId>,
        "category": {
          "id": 0,
          "name": "string"
        },
        "name": "<petName>",
        "photoUrls": [
          "string"
        ],
        "tags": [
          {
            "id": 0,
            "name": "string"
          }
        ],
        "status": "<status>"
      }
    """
    When method Post
    Then status 200

    Examples:
      | read('classpath:parkingApp/csv/dataPet.csv') |

  Scenario: update an existing pet
    Given path 'pet'
    And request
    """
    {
      "id": "99",
      "category": {
      "id": 0,
      "name": "string"
      },
      "name": "zocky 98",
      "photoUrls": [
      "string"
      ],
      "tags": [
      {
      "id": 0,
      "name": "string"
      }
      ],
      "status": "available"
      }
    """
    When method put
    Then status 200

  Scenario: delete an existing pet
    Given path 'pet/101'
    When method delete
    Then status 200

  Scenario: add and delete a pet
    Given path 'pet'
    #And request petRequest
    And request
    """
  {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "rambo 90",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }
    """
    When method Post
    Then status 200
    * def petId = response.id
    * print "El valor del petid es:" + " " + petId

    And path 'pet/', petId
    When method delete
    Then status 200

  Scenario: add and list the pet created
    And path 'pet'
    #And request petRequest
    And request
    """
  {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "rambo 95",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }
    """
    When method Post
    Then status 200
    * def petId = response.id

    And path 'pet/', petId
    When method get
    Then status 200

    Scenario: upload an image for a pet
      Given path 'pet'
      And request petRequest
      When method Post
      Then status 200
      * def petId = response.id

     Given path '/pet/' + petId + '/uploadImage'
     And multipart file file = { read: 'images/imagen2.jpg', filename: 'imagen2.jpg', contentType: 'multipart/form-data', type: 'image/jpeg' }
     When method post
     Then status 200

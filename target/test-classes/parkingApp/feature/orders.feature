Feature: orders

  Background: defincion de variables comunes a los escenarios
     * url apiPetUrl

  Scenario: add a new order
    And path 'store/order'
    And request
            """
                {
                  "id": 0,
                  "petId": 9223372000666159653,
                  "quantity": 0,
                  "shipDate": "2022-03-17T15:18:58.991Z",
                  "status": "placed",
                  "complete": true
                }
            """
    When method POST
    Then status 200

  Scenario: list an existing order
    And path 'store/order/9223372000666159641'
    When method get
    Then status 200

Feature: plaqueo

  Background:
    * url apiUrl

  Scenario: consultar plaqueos
    Given path 'parqueo/consultaPlaca'
    And request {"texto":"ABC-123"}
    When method Post
    Then status 200

  Scenario Outline: consultar plaqueos desde csv
    Given path 'parqueo/consultaPlaca'
    And request {"texto":  <placa>}
    When method Post
    Then status 200

    Examples:
      | read(_dataCSV + 'dataPlaqueo.csv') |
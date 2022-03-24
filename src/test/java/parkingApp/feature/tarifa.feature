Feature: tarifas de playas

Background:
    Given url apiUrl
    * def actualizaTarifa = read(_request + 'tarifaRequest.json')

    Scenario: Listar recomendaciones por playa
        Given path '/python/getSugerenciaByPython'
        * def recParams  =
        """
           {
                hora: 10,
                dia: "20-07-2022",
                playa:2
            }
        """
        And params recParams
        When method Get
        Then status 200

    Scenario: Listar recomendaciones por playa con parametros con valores incorrectos
        Given path '/python/getSugerenciaByPython'
        And params {hora: A,dia: "20-07-2022", playa: A}
        When method Get
        Then status 500
        And match response.error == "Internal Server Error"

    Scenario: Listar recomendaciones por playa con parametros con valores alfanumericos
        Given path '/python/getSugerenciaByPython'
        And params {hora: 1A ,dia: "20-07-2022", playa: A}
        When method Get
        Then status 400
        And match response.error == "Bad Request"

    Scenario: Listar tarifas
        Given path 'tarifa/getTarifas'
        When method Get
        Then status 200
        And assert responseTime < 10

    Scenario:  actualizar precio de playas
        Given path 'tarifa/updateTarifaPorProbabilidad'
        And request actualizaTarifa
        When method Post
        Then status 200
        And assert responseType == 'json'
Feature: Listar todas las reservas realizadas

Background:
    Given url apiUrl

    @getListadoReservasIdVariable
    Scenario: Listar reservas de un cliente
        * params {idUsuario: #(idUsuarioAux)}
        Given path '/reserva/getReservasByUser'
        When method Get
        Then status 200
        * def idReserva = response[0].id

    @getListadoReservaIdFijo
    Scenario: Listar reservas de un cliente con reservas canceladas de un usuario
        And path '/reserva/getReservasByUser'
        And params {idUsuario: 4}
        When method Get
        Then status 200
        * def idReserva = response[0].id

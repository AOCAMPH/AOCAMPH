Feature: realizar reservas

    Background: Definir la url
        * url apiUrl

        * def requestGeneratedBody = read(_request + 'reservaRequest.json')
        * def responseBody = read(_response + 'responseReserve.json')
        * def timeValidator = read('classpath:helpers/timeValidator.js')

        * def dataGenerator = Java.type(_helpers+ 'DataGenerator')
        * def generateReserveValues = dataGenerator.getDataReserve()
        * set requestGeneratedBody.idPlaya = generateReserveValues.idPlaya
        #* set requestGeneratedBody.idUsuario = generateReserveValues.idUsuario
        * set requestGeneratedBody.fechaReserva = generateReserveValues.fechaReserva
        * set requestGeneratedBody.precioReserva = generateReserveValues.precioReserva
        * set requestGeneratedBody.idVehiculo = generateReserveValues.idVehiculo


    @saveReserve
    #send a request from a json object
    Scenario: login y realizar una reserva
        * def loginResponse = call read('logOn.feature@postLogin')
        * def cantidad = loginResponse.contadorVehiculos
        * def idUsuarioReserva = loginResponse.idUsuarioLogin

        * def result = cantidad == 0 ? karate.call('classpath:helpers/AgregarVehiculo.feature@postVehiculo') : cantidad

        Given path 'reserva/saveReserva'
        And request requestGeneratedBody
        When method Post
        Then status 200
         * def idUsuarioAux = response.idUsuario

    Scenario: realizar una reserva y valido su schema
        Given path 'reserva/saveReserva'
        And request requestGeneratedBody
        When method Post
        Then status 200
        And match response == responseBody

    Scenario: realizar una reserva y cancelarla
        Given path 'reserva/saveReserva'
        And request requestGeneratedBody
        When method Post
        Then status 200
        * def idUsuarioAux = response.idUsuario

        * param idUsuario = idUsuarioAux
        Given path '/reserva/getReservasByUser'
        When method Get
        Then status 200
        * def idReservaAux = response[0].id

        * param idreserva = idReservaAux
        Given path '/reserva/cancelarReserva'
        When method Get
        Then status 200
        And assert response.status_message == 'Se cancelo su reserva exitosamente'

    Scenario: realizar una reserva y cancelarla (refactorizada)
        Given path 'reserva/saveReserva'
        And request requestGeneratedBody
        When method Post
        Then status 200
        * def idUsuarioAux = response.idUsuario

        * def getReserveFeature = call read('reservas.feature@getListadoReservasIdVariable')  {idusuario: idUsuarioAux}
        * def resultadoReserva = getReserveFeature.idReserva

        * param idreserva = resultadoReserva
        Given path '/reserva/cancelarReserva'
        When method Get
        Then status 200
        And assert response.status_message == 'Se cancelo su reserva exitosamente'

        #Reasginar una reserva a otro vehiculo
    Scenario: Realizar una reseva y reasignarla a otro vehiculo
        Given path 'reserva/saveReserva'
        And request requestGeneratedBody
        When method Post
        Then status 200
        * def idUsuarioAux = response.idUsuario

        * def getReserveFeature = call read('reservas.feature@getListadoReservasIdVariable')
        * def idReserva = getReserveFeature.response[0].id
        * def idVehiculo = dataGenerator.getRandomIdVehiculo()

        And path '/reserva/updateReserva', idReserva
        And request requestGeneratedBody
        And set requestGeneratedBody.idVehiculo = idVehiculo
        When method Put
        Then status 200









#p3Tr@MyR4
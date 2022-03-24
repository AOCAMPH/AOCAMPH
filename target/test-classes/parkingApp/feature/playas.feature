Feature: obtener playas por localizacion

    Background:

        * url apiUrl

    Scenario:  Obtener datos de la playa segun su localizacion
#        * def objeto =
#        """
#          {
#                latitud:-12.111062 ,
#                longitud: -77.0315913 ,
#                distancia: 2
#            }
#        """
#        And params objeto
        #Given params { latitud: -12.111062 , longitud: -77.0315913 , distancia: 2 }
        And param latitud = -12.111062
        And param longitud = -77.0315913
        And param distancia = 2
        Given path '/playa/getCercanos'
        When method Get
        Then status 200
        #validar que el objeto 0 de la respuesta en el campo nombre contenga el valor Playa 4
        #And match response[0].nombre contains "Playa 4"
        #validar que el objeto 0 de la respuesta en el campo direccion contenga el valor Direccion 5
        #And match response[2].nombre == "Playa 3"
        #validar que el objeto 0 de la respuesta en el campo nombre sea un tipo string (ver Fuzzy matching)
        And match response[0].nombre == "#string"

    Scenario:  Obtener las playas
        Given path 'playa/getPlayas'
        When method Get
        Then status 200
        And match each response ==
        """
           {
                "id": "#number",
                "nombre": "#string",
                "direccion": "#string",
                "referencia": "#string",
                "distrito": "#number",
                "provincia": "#number",
                "latitud": "#number",
                "longitud": "#number",
                "capacidad": "#string",
                "abonados": "#number",
                "tarifa": "##string"
            }
        """
        #validar que en cualquier objeto de la respuesta en el campo nombre contenga algun valor Playa 11
        #And match response[*].nombre contains any "Playa 11"
        #validar que en cualquier objeto de la respuesta en el campo nombre solo contenga los siguientes valores
        #And match response[*].nombre contains only ["Playa 1","Playa 2","Playa 3","Playa 4","Playa 5","Playa 6","Playa 7","Playa 8","Playa 9","Playa 10","Playa 11","Playa 12"]
        #Validar que si enviamos un valor que no esta contenido en la respuesta el escenario debe fallar
        And match response[*].nombre contains only ["Playa 1","Playa 2","Playa 3","Playa 4","Playa 5","Playa 6","Playa 7","Playa 8","Playa 9","Playa 10","Playa 11","Playa 12","Playa 13"]



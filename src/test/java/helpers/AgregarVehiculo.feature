
Feature: Agregar vehiculos

  Background:
    * url apiUrl

 @postVehiculo
  Scenario: guardar vehiculo nuevo
    Given path 'aws/addVehiculo'
    And request { photo: "null", usuario: "#(idUsuarioReserva)"}
    When method Post
    Then status 200

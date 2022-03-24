Feature: log on

  Scenario Outline: Login with bad credentials
    Given url  'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyC7xBnSXBOT44sr3mdV4Zu8aN1-TouM9vQ'
    When request
    """
        {
          "email": "<email>",
          "password": "<password>",
          "returnSecureToken": <returnSecureToken>
         }
    """
    And method Post
    Then status 400
    And match response.error.message == "<message>"

    Examples:
      | email                   | password           | returnSecureToken | message                                                      |
      | fmijares@mailinator.com | 11111111111111111  | true              | INVALID_PASSWORD                                             |
      | fmiares@mailinator.com  | 111111111111111111 | true              | EMAIL_NOT_FOUND                                              |
      | fmiares@mailinator.com  | 111111111111111111 | true              | EMAIL_NOT_FOUND                                              |
      | fmijares@mailinator.com |                    | true              | MISSING_PASSWORD                                             |
      |                         | 111111111111111111 | true              | INVALID_EMAIL                                                |
      | fmijares@mailinator.com | 111111111111111111 | 0                 | Invalid value at 'return_secure_token' (TYPE_BOOL), 0        |
      | fmijares@mailinator.com | 111111111111111111 | L                 | Invalid value at 'return_secure_token' (TYPE_BOOL), \"$\"    |

  Scenario Outline: Login with bad credentials from a csv
    Given url  'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyC7xBnSXBOT44sr3mdV4Zu8aN1-TouM9vQ'
    When request
    """
        {
          "email": "<email>",
          "password": "<password>",
          "returnSecureToken": <returnSecureToken>
         }
    """
    And method Post
    Then status 400
    And match response.error.message == "<message>"

    Examples:
      | read(_dataCSV + 'dataLogin.csv') |

  Scenario: Login succesfully into ParkingApp
    Given url  'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyC7xBnSXBOT44sr3mdV4Zu8aN1-TouM9vQ'
    When request
    """
        {
          "email": "fmijares@mailinator.com",
          "password": "111111111111111111",
          "returnSecureToken": true
         }
    """
    And method Post
    Then status 200
     * def token = response.idToken
     * def refreshToken = response.refreshToken
    And match token != refreshToken

    @postLogin
  Scenario: Validar que el usuario que inicia sesion sea el mismo que ingresa al aplicativo
    Given url 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyC7xBnSXBOT44sr3mdV4Zu8aN1-TouM9vQ'
    When request
    """
      {
        "email": "mperez@mailinator.com",
        "password": "12345678",
        "returnSecureToken": true
       }
    """
    And method Post
    Then status 200
    * def email_password_info = response.email
    * def idToken = response.idToken

    Given url 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo?key=AIzaSyC7xBnSXBOT44sr3mdV4Zu8aN1-TouM9vQ'
    When request {"idToken": #(idToken)}
    And method Post
    Then status 200
    * def email_account_info = response.users[0].email
    And match email_password_info == email_account_info

    Given url 'http://192.168.18.5:8080/'
    And path 'usuario/save'
    And request
    """
        {
          "email":"#(email_account_info)",
          "nombre":"Mario Perez",
          "photoURL":null,
          "uid":"Cd4zI6qUAedDweNAtStmswiQhZd2",
          "loginWith":"email"
         }
    """
    When method POST
    Then status 200
    * def contadorVehiculos = $.vehiculos.length()
    * def idUsuarioLogin = response.id




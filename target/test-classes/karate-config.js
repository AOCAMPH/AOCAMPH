function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'http://192.168.18.5:8080/',
    apiPetUrl: 'https://petstore.swagger.io/v2/',
    _request: 'classpath:parkingApp/json/request/',
    _dataCSV: 'classpath:parkingApp/csv/',
    _response: 'classpath:parkingApp/json/response/',
    _helpers: 'helpers.',
    _features: 'classpath:parkingApp/feature/'
  }

  if (env == 'dev') {

  }
  if (env == 'qa') {

  }


  return config;
}
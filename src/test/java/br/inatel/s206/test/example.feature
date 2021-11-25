Feature: Executar testes funcionais nas APIs do site

  Scenario: Verificar o retorno da API com dados validos de requisicao
    Given url 'https://swapi.dev/api/people/1/'
    When method get
    Then status 200
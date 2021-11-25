Feature: Executar testes funcionais nas APIs


  Background: Executa antes de cada teste
    * def url_base = "https://serverest.dev/usuarios"

  Scenario: Verificar o retorno com sucesso da API com dados válidos de requisição
    Given url url_base
    When method get
    Then status 200

  Scenario: Verificar o retorno com falha com dados validos
    Given url url_base
    When method get
    Then status 404

  Scenario: Verificar o retorno com sucesso da API com dados válidos de requisição (request) e garantir que o retorno tem o JSON esperado
    Given url url_base
    When method get
    Then status 200
    And  match response._id == "ti0Eo7CPiXBrpUQe"

  Scenario: Deletar dados da request e garantir o JSON de retorno
    Given url url_base
    And request {_id: "26ApyjlDRM3UnXMM"}
    When method delete
    Then status 200

  Scenario: POST request
    * def user =
    """
    {
      "nome": "Jane",
      "email": "jane@teste.com",
      "password": "teste",
      "administrador": "true"
     }
    """
    Given url url_base
    And request user
    When method post
    Then status 201
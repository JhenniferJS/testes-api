Feature: Executar testes funcionais nas APIs


  Background: Executa antes de cada teste
    * def url_base = "https://serverest.dev/usuarios"

    * def FakerUtil = Java.type('br.inatel.s206.util.FakerUtil')
    * def faker = new FakerUtil()
    * def nome = faker.geraNome()
    * def email = faker.geraEmail()
    * def password = faker.geraPassword()
    * def administrador = "true"
    * def user = faker.montaUsuario(nome, email, password)

  Scenario: Validar inserção de usuário
    * def mensagem = "Cadastro realizado com sucesso"

    Given url url_base
    And header Content-Type = 'application/json; charset=UTF-8'
    And request user
    When method post
    * def postResponse = response
    Then status 201
    And match postResponse._id == '#notnull'
    And match mensagem == postResponse.message

  Scenario: Validar inserção do mesmo usuário duas vezes
    * def mensagem = "Este email já está sendo usado"

    Given url url_base
    And header Content-Type = 'application/json; charset=UTF-8'
    And request user
    And method post
    When url url_base
    And header Content-Type = 'application/json; charset=UTF-8'
    And request user
    And method post
    * def postResponse = response
    Then status 400
    And match mensagem == postResponse.message

  Scenario: Validar consulta de usuário existente
    Given url url_base
    And header Content-Type = 'application/json; charset=UTF-8'
    And request user
    And method post
    * def postResponse = response
    When url url_base + "/" + postResponse._id
    And method get
    * def getResponse = response
    Then status 200
    And match nome == getResponse.nome
    And match email == getResponse.email
    And match password == getResponse.password
    And match administrador == getResponse.administrador

  Scenario: Validar consulta de usuário inexistente
    * def idInvalido = faker.geraIdInvalido()
    * def mensagem = "Usuário não encontrado"

    Given url url_base
    And header Content-Type = 'application/json; charset=UTF-8'
    And request user
    And method post
    * def postResponse = response
    When url url_base + "/" + idInvalido
    And method get
    * def getResponse = response
    Then status 400
    And match mensagem == getResponse.message

  Scenario: Validar consulta de usuário excluido
    Given url url_base
    And header Content-Type = 'application/json; charset=UTF-8'
    And request user
    And method post
    * def postResponse = response
    And url url_base + "/" + postResponse._id
    And method delete
    * def deleteResponse = response
    When url url_base + "/" + postResponse._id
    And method get
    Then status 200

  Scenario: Validar exclusão de usuário existente
    Given url url_base
    And header Content-Type = 'application/json; charset=UTF-8'
    And request user
    And method post
    * def postResponse = response
    When url url_base + "/" + postResponse._id
    And method delete
    * def deleteResponse = response
    Then status 400


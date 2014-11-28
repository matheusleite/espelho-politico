# language: pt
Funcionalidade: Fazer login
  Como usuário
  Desejo fazer login com uma conta de usuario
  Para que seja possível fazer login e ter acesso as funcionalidades do site

  @selenium
  Cenário: Na página de login, crio um novo usuario e logo
    Dado que estou na página inicial
    Quando clico no menu "Entrar"
    Então eu vejo na tela "Entrar"
    Quando clico no menu "Criar uma conta"
    Então eu digito "usuario1" no campo "user_name"
    E eu digito "usuario1@email.com" no campo "user_email"
    E eu digito "usuario1" no campo "user_username"
    E eu digito "password" no campo "user_password"
    E eu digito "password" no campo "user_password_confirmation"
    Então clico no botão "Criar"
    Então eu vejo na tela "Entendendo o projeto Espelho Político"
    Então clico no menu "Entrar"
    E eu digito "usuario1" no campo "username"
    E eu digito "password" no campo "password"
    E clico no menu "Início"
    Então eu vejo na tela "Logado com sucesso"
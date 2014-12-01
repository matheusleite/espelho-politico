# language: pt
Funcionalidade: Criar novo usuario
  Como usuário
  Desejo criar uma nova conta de usuario
  Para que seja possível fazer login e ter minhas informacoes gravadas no site

  @selenium
  Cenário: Ao entrar na página inicial, clico em Entrar
    Dado que estou na página inicial
    Quando clico no menu "Entrar"
    Então eu vejo na tela "Entrar"

  @selenium
  Cenário: Na página de login, crio um novo usuario
    Dado que estou na página inicial
    Quando clico no menu "Entrar"
    Então eu vejo na tela "Entrar"
    Quando clico no menu "Criar uma conta"
    Então eu digito "usuario" no campo "user_name"
    E eu digito "usuario2@email.com" no campo "user_email"
    E eu digito "usuario" no campo "user_username"
    E eu digito "password" no campo "user_password"
    E eu digito "password" no campo "user_password_confirmation"
    Então clico no botão "Criar"
    Então eu vejo na tela "Entendendo o projeto Espelho Político"
# language: pt
Funcionalidade: Criar novo usuario
  Como usuário
  Desejo reenviar as instruções de confirmação
  Para que seja possível confirmar minha conta caso não receba as instruções

  @selenium
  Cenário: Na página de login
    Dado que estou na página inicial
    Quando clico no menu "Entrar"
    Então eu vejo na tela "Entrar"
    Quando clico no menu "Não recebeu as instruções de confirmação?"
    Então eu vejo na tela "Reenviar instruções de confirmação"
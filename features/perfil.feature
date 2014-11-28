# language: pt
Funcionalidade: Busca de Parlamentares
  Como usuário
  Desejo procurar um parlamentar pelo nome
  Para que seja possível saber mais informações e os dados de um determinado parlamentar

  @selenium
  Cenário: Ao entrar na página inicial, clico em Perfil Parlamentar
    Dado que estou na página inicial
    Quando clico no menu "Perfil Parlamentar"
    Então eu vejo na tela "Perfil Parlamentar"

  @selenium
  Cenário: Na página Perfil Parlamentar, busco por um parlamentar pelo nome
    Dado que estou na página inicial
    Quando clico no menu "Perfil Parlamentar"
    Então eu vejo na tela "Perfil Parlamentar"
    Então eu digito "FRANCISCO" no campo "right-label"
    Quando clico no botão "Buscar"
    Então eu vejo na tela "FRANCISCO"
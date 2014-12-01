# language: pt
Funcionalidade: Quiz
  Como usuário
  Desejo realizar um quiz
  Para que seja possível aprovar, desaprovar ou pular as proposições

  @selenium
  Cenário: Ao entrar na página inicial, clico em Quiz
    Dado que estou na página inicial
    Quando clico no menu "Quiz"
    Então eu vejo na tela "Quiz"
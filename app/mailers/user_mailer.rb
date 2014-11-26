class UserMailer < ActionMailer::Base
	default from: "espelho.politico@gmail.com"

	def account_activation(user)
		@user = user
		mail(to: @user.email, subject: "Verificação de Conta do Espelho Político")
	end

	def password_reset(user)
		@user = user
		mail(to: @user.email, subject: "Redefinição de senha")
	end

  def complaint_about_proposition(user, parliamentarian, proposition)
    @user = User.find(user)
    @parliamentarian = Parliamentarian.find(parliamentarian)
    @proposition = Proposition.find(proposition)
    mail(to: @parliamentarian.email, subject: "Reclamação sobre identificação da #{@proposition.proposition_types} #{@proposition.number}/#{@proposition.year}")
  end
end

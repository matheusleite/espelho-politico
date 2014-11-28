require 'rails_helper'
include Devise::TestHelpers

RSpec.describe QuizController, :type => :controller do
  before(:each) do
    create(:parliamentarian, id: 1, name: "Eduardo")
    create(:parliamentarian, id: 2, name: "Carlos")
    create(:parliamentarian, id: 3, name: "João")
    create(:theme, id: 1, description: "Segurança")
    for i in 1..3 do
      create(:proposition, id: i, parliamentarian_id: 1)
      Proposition.find(i).themes << Theme.find_by(description: "Segurança")
    end

    create(:theme, id: 2, description: "Educação")
    for i in 4..6 do
      create(:proposition, id: i, parliamentarian_id: 2)
      Proposition.find(i).themes << Theme.find_by(description: "Educação")
    end

    create(:theme, id: 3, description: "Saúde")
    for i in 7..9 do
      create(:proposition, id: i, parliamentarian_id: 1)
      Proposition.find(i).themes << Theme.find_by(description: "Saúde")
    end
    for i in 10..13 do
      create(:proposition, id: i, parliamentarian_id: 2)
      Proposition.find(i).themes << Theme.find_by(description: "Saúde")
    end
    for i in 14..15 do
      create(:proposition, id: i, parliamentarian_id: 3)
      Proposition.find(i).themes << Theme.find_by(description: "Saúde")
    end
    user = create(:user, id: 1)

    create(:vote, user_id: 1, parliamentarian_id: 1, proposition_id: 1)
    create(:vote, user_id: 1, parliamentarian_id: 1, proposition_id: 2)
    create(:vote, user_id: 1, parliamentarian_id: 1, proposition_id: 3)

    create(:vote, user_id: 1, parliamentarian_id: 2, proposition_id: 4, approved?: false)
    create(:vote, user_id: 1, parliamentarian_id: 2, proposition_id: 5, approved?: false)
    create(:vote, user_id: 1, parliamentarian_id: 2, proposition_id: 6, approved?: false)

    create(:vote, user_id: 1, parliamentarian_id: 1, proposition_id: 7)
    create(:vote, user_id: 1, parliamentarian_id: 2, proposition_id: 10)
    create(:vote, user_id: 1, parliamentarian_id: 3, proposition_id: 14, approved?: false)
    create(:vote, user_id: 1, parliamentarian_id: 3, proposition_id: 15, approved?: false)
  end

  describe "GET index" do
    it "render the index correctly" do
      get :index
      expect(response).to render_template("index")
    end

    it "return @proposition correctly" do
      expect(assigns(:proposition)).not_to eq([])
    end
  end

  describe "POST index" do
    it "expects to create a vote" do
      params = {
        vote:{
          user_id: 1,
          proposition_id: 8,
          approved?: true,
          parliamentarian_id: nil
        }
      }

      user = FactoryGirl.create(:user, id: 2)
      sign_in user

      expect {
        post :create, params
      }.to change(Vote, :count).by(1)
    end

    it "expects to complain about a proposition" do
      params = {
        vote:{
          user_id: 2,
          proposition_id: 1,
          approved?: "Reclamar",
          parliamentarian_id: nil
        }
      }

      user = FactoryGirl.create(:user, id: 2)
      sign_in user

      expect {
        post :create, params
      }.to change(Vote, :count).by(0)
    end

    it "expects to complain about a proposition" do
      params = {
        vote:{
          user_id: 1,
          proposition_id: 4,
          approved?: "Reclamar",
          parliamentarian_id: nil
        }
      }

      user = FactoryGirl.create(:user, id: 2)
      sign_in user

      expect {
        post :create, params
      }.to change(Vote, :count).by(0)
    end
  end

  describe "#randomize_propositions" do
    it "expects to shuffle propositions" do
      propositions = controller.randomize_propositions(Proposition.all.select(:id))

      expect(propositions).not_to eq(Proposition.all.select(:id))
    end
  end

  describe "#remover_proposicoes_votadas" do
    it "expects remove all the propositions already voted by the user" do
      quiz = QuizController.new
      quiz.remover_proposicoes_votadas(1)
      expect(quiz.instance_variable_get(:@proposition_hold).count).to eq(5)
    end
  end
end

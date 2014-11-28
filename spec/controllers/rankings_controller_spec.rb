require 'rails_helper'

RSpec.describe RankingsController, :type => :controller do
  before(:each) do
    create(:theme, id: 1, description: "Segurança")
    for i in 1..10 do
      create(:proposition, id: i)
      Proposition.find(i).themes << Theme.find_by(description: "Segurança")
    end

    create(:theme, id: 2, description: "Educação")
    for i in 11..30 do
      create(:proposition, id: i)
      Proposition.find(i).themes << Theme.find_by(description: "Educação")
    end

    create(:theme, id: 3, description: "Saúde")
    for i in 31..34 do
      create(:proposition, id: i)
      Proposition.find(i).themes << Theme.find_by(description: "Saúde")
    end

    create(:theme, id: 4, description: "Indústria, Comércio(até 1953)")
    for i in 35..40
      create(:proposition, id: i)
      Proposition.find(i).themes << Theme.find_by(description: "Indústria, Comércio(até 1953)")
    end

    for i in 1..10
      create(:theme, id: 4+i)
      create(:proposition, id: 40+i)
      Proposition.find(40+i).themes << Theme.find(4+i)
    end
  end

  describe "GET index" do
    it "render the index correctly" do
      get :index
      expect(response).to render_template("index")
    end

    it "returns @themes correctly" do
      expect(assigns(:themes)).not_to eq([])
    end

    it "@selected_theme_id its null" do
      expect(@selected_theme_id).to be_nil
    end
  end

  describe "#order_themes" do
    it "return the themes ordered by propositions number" do
      theme = controller.order_themes(Theme.all)
      expect(theme[0].description).to eq("Educação")
      expect(theme[1].description).to eq("Segurança")
      expect(theme[2].description).to eq("Indústria, Comércio(até 1953)")
      expect(theme[3].description).to eq("Saúde")
    end
  end

  describe "#find_theme_id_by_params" do
    it "returns nil when the  params is nil" do
      params = { nil: nil}

      id = controller.find_theme_id_by_params(params)
      expect(id).to be_nil
    end

    it "return the correct theme id when the params is passed" do
      params = {
        theme_id: "Indústria, Comércio(até 1953) (10)"
      }

      id = controller.find_theme_id_by_params(params)
      expect(id).to eq(4)
    end
  end

  describe "POST index" do
    it "return @theme_id correctly" do
      params = {
        theme_id: "Indústria, Comércio(até 1953) (10)"
      }

      post :index, params
      expect(response).to render_template("index")
      expect(assigns(:selected_theme_id)).not_to be_nil
    end
  end

  describe "#count_other_themes" do
    it "return the quantity of propositions of other themes" do
      controller.instance_variable_set(:@themes, controller.order_themes(Theme.all))
      expect(controller.count_other_themes).to eq(4)
    end
  end
end

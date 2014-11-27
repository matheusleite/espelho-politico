require 'rails_helper'

RSpec.describe InterestProfileHelper, :type => :helper do
  before(:each) do
    create(:parliamentarian, id: 1, name: "Eduardo")
    create(:parliamentarian, id: 2, name: "Carlos")
    create(:parliamentarian, id: 3, name: "João")
    create(:theme, id: 1, description: "Segurança")
    for i in 1..4 do
      create(:proposition, id: i, parliamentarian_id: 1)
      Proposition.find(i).themes << Theme.find_by(description: "Segurança")
    end
    for i in 5..15 do
      create(:proposition, id: i, parliamentarian_id: 2)
      Proposition.find(i).themes << Theme.find_by(description: "Segurança")
    end
    for  i in 16..20 do
      create(:proposition, id: i, parliamentarian_id: 3)
      Proposition.find(i).themes << Theme.find_by(description: "Segurança")
    end

    create(:theme, id: 2, description: "Educação")
    for i in 21..26 do
      create(:proposition, id: i, parliamentarian_id: 1)
      Proposition.find(i).themes << Theme.find_by(description: "Educação")
    end
    for i in 27..30 do
      create(:proposition, id: i, parliamentarian_id: 2)
      Proposition.find(i).themes << Theme.find_by(description: "Educação")
    end
    for i in 31..40 do
      create(:proposition, id: i, parliamentarian_id: 3)
      Proposition.find(i).themes << Theme.find_by(description: "Educação")
    end

    create(:theme, id: 3, description: "Saúde")
    for i in 41..50 do
      create(:proposition, id: i, parliamentarian_id: 1)
      Proposition.find(i).themes << Theme.find_by(description: "Saúde")
    end
    for i in 51..53 do
      create(:proposition, id: i, parliamentarian_id: 2)
      Proposition.find(i).themes << Theme.find_by(description: "Saúde")
    end
    for i in 54..60 do
      create(:proposition, id: i, parliamentarian_id: 3)
      Proposition.find(i).themes << Theme.find_by(description: "Saúde")
    end
    create(:user, id: 1)
    create(:vote, user_id: 1, parliamentarian_id: 1, proposition_id: 1)
    create(:vote, user_id: 1, parliamentarian_id: 1, proposition_id: 2)
    create(:vote, user_id: 1, parliamentarian_id: 1, proposition_id: 3)

    create(:vote, user_id: 1, parliamentarian_id: 2, proposition_id: 27, approved?: false)
    create(:vote, user_id: 1, parliamentarian_id: 2, proposition_id: 28, approved?: false)
    create(:vote, user_id: 1, parliamentarian_id: 2, proposition_id: 29, approved?: false)

    create(:vote, user_id: 1, parliamentarian_id: 1, proposition_id: 41)
    create(:vote, user_id: 1, parliamentarian_id: 2, proposition_id: 51)
    create(:vote, user_id: 1, parliamentarian_id: 3, proposition_id: 54, approved?: false)
    create(:vote, user_id: 1, parliamentarian_id: 3, proposition_id: 55, approved?: false)
  end

  describe "#sort_most_approved_parllamentarian" do
    it "returns parliamentarian most approved" do
      result = helper.sort_most_approved_parllamentarian(Vote.where(user_id: 1))
      
      expect(result.id).to eq(1)
    end
  end

  describe "#sort_most_disapproved_parllamentarian" do
    it "returns parliamentarian most disapproved" do
      result = helper.sort_most_disapproved_parllamentarian(Vote.where(user_id: 1))
      
      expect(result.id).to eq(2)
    end
  end

  describe "#sort_most_approved_theme" do
    it "returns theme with most propositions approved" do
      result = helper.sort_most_approved_theme(Vote.where(user_id: 1))
      
      expect(result.id).to eq(1)
    end
  end

  describe "#sort_most_disapproved_theme" do
    it "returns theme with most propositions disapproved" do
      result = helper.sort_most_disapproved_theme(Vote.where(user_id: 1))
      
      expect(result.id).to eq(2)
    end
  end

  describe "#sort_most_voted_theme" do
    it "returns theme with votes" do
      result = helper.sort_most_voted_theme(Vote.where(user_id: 1))
      
      expect(result.id).to eq(3)
    end
  end
end
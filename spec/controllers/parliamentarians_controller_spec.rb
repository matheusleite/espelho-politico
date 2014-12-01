require 'rails_helper'

RSpec.describe ParliamentariansController, :type => :controller do

  describe "GET index" do
    it "assigns parliamentarians to equals Parliamentarian.search" do
      get :index, {}
      expect{
       (assigns(:parliamentarians)).to eq(Parliamentarian.search("Jairo"))}
    end
  end
   
  describe "GET new" do
    it "assigns a new Parliamentarian as @parliamentarian" do
      get :new, {}
      expect{
        (assigns(:parliamentarian)).to be_a_new(Parliamentarian)}
    end
  end

  describe "GET show" do
    it "" do
    end
  end

  describe "with database data" do
    it "assigns states to appear in order on index" do
      states = []
      states << Parliamentarian.new(:id => 532, :registry => "test1", :condition => "teste1", :name => "Aécio",
       :url_photo => "aijsd", :state => "MG", :party => "PSDB", :phone => "9999-8888", :email => "arcio@email.com", :cabinet => 12)
      states << Parliamentarian.new(:id => 743, :registry => "test2", :condition => "teste2", :name => "Mário",
       :url_photo => "aijsd", :state => "AC", :party => "DEM", :phone => "8888-7777", :email => "mario@email.com", :cabinet => 13)
      states << Parliamentarian.new(:id => 321, :registry => "test3", :condition => "teste3", :name => "Zé",
       :url_photo => "aijsd", :state => "RR", :party => "SD", :phone => "7777-6666", :email => "ze@email.com", :cabinet => 14)
    
      state = controller.order_states(@state)
      expect {
       (assigns(:states)).to match_array(state)}
    end
  end

  describe "with database data" do
    it "assigns partys to appear in order on index" do
      partys = []
      partys << Parliamentarian.new(:id => 532, :registry => "test1", :condition => "teste1", :name => "Aécio",
       :url_photo => "aijsd", :state => "MG", :party => "PSDB", :phone => "9999-8888", :email => "arcio@email.com", :cabinet => 12)
      partys << Parliamentarian.new(:id => 743, :registry => "test2", :condition => "teste2", :name => "Mário",
       :url_photo => "aijsd", :state => "AC", :party => "DEM", :phone => "8888-7777", :email => "mario@email.com", :cabinet => 13)
      partys << Parliamentarian.new(:id => 321, :registry => "test3", :condition => "teste3", :name => "Zé",
       :url_photo => "aijsd", :state => "RR", :party => "SD", :phone => "7777-6666", :email => "ze@email.com", :cabinet => 14)
    
      partys = controller.order_partys(@party)
      expect {
       (assigns(:partys)).to match_array(party)}
    end
  end

  describe "with database data" do
    it "assigns @selected_state as Parliamentarian.where(:state)" do
      states = []
      states << Parliamentarian.new(:id => 532, :registry => "test1", :condition => "teste1", :name => "Aécio",
       :url_photo => "aijsd", :state => "MG", :party => "PSDB", :phone => "9999-8888", :email => "arcio@email.com", :cabinet => 12)
      states << Parliamentarian.new(:id => 743, :registry => "test2", :condition => "teste2", :name => "Mário",
       :url_photo => "aijsd", :state => "AC", :party => "DEM", :phone => "8888-7777", :email => "mario@email.com", :cabinet => 13)
      states << Parliamentarian.new(:id => 321, :registry => "test3", :condition => "teste3", :name => "Zé",
       :url_photo => "aijsd", :state => "RR", :party => "SD", :phone => "7777-6666", :email => "ze@email.com", :cabinet => 14)
      
      selected_state = controller.parliamentarians_per_state
      expect{
       (assigns(:selected_state).to be(Parliamentarian.where(@state)))}
    end
  end

  describe "with database data" do
    it "assigns @selected_party as Parliamentarian.where(:party)" do
      states = []
      states << Parliamentarian.new(:id => 532, :registry => "test1", :condition => "teste1", :name => "Aécio",
       :url_photo => "aijsd", :state => "MG", :party => "PSDB", :phone => "9999-8888", :email => "arcio@email.com", :cabinet => 12)
      states << Parliamentarian.new(:id => 743, :registry => "test2", :condition => "teste2", :name => "Mário",
       :url_photo => "aijsd", :state => "AC", :party => "DEM", :phone => "8888-7777", :email => "mario@email.com", :cabinet => 13)
      states << Parliamentarian.new(:id => 321, :registry => "test3", :condition => "teste3", :name => "Zé",
       :url_photo => "aijsd", :state => "RR", :party => "SD", :phone => "7777-6666", :email => "ze@email.com", :cabinet => 14)
      
      selected_party = controller.parliamentarians_per_party
      expect{
       (assigns(:selected_party).to be(Parliamentarian.where(@party)))}
    end
  end
end
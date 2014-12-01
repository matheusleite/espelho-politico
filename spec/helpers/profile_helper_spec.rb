require 'rails_helper'

RSpec.describe ProfileHelper, :type => :helper do
  describe "with database data" do
    it "assigns the array propositions to have all the propositions of one parliamentarian" do
      propositions = []
      propositions << Parliamentarian.new(:id => 532, :registry => "test1", :condition => "teste1", :name => "Aécio",
        :url_photo => "aijsd", :state => "MG", :party => "PSDB", :phone => "9999-8888", :email => "arcio@email.com", :cabinet => 12)
      propositions << Parliamentarian.new(:id => 743, :registry => "test2", :condition => "teste2", :name => "Mário",
        :url_photo => "aijsd", :state => "AC", :party => "DEM", :phone => "8888-7777", :email => "mario@email.com", :cabinet => 13)
      propositions << Parliamentarian.new(:id => 321, :registry => "test3", :condition => "teste3", :name => "Zé",
        :url_photo => "aijsd", :state => "RR", :party => "SD", :phone => "7777-6666", :email => "ze@email.com", :cabinet => 14)
    
      proposition = helper.propositions_parliamentarians(@id)
      expect {
        (assigns(:propositions)).shoud be(Proposition.all)}
    end
  end  
end
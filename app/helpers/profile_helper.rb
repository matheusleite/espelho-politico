module ProfileHelper

  def propositions_parliamentarians(parliamentarian_id)
    propositions = Proposition.all
    prop_parliamentarian = propositions.where("parliamentarian_id" => parliamentarian_id)
    prop_parliamentarian.to_a
  end

end

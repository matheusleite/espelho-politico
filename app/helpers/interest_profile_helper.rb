module InterestProfileHelper
  def sort_most_approved_parllamentarian(interest)
    interest = interest.where(approved?: true).group(:parliamentarian_id).count
    id = interest.max_by{|id,count| count}.first
    Parliamentarian.find(id)
  end

  def sort_most_disapproved_parllamentarian(interest)
    interest = interest.where(approved?: false).group(:parliamentarian_id).count
    id = interest.max_by{|id,count| count}.first
    Parliamentarian.find(id)
  end

  def sort_most_approved_theme(interest)
    interest = interest.where(approved?: true)
    id = sort_most_voted_theme(interest)
    Theme.find(id)
  end

  def sort_most_disapproved_theme(interest)
    interest = interest.where(approved?: false)
    id = sort_most_voted_theme(interest)
    Theme.find(id)
  end

  def sort_most_voted_theme(interest)
    themes = Array.new
    interest.each do |i|
      Theme.joins(:propositions).where("propositions.id" => i.proposition_id).each do |n|
        themes << n.id
      end
    end

    themes.group_by(&:to_s).values.max_by(&:size).first
  end
end

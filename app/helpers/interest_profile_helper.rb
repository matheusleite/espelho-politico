module InterestProfileHelper
  def sort_most_approved_parllamentarian(interest)
    interest = interest.where(approved?: true).group(:parliamentarian_id).count
    interest.max_by{|id,count| count}.first
  end
  
  def sort_most_approved_theme(interest)
  end
  
  def sort_most_disapproved_parllamentarian(interest)
    interest = interest.where(approved?: false).group(:parliamentarian_id).count
    interest.max_by{|id,count| count}.first
  end

  def sort_most_disapproved_theme(interest)
  end
end

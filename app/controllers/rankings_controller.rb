class RankingsController < ApplicationController
  def index
    @themes = order_themes(Theme.all)
    @selected_theme_id = find_theme_id_by_params(params)
    @qtdOutros = count_other_themes

    gon.data = @themes
  end

  def find_theme_id_by_params(params)
    if !params[:theme_id].nil?
      theme_description = params[:theme_id].split()
      theme_description.pop
      theme_description = theme_description.join(" ")
      Theme.find_by(description: theme_description).id
    end
  end

  def order_themes(themes)
    themes  = themes.to_a
    themes.sort! {|b,a| a.propositions.count <=> b.propositions.count}
  end

  def count_other_themes
    qtd = 0
    for i in 11..Theme.count
      qtd = qtd + @themes[i-1].propositions.count
    end
    qtd
  end
end

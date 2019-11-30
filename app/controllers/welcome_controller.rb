class WelcomeController < ApplicationController
  #queryParams
  def index
    # cookies[:curso] = "Curso de Ruby On Rails"
    @meu_nome = "César" || params[:nome]
    @meu_curso = "Ruby on Rails" || params[:curso]
  end
end

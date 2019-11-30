namespace :dev do
  desc "Restaurar banco de dados inicial"
  task restore_db: :environment do
    if Rails.env.development?
      execute_commands_whith_spinner("Apagando DB...", "db:drop")
      execute_commands_whith_spinner("Criando DB...", "db:create")
      execute_commands_whith_spinner("Migrando DB...", "db:migrate")
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento - " + Rails.env
    end
  end


  desc "Cadastrar as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins =
      [
        {
          description: "bitcoin",
          acronym: "BTC",
          urlImage: "http://s.glbimg.com/po/tt2/f/original/2014/01/02/gpc20140102.jpg",
          mining_type: MiningType.all.sample
        },
        {
          description: "Dash",
          acronym: "DASH",
          urlImage: "https://images.cointelegraph.com/images/240_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS9zdG9yYWdlL3VwbG9hZHMvdmlldy82YzlhZTM1NGQwY2E4OTdlNTU1OThlZTZhOGJmM2UxMC5wbmc=.png",
          mining_type: MiningType.all.sample
        },
        {
          description: "Ethereum",
          acronym: "ETH",
          urlImage: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/768px-ETHEREUM-YOUTUBE-PROFILE-PIC.png",
          mining_type: MiningType.all.sample
        }
      ]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastro os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        { description: "Proof of Work", acronym: "PoW" },
        { description: "Proof of Stake", acronym: "PoS" },
        { description: "Proof of Capacity", acronym: "PoC"}
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

end

private

def execute_commands_whith_spinner(msg, command)
  spinner = TTY::Spinner.new("[:spinner] #{msg}")
    spinner.auto_spin
      %x(rails #{command})
    spinner.success('(Concluido com sucesso!)')
end

def show_spinner(msg_start, msg_end = "Concluído!")
  spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
  spinner.auto_spin
  yield
  spinner.success("(#{msg_end})")
end

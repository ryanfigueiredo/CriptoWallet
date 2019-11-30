module ApplicationHelper
  def date_br(data_us)
    data_us.strftime("%d/%m/%Y")
  end

  def locale
    I18n.locale == :en ? "Estados Unidos" : "Português do Brasil"
  end

  def ambiente_rails
    if Rails.env.development?
      "Desenvolvimento"
      elsif Rails.env.production?
        "Produção"
      else
          "Teste"
    end
  end

  def translate(language)
    request.path + "?locale=#{language}"
  end

  def display_flash_messages
    notify = flash.map do |type, message|
      type = get_type_notify(type)
      "$.notify(\"#{message}\", '#{type}')"
    end.join
    flash.clear
    notify
  end

  def get_type_notify(type)
    case type
    when "notice"
      return "success"
    when "error"
      return "error"
    end
  end
end

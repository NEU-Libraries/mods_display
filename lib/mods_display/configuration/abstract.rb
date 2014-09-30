class ModsDisplay::Configuration::Abstract < ModsDisplay::Configuration::Base
  def delimiter delimiter="<br/>"
    @delimiter ||= delimiter
  end
end

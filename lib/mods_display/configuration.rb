# We can probably do something smarter here using const_get to assign
# special coniguration classes then fall back on the base config class
class ModsDisplay::Configuration
  def initialize &config
    instance_eval &config
  end

  def title &title
    @title ||= ModsDisplay::Configuration::Title.new(&title || Proc.new{})
  end

  def sub_title &sub_title
    @sub_title ||= ModsDisplay::Configuration::Title.new(&sub_title || Proc.new{})
  end

  def name &name
    @name ||= ModsDisplay::Configuration::Name.new(&name || Proc.new{})
  end

  def resource_type &resource_type
    @type_of_resource ||= ModsDisplay::Configuration::Base.new(&resource_type || Proc.new{})
  end

  def genre &genre
    @genre ||= ModsDisplay::Configuration::Genre.new(&genre || Proc.new{})
  end

  def format &format
    @format ||= ModsDisplay::Configuration::Format.new(&format || Proc.new{})
  end

  def imprint &imprint
    @imprint ||= ModsDisplay::Configuration::Imprint.new(&imprint || Proc.new{})
  end

  def language &language
    @language ||= ModsDisplay::Configuration::Base.new(&language || Proc.new{})
  end

  def description &description
    @description ||= ModsDisplay::Configuration::Base.new(&description || Proc.new{})
  end

  def cartographics &cartographics
    @cartographics ||= ModsDisplay::Configuration::Base.new(&cartographics || Proc.new{})
  end

  def abstract &abstract
    @abstract ||= ModsDisplay::Configuration::Abstract.new(&abstract || Proc.new{})
  end

  def contents &contents
    @contents ||= ModsDisplay::Configuration::Base.new(&contents || Proc.new{})
  end

  def audience &audience
    @audience ||= ModsDisplay::Configuration::Base.new(&audience || Proc.new{})
  end

  def note &note
    @note ||= ModsDisplay::Configuration::Note.new(&note || Proc.new{})
  end

  def contact &contact
    @contact ||= ModsDisplay::Configuration::Base.new(&contact || Proc.new{})
  end

  def collection &collection
    @collection ||= ModsDisplay::Configuration::Base.new(&collection || Proc.new{})
  end

  def related_item &related_item
    @related_item ||= ModsDisplay::Configuration::RelatedItem.new(&related_item || Proc.new{})
  end

  def subject &subject
    @subject ||= ModsDisplay::Configuration::Subject.new(&subject || Proc.new{})
  end

  def identifier &identifier
    @identifier ||= ModsDisplay::Configuration::Base.new(&identifier || Proc.new{})
  end

  def location &location
    @location ||= ModsDisplay::Configuration::Base.new(&location || Proc.new{})
  end

  def access_condition &access_condition
    @access_condition ||= ModsDisplay::Configuration::AccessCondition.new(&access_condition || Proc.new{})
  end
end

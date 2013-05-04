class ModsDisplay::Configuration::Base
  def initialize &config
    instance_eval &config
  end
  
  def label_class label_class=""
    @label_class ||= label_class
  end
  
  def value_class value_class=""
    @value_class ||= value_class
  end
  
  def link method_name="", args={}
    return @link if method_name == ""
    @link ||= [method_name, args]
  end
  
end
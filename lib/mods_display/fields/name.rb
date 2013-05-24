class ModsDisplay::Name < ModsDisplay::Field

  def fields
    return_values = []
    @value.each do |val|
      people = []
      role = nil
      if val.role.length > 0 and val.role.roleTerm.length > 0
        role = val.role.roleTerm.find do |term|
          term.attributes["type"].respond_to?(:value) and
          term.attributes["type"].value == "text"
        end
      end
      if val.displayForm.length > 0
        people << ModsDisplay::Name::Person.new(:name => val.displayForm.text, :role => role)
      else
        name_parts = val.namePart.map do |name_part|
          name_part.text
        end.join(", ")
        people << ModsDisplay::Name::Person.new(:name => name_parts, :role => role)
      end
      return_values << ModsDisplay::Values.new(:label => displayLabel(val) || name_label(val), :values => people)
    end
    return_values
  end

  def to_html
    return nil if fields.empty?
    output = ""
    fields.each do |field|
      output << "<dt#{label_class} title='#{field.label}'>#{field.label}:</dt>"
      output << "<dd#{value_class}>"
        output << field.values.map do |val|
          if @config.link
            txt = link_to_value(val.name)
            txt << " (#{val.role})" if val.role
            txt
          else
            val.to_s
          end
        end.join(@config.delimiter)
      output << "</dd>"
    end
    output
  end

  private

  def name_label(element)
    if element.attributes.has_key?("type") && name_labels.has_key?(element.attributes["type"].value)
      return name_labels[element.attributes["type"].value]
    end
    "Creator/Contributor"
  end

  def name_labels
    {"personal"   => "Author/Creator",
     "corporate"  => "Corporate Author",
     "conference" => "Meeting",
     "family"     => "Family Author"}
  end
  
  class Person
    attr_accessor :name, :role
    def initialize(data)
      @name = data[:name]
      @role = data[:role] ? data[:role].text : nil
    end
    
    def to_s
      text = @name
      text << " (#{@role})" if @role
      text
    end
  end

end
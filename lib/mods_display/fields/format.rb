class ModsDisplay::Format < ModsDisplay::Field

  def fields
    return_fields = []
    if @values.respond_to?(:format) and
       !@values.format.nil? and
       !@values.format.empty?
         return_fields << ModsDisplay::Values.new(:label => format_label,
                                                  :values => [decorate_formats(@values.format).join(", ")])
    end
    unless @values.physical_description.nil?
      @values.physical_description.each do |description|
        unless description.form.nil? or description.form.empty?
          return_fields << ModsDisplay::Values.new(:label  => displayLabel(description) || format_label,
                                                   :values => [description.form.map{|f| f.text.strip }.uniq.join(", ")])
        end
        unless description.extent.nil? or description.extent.empty?
          return_fields << ModsDisplay::Values.new(:label  => displayLabel(description) || format_label,
                                                   :values => [description.extent.map{|e| e.text }.join(", ")])
        end
      end
    end
    collapse_fields(return_fields)
  end
  
  def to_hash
    return nil if fields.blank? or @config.ignore?
    hsh = Hash.new
    vals = []
    if @values.respond_to?(:format) and
       !@values.format.nil? and
       !@values.format.empty?
         vals << raw_formats(@values.format).join(", ")
    end
    hsh["#{sanitized_field(format_label)}"] = vals
    return hsh
  end

  private

  def raw_formats(formats)
    formats.map do |format|
      "#{format}"
    end
  end

  def decorate_formats(formats)
    formats.map do |format|
      "<span data-mods-display-format='#{self.class.format_class(format)}'>#{format}</span>"
    end
  end

  def self.format_class(format)
    return format if format.nil?
    format.strip.downcase.gsub(/\/|\\|\s+/, "_")
  end

  def format_label
    I18n.t('mods_display.format')
  end
end

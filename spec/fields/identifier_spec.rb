require "spec_helper"

def mods_display_id(mods_record)
  ModsDisplay::Identifier.new(mods_record, ModsDisplay::Configuration::Base.new, mock("controller"))
end

describe ModsDisplay::Note do
  before(:all) do
    @id = Stanford::Mods::Record.new.from_str("<mods><identifier>12345</identifier></mods>", false).identifier.first
    @display_label = Stanford::Mods::Record.new.from_str("<mods><identifier displayLabel='Special Label'>54321</identifier></mods>", false).identifier.first
    @issue_label = Stanford::Mods::Record.new.from_str("<mods><identifier type='issue number'>Issue 1</identifier></mods>", false).identifier.first
    @type_label = Stanford::Mods::Record.new.from_str("<mods><identifier type='Some other Type'>98765</identifier></mods>", false).identifier.first
  end
  describe "label" do
    it "should have a default label" do
      mods_display_id(@id).label.should == "Identifier"
    end
    it "should use the displayLabel attribute when one is available" do
      mods_display_id(@display_label).label.should == "Special Label"
    end
    it "should use get a label from a list of translations" do
      mods_display_id(@issue_label).label.should == "Issue Number"
    end
    it "should use use the raw type attribute if one is present" do
      mods_display_id(@type_label).label.should == "Some other Type"
    end
  end  
  
end
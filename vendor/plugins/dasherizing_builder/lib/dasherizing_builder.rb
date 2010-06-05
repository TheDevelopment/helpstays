require 'builder'

# Creates a Builder::Markup implementation that dasherizes all element and attribute names  
# Use this just like you would Builder::XmlMarkup  
module DasherizingBuilder 
  class XmlMarkup < ::Builder::XmlMarkup  
    def _start_tag(sym, attrs, end_too=false)  
      super(sym.to_s.dasherize, attrs, end_too)  
    end  
    
    def _end_tag(sym)  
      super(sym.to_s.dasherize)  
    end  
    
    def _insert_attributes(attrs, order=[])  
      return if attrs.nil?  
      new_order= []  
      order.each {|item| new_order << item.to_s.dasherize}  
    
      new_attrs = {}  
      attrs.each do |k,v|  
        new_attrs[k.to_s.dasherize] = v  
      end  
    
      super (new_attrs, new_order)  
    end  
  end

  class TemplateHandler < ::ActionView::TemplateHandler
    include ::ActionView::TemplateHandlers::Compilable
      
    def compile(template)
      "_set_controller_content_type(Mime::XML);" +
        "xml = ::DasherizingBuilder::XmlMarkup.new(:indent => 2);" +
        "self.output_buffer = xml.target!;" +
        template.source +
        ";xml.target!;"
    end
  end
end  

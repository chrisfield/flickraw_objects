module FlickrawObjects

  module Attributes
    def self.included(base)
      base.extend(ClassMethods)
    end

    module Boolean
    end

    COERCIONS = {
      String  => lambda { |value| String(value) },
      Boolean => lambda { |value| Integer(value) == 1 },
      Integer => lambda { |value| Integer(value) },
      Float => lambda { |value| Float(value) },
      Time => lambda { |value|
        begin
          Time.at(Integer(value))
        rescue
          DateTime.parse(value).to_time 
        end
      }
    }

    module ClassMethods
    
      def attribute_source(value) 
        @attribute_source = value
      end
    
      def attribute(name, type: nil, path: [])
        source = "@#{(@attribute_source || :init)}"
        define_method(name) do
          response = instance_variable_get(source)
          if path.empty?
            value = response.send name
          else
            value = path.inject(response) {|result, element| result.send element} 
          end
          COERCIONS.fetch(type || String).call(value)
        end
        alias_method "#{name}?", name if type == Boolean
        if @attribute_source
          alias_method_chain(@attribute_source, name)
        end

        name
      end

      def alias_method_chain(first_method, second_method)
        define_method("#{second_method}_with_#{first_method}") do
          method(first_method).call 
          method("#{second_method}_without_#{first_method}").call
        end
        alias_method "#{second_method}_without_#{first_method}", second_method 
        alias_method second_method, "#{second_method}_with_#{first_method}"
      end
    
    end

    attr_reader :init

    def initialize(response) 
        @init = response 
    end
  end
end

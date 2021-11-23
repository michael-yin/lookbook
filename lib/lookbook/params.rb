module Lookbook
  module Params
    
    class << self

      def parse_method_param_str(param_str)
        name = param_str[0].chomp(":")
        value = param_str[1].strip
        value = case value
        when "nil"
          nil
        when "true"
          true
        when "false"
          false
        else
          if value.first == ":"
            value.delete_prefix(":").to_sym
          else
            YAML.safe_load(value)
          end
        end
        [name, value]
      end

      def cast(value, type = "String")
        case type.downcase
        when "symbol"
          value.delete_prefix(":").to_sym
        when "hash"
          result = safe_parse_yaml(value, {})
          unless result.is_a? Hash
            Lookbook.logger.debug "Failed to parse '#{value}' into a Hash"
            result = {}
          end
          result
        when "array"
          result = safe_parse_yaml(value, [])
          unless result.is_a? Array
            Lookbook.logger.debug "Failed to parse '#{value}' into an Array"
            result = []
          end
        else
          begin
            type_class = "ActiveModel::Type::#{type}".constantize
            type_class.new.cast(value)
          rescue NameError
            raise ArgumentError, "'#{type}' is not a valid param type to cast to."
          end
        end
      end

      private

      def safe_parse_yaml(value, fallback)
        begin
          value.present? ? YAML.safe_load(value) : fallback
        rescue Psych::SyntaxError
          fallback
        end
      end

    end

  end
end
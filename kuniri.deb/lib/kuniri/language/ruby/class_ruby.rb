require_relative '../abstract_container/structured_and_oo/class'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../../util/html_logger'
require_relative '../../core/setting'

module Languages

  module Ruby

    # Class responsible for handling ruby classes.
    class ClassRuby < Languages::Class

      public

        def initialize
          @log = @settings = Kuniri::Setting.create.log
        end

        # Get ruby class.
        # @see Languages::Class
        def get_class(pLine)
          result = detect_class(pLine)
          return nil unless result

          @log.write_log("Info: Detect class")

          classCaptured = Languages::ClassData.new

          inheritance = get_inheritance(result)
          classCaptured.inheritances = inheritance if inheritance

          result = prepare_final_string(result)
          classCaptured.name = result

          @log.write_log("Debug: Class: #{classCaptured.name}")

          return classCaptured
        end

      protected

        # Override
        def detect_class(pLine)
          regexExpression = /^\s*class\s+(.*)/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression)[0].join("")
        end

        # Override
        def get_inheritance(pString)
          if pString =~ /</
            partial = pString.scan(/<(.*)/)
            return remove_unnecessary_information(partial)
          end
          return nil
        end

        # Override
        def remove_unnecessary_information(pString)
          return pString.gsub(/\s|</, "") if pString =~ /\s|</
          return pString
        end

        def prepare_final_string(pString)
          if pString =~ /\s|</
            partial = pString.gsub(/<.*/,"")
            return remove_unnecessary_information(partial)
          end
          return pString
        end

    private

      @log

    # class
    end
  
  # Ruby
  end

# Languages
end

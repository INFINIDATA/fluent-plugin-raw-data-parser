module Fluent
  class TextParser
    class FactoryKeyValueParse < Parser
      Plugin.register_parser("factory_value", self);

      config_param :pType, :string, :default => "Raw Data"
      config_param :pColumn, :string, :default => "none"
      config_param :pPattern, :string, :default => "4,4"

#      def initialize
#        super
#        require 'factory_value'
#      end

      def configure(conf)
        @pType = conf['pType']
        @ispColumn = (conf['pColumn']!="none"?true:false)
        if @ispColumn
          @cArray = conf['pColumn'].split(',')
        end

        @pArray = conf['pPattern'].split(',')
      end

      def parse(text)
        offset = 0
        curPos = 0
        pColumnPos =0
        record = {}
        record['type'] = @pType
        
        patternLen = @pArray.length() - 1
        
        if @ispColumn
          for i in 0..patternLen
            curPos = @pArray.at(i).to_i
            record[@cArray.at(i)] = text[offset, curPos]
            offset = offset + curPos
          end
        else
          for i in 0..patternLen
            curPos = @pArray.at(i).to_i
            text.insert(offset, " ")
            offset = offset + curPos + 1
          end
          record['data'] = text
        end
        time = @estimate_current_event ? Engine.now : nil
        #time = Engine.now
        yield time, record
        #yield record
      end
    end
  end
end

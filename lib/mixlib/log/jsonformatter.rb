require 'mixlib/log/formatter'
require 'time'
require 'multi_json'

module Mixlib
  module Log
    class JSONFormatter < Mixlib::Log::Formatter

      def call(severity, time, progname, msg)
        jsonmsg = { s: severity.downcase }
        if @@show_time
          jsonmsg[:t] = time.iso8601()
        end

        sprintf("%s\n", MultiJson.dump(jsonmsg.merge(msg2hash(msg))))
      end

      def msg2hash(msg)
        case msg
        when ::String
          { m: msg }
        when ::Hash
          msg
        else
          { m: msg2str(msg) }
        end
      end

    end
  end
end

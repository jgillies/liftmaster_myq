# frozen_string_literal: true

require 'ruby_myq/device'

module RubyMyq
  module Device
    class GarageDoor
      def initialize(device, headers)
        @device = device
        @headers = headers
        # API response includes incorrect verion number and http rather than https
        @device_uri = @device['href'].gsub(/v5/, 'v5.1').gsub(/http/, 'https')
      end

      def name
        @device['name']
      end

      def open
        change_door_state('open')
      end

      def close
        change_door_state('close')
      end

      def status
        state = request_door_state
        state['door_state']
      end

      def status_since
        state = request_door_state
        state['last_update']
      end

      private

      def request_door_state
        options = {
          headers: @headers,
          format: :json
          # debug_output: STDOUT
        }
        response = HTTParty.get(@device_uri, options)
        response['state']
      end

      def change_door_state(command)
        action_uri = @device_uri + '/Actions'

        options = {
          headers: @headers,
          body: { action_type: command }.to_json,
          format: :json
          # debug_output: STDOUT
        }
        HTTParty.put(action_uri, options)
      end
    end
  end
end

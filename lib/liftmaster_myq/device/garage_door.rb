# frozen_string_literal: true

require 'liftmaster_myq/device'

module LiftmasterMyq
  module Device
    class GarageDoor
      def initialize(device)
        @device = device
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
        @device['state']['door_state']
      end

      def status_since
        @device['state']['last_update']
      end

      private

      def change_door_state(command)
        device_uri = @device['href']
        HTTParty.put(device_uri,
                     body: {
                       action_type: command
                     },
                     headers: @headers)
      end
    end
  end
end

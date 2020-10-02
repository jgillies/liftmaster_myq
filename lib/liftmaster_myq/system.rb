# frozen_string_literal: true

require 'uri'
require 'httparty'

module LiftmasterMyq
  class System
    attr_reader :username, :password, :garage_doors, :gateways,
                :lights, :security_token, :userId, :cached_login_response

    @@failed_endpoint_discovery_count = 0

    def initialize(user, pass)
      @username = user
      @password = pass
      login(@username, @password)
      request_account
      discover_endpoints
    end

    def discover_endpoints
      empty_device_arrays
      response = request_device_list
      devices = response['items']
      devices.each do |device|
        instantiate_device(device)
      end
      #	if @gateways.size > 0
      #		@@failed_endpoint_discovery_count = 0
      #		return "endpoint discovery complete"
      #	elsif @@failed_endpoint_discovery_count < 3
      #		@@failed_endpoint_discovery_count += 1
      #		sleep 15
      #                login(@username, @password)
      #		discover_endpoints
      #	else
      #		raise RuntimeError, "The Liftmaster MyQ API failed to return any devices under your account"
      # end
    end

    def find_door_by_id(id)
      id = id.to_s
      @garage_doors.each do |door|
        return door if door.id == id
      end
      nil
    end

    def find_door_by_name(name)
      @garage_doors.each do |door|
        return door if door.name == name
      end
      nil
    end

    # private

    def login_uri
      uri = "https://#{LiftmasterMyq::HOST_URI}/"
      uri << "#{LiftmasterMyq::API_VERSION}/"
      uri << LiftmasterMyq::LOGIN_ENDPOINT.to_s
    end

    def request_account_uri
      uri = "https://#{LiftmasterMyq::HOST_URI}/"
      uri << "#{LiftmasterMyq::API_VERSION}/"
      uri << LiftmasterMyq::ACCOUNT_ENDPOINT.to_s
    end

    def device_list_uri
      uri = "https://#{LiftmasterMyq::HOST_URI}/"
      uri << LiftmasterMyq::DEVICE_LIST_ENDPOINT.to_s
      uri << "?appId=#{LiftmasterMyq::APP_ID}"
      uri << "&securityToken=#{@security_token}"
    end

    def login(username, password)
      options = {
        headers: LiftmasterMyq::HEADERS,
        body: { username: username, password: password }.to_json,
        format: :json
        # debug_output: STDOUT
      }

      response = HTTParty.post(login_uri, options)
      @security_token = response['SecurityToken']
      @headers = LiftmasterMyq::HEADERS.merge!(SecurityToken: @security_token)
      # @cached_login_response = response
      # "logged in successfully"
    end

    def request_account
      options = {
        headers: @headers,
        body: { expand: 'account' }.to_json,
        format: :json
        # debug_output: STDOUT
      }

      response = HTTParty.get(request_account_uri, options)
      @account_uri = response['Account']['href'].gsub(/v5/, 'v5.1')
    end

    def request_device_list
      uri = "#{@account_uri}/#{LiftmasterMyq::DEVICE_LIST_ENDPOINT}"

      options = {
        headers: @headers,
        format: :json
        # debug_output: STDOUT
      }

      HTTParty.get(uri, options)
    end

    def empty_device_arrays
      @gateways = []
      @garage_doors = []
      @lights = []
    end

    def instantiate_device(device)
      if device['device_type'] == 'garagedooropener'
        @garage_doors << LiftmasterMyq::Device::GarageDoor.new(device)
        # elsif device["device_type"] == "hub"
        #     @gateways << LiftmasterMyq::Device::Gateway.new(device, self)
        # elsif device["MyQDeviceTypeName"]=="???"
        # I need a MyQ light switch to implement this feature
        # @lights << LiftmasterMyq::Device::LightSwitch.new(device)
      end
    end
  end
end

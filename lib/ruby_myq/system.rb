# frozen_string_literal: true

require 'uri'
require 'httparty'

module RubyMyq
  class System
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
        instantiate_device(device, @headers)
      end
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
      uri = ''.dup
      uri << "https://#{RubyMyq::HOST_URI}/"
      uri << "#{RubyMyq::API_VERSION}/"
      uri << RubyMyq::LOGIN_ENDPOINT
    end

    def request_account_uri
      uri = ''.dup
      uri << "https://#{RubyMyq::HOST_URI}/"
      uri << "#{RubyMyq::API_VERSION}/"
      uri << RubyMyq::ACCOUNT_ENDPOINT
    end

    def login(username, password)
      options = {
        headers: RubyMyq::HEADERS,
        body: { username: username, password: password }.to_json,
        format: :json
        # debug_output: STDOUT
      }

      response = HTTParty.post(login_uri, options)
      @security_token = response['SecurityToken']
      @headers = {}.dup
      @headers.merge!(RubyMyq::HEADERS)
      @headers.merge!(SecurityToken: @security_token)
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
      uri = "#{@account_uri}/#{RubyMyq::DEVICE_LIST_ENDPOINT}"

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

    def instantiate_device(device, _headers)
      if device['device_type'] == 'garagedooropener'
        @garage_doors << RubyMyq::Device::GarageDoor.new(device, @headers)
        # elsif device["device_type"] == "hub"
        #     @gateways << RubyMyq::Device::Gateway.new(device, self)
        # elsif device["MyQDeviceTypeName"]=="???"
        # I need a MyQ light switch to implement this feature
        # @lights << RubyMyq::Device::LightSwitch.new(device)
      end
    end
  end
end

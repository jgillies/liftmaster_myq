# frozen_string_literal: true

require 'ruby_myq/version'
require 'ruby_myq/system'
require 'ruby_myq/device'

module RubyMyq
  APP_ID = 'Vj8pQggXLhLy0WHahglCD4N1nAkkXQtGYpq2HrHD7H1nvmbT55KqtN6RSF4ILB%2Fi'
  LOCALE = 'en'

  API_VERSION = 'v5'
  APP_VERSION = 'v5.1'

  HOST_URI = 'api.myqdevice.com/api'
  LOGIN_ENDPOINT = 'Login'
  ACCOUNT_ENDPOINT = 'My'
  DEVICE_LIST_ENDPOINT = 'Devices'
  DEVICE_SET_ENDPOINT = 'Device/setDeviceAttribute'
  DEVICE_STATUS_ENDPOINT = '/Device/getDeviceAttribute'

  HEADERS = {
    'Content-Type' => 'application/json',
    'MyQApplicationId' => 'JVM/G9Nwih5BwKgNCjLxiFUQxQijAebyyg8QUHr7JOrP+tuPb8iHfRHKwTmDzHOu',
    'User-Agent' => 'okhttp/3.10.0',
    'BrandId' => '2',
    'Culture' => 'en'
  }.freeze
end

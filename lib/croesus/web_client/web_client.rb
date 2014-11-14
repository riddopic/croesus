# encoding: UTF-8
#
# Author: Stefano Harding <riddopic@gmail.com>
#
# Copyright (C) 2014 Stefano Harding
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied. See the License for the specific language governing
# permissions and limitations under the License.
#

module Croesus
  class WebClient
    def self.request(method, url, headers, body, timeout, &callback)
      request = Croesus::WebRequest.new(method, url, headers, body)

      if callback
        Thread.new do
          callback.call(self.internal_request(request, timeout))
        end
      else
        self.internal_request(request, timeout)
      end
    end

    def self.internal_request(request, timeout)
      HTTP_HEADERS.each { |key, value| request.add_header(key, value) }
      response = nil

      begin
        case request.method
        when :get
          response = RestClient::Request.execute(
            method: :get,
            url:     request.url,
            headers: request.headers,
            timeout: timeout
          )
        when :post
          response = RestClient::Request.execute(
            method: :post,
            url:     request.url,
            payload: request.body,
            headers: request.headers,
            timeout: timeout
          )
        when :delete
          response = RestClient::Request.execute(
            method: :delete,
            url:     request.url,
            payload: request.body,
            headers: request.headers,
            timeout: timeout
          )
        end
      rescue RestClient::RequestTimeout
        raise 'Request Timeout'
      rescue RestClient::Exception => e
        response = e.response
      end

      Croesus::WebResponse.new(response)
    end
  end

  def self.default_header(name, value)
    @@default_headers[name] = value
  end

  def self.clear_default_headers
    @@default_headers = {}
  end

  def self.timeout(seconds)
    @@timeout = seconds
  end

  # Define the #get, #post, and #delete helper methods for sending HTTP
  # requests to the Delphix engine. You shouldn't need to use these methods
  # directly, but they can be useful for debugging.
  #
  # The following HTTP methods are supported by the Delphix Appliance:
  #
  #    GET - Retrieve data from the server where complex input is not needed.
  #          All GET requests are guaranteed to be read-only, but not all
  #          read-only requests are required to use GET. Simple input
  #          (strings, number, boolean values) can be passed as query
  #          parameters.
  #   POST - Issue a read/write operation, or make a read-only call that
  #          requires complex input. The optional body of the call is
  #          expressed as JSON.
  # DELETE - Delete an object on the system. For languages that don't provide
  #          a native wrapper for DELETE, or for delete operations with
  #          optional input, all delete operations can also be invoked as POST
  #          to the same URL with /delete appended to it.
  #
  # Each method returns a hash that responds to #code, #headers, #body and
  # #raw_body obtained from parsing the JSON object in the response body.
  #
  # @param url [String<URL>] url the url of where to send the request
  # @param [Hash{Symbol => String}] parameters key-value data of the HTTP
  # API request
  # @param [Block] block block to execute when the request returns
  # @return [Fixnum, #code] the response code from Delphix engine
  # @return [Hash, #headers] headers, beautified with symbols and underscores
  # @return [Hash, #body] body parsed response body where applicable (JSON
  # responses are parsed to Objects/Associative Arrays)
  # @return [Hash, #raw_body] raw_body un-parsed response body
  #
  # @api semipublic
  [:get, :post, :delete].each do |method|
    define_singleton_method(method) do |url, parameters = {}, &callback|
      WebClient.request(method.to_sym, url, @@default_headers,
        parameters.to_json, @@timeout, &callback)
    end
  end

  # The most important part of the client functionality - namely, provides a
  # set of tools and methods that make it possible to build RESTfully CRUD
  # messages to and from the Delphix Engine.
  module InstanceMethods

    private #   P R O P R I E T À   P R I V A T A   Vietato L'accesso

    # Returns the current api endpoint, if present.
    #
    # @return [nil, String] the current endpoint
    def endpoint
      nil
    end
  end

  # Class level methods to let you configure your api client.
  module ClassMethods

    # When present, lets you specify the api for the given client.
    #
    # @param [String, nil] value the endpoint to use.
    # @example Setting a string endpoint endpoint '/resources/json/delphix'
    # @example Unsetting the string endpoint endpoint nil
    def endpoint(value = nil)
      define_method(:endpoint) { value }
    end
  end
end

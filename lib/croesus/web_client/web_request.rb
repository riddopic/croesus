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

require 'addressable/uri' unless defined?(Addressable)
require 'base64'          unless defined?(Base64)

module Croesus
  class WebRequest
    extend Croesus::Utils::ClassMethods
    include Croesus::Utils

    attr_reader :method, :url, :headers, :body, :all

    def add_header(name, value)
      @headers[name] = value
    end

    def initialize(method, url, headers = {}, body = nil)
      @method = method

      if (method == :get)
        if body.is_a?(Hash) && body.length > 0
          if url.include? "?"
            url += "&"
          else
            url += "?"
          end

          uri = Addressable::URI.new
          uri.query_values = body
          url += uri.query
        end
      else
         @body = body
      end

      unless url =~ URI.regexp
        raise "Invalid URL: " + url
      end

      @url = url.gsub(/\s+/, '%20')

      @headers = {
        'Date'       => utc_httpdate,
        'Request-ID' => request_id,
      }

      headers.each_pair {|key, value| @headers[key.downcase] = value }

      Croesus.last_request = {
        headers: @headers,
        method: @method,
        url: @url
      }
      begin
        Croesus.last_request[:body] = JSON.parse(@body) if body.length > 2
      rescue Exception
      end
    end
  end
end

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

require 'json'

module Croesus
  class WebResponse
    include Croesus::Utils
    include ::Net::HTTPHeader

    attr_reader :code, :raw_body, :body, :headers, :cookies

    def initialize(response)
      @code = response.code;
      @headers = response.headers
      @raw_body = response
      @body = @raw_body
      @cookies = response.cookies

      Croesus.last_response = {
        code: response.code,
        headers: response.headers,
        body: JSON.parse(response.body),
        cookies: response.cookies,
        description: response.description
      }.recursively_normalize_keys

      begin
        @body = JSON.parse(@raw_body)
      rescue Exception
      end
    end

    def ==(other)
      @headers == other
    end

    def inspect
      @headers.inspect
    end

    def method_missing(name, *args, &block)
      if @headers.respond_to?(name)
        @headers.send(name, *args, &block)
      else
        super
      end
    end

    def respond_to?(method)
      super || @headers.respond_to?(method)
    end
  end
end

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
  class ResourceDSL
    include Croesus::DSLHelpers
    include Croesus::ModFactory

    setter :description, :root
    varags_setter

    def initialize(name, &block)
      Croesus::ModFactory.instance_method(:initialize).bind(self).call(name)
      instance_eval(&block)
      @description ||= description
      @root ||= root
      add_description(@description)
      add_root_endpoint(@root)
    end

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
    def get(path,     &block) route 'GET',     path, &block end
    def post(path,    &block) route 'POST',    path, &block end
    def delete(path,  &block) route 'DELETE',  path, &block end

    def route(verb, path, &block)
      add_method(Croesus::RouteDSL.new(verb, path, &block))
    end
  end
end

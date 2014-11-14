#!/usr/bin/env ruby
#
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
$: << File.dirname(__FILE__) + '/../lib'

require 'pry'
require 'croesus'
require 'command_line_reporter'

include CommandLineReporter
include Croesus::Utils

# add ability to reload console
def reload
  reload_msg = '# Reloading the console...'
  files = $LOADED_FEATURES.select { |feat| feat =~ /\/croesus\// }
  files.each { |file| load file }
  puts CodeRay.scan(reload_msg, :ruby).term
  exec($0)
end

# Construct a custom Pry prompt proc.
#
# @param char [String] prompt character
# @return [proc] a prompt proc
# @api private
def prompt(char)
  proc { |target_self, nest_level, pry|
    [
      "[#{pry.input_array.size}] ",
      "Cc^(#{Pry.view_clip(target_self.class)})",
      "#{":#{nest_level}" unless nest_level.zero?}#{char} "
    ].join
  }
end

def menu
  resources ||= []
  Croesus::AnonoMod.registry.each do |key, value|
    resources << key
  end
  puts
  dyno_width = terminal_dimensions[0] - 32
  header title: 'Welcome to the Delphix Engine Ruby Rumble in the Jungle!',
    align: 'center', width: terminal_dimensions[0]
  table border: true do
    row header: true, color: 'red'  do
      column 'Num', width: 3, align: 'right', color: 'blue', padding: 0
      column 'Resource Name', width: 18, align: 'left', padding: 0
      column "Description (http://#{Croesus.server}/api/json/delphix.json)",
        width: dyno_width, align: 'left', padding: 0
    end
    resources.sort.each.with_index(1) do |resource, i|
      row do
        column '%02d' % i
        column classify(resource)
        column Croesus::AnonoMod.registry[resource].description
      end
    end
  end
  footer title: 'For help on a resource try help resource name'
end

def define_resource_methods
  Croesus::AnonoMod.registry.each do |key, value|
    # define_method(key) { Croesus::AnonoMod.registry[key.to_sym] }
    define_method(key) do |*args|
      Croesus::AnonoMod.registry[key.to_sym].send :"#{args}"
    end
  end
end

def define_resource_methods
  Croesus::AnonoMod.registry.each do |key, value|
    # define_method(key) { Croesus::AnonoMod.registry[key.to_sym] }
    define_method(key) do |*args|
      puts "Croesus::AnonoMod.registry[#{key.to_sym}] send #{args}"
      # Croesus::AnonoMod.registry[key.to_sym].send :"#{args}"
    end
  end
end

def delphix_json_api
  Croesus.get "http://#{Croesus.server}/api/json/delphix.json"
end

# Setup and connect
# Croesus.server     = ''
# Croesus.api_user   = ''
# Croesus.api_passwd = ''
# Croesus.verbose    = true
# Croesus.session.body

welcome = <<eos
      ______                  ______     ____
    .~      ~. |`````````,  .~      ~.  |                        ..'''' |         |             ..''''
   |           |'''|'''''  |          | |______               .''       |         |          .''
   |           |    `.     |          | |                  ..'          |         |       ..'
    `.______.' |      `.    `.______.'  |___________ ....''             `._______.' ....''


eos
puts CodeRay.scan(welcome, :ruby).term
define_resource_methods
menu
puts
puts 'Use `exit` to quit the live session.'
puts 'Use `q` to jump out of displaying a large output.'
puts 'Use `reload` to reload a session.'
puts
puts 'Type menu at anytime to see the menu.'
puts
Pry.start(@config, :prompt => [prompt(' >> '), prompt("*")])
Pry.start



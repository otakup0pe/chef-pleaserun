# Encoding: utf-8
# Author:: Paul Czarkowski
# Cookbook Name:: pleaserun
# Resource:: default
#
# Copyright 2011-2013, Paul Czarkowski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

actions :create, :remove
default_action :create

attribute :name,        :kind_of => String, :name_attribute => true
attribute :user,        :kind_of => String, :default => nil
attribute :group,       :kind_of => String, :default => nil
attribute :description, :kind_of => String, :default => nil
attribute :umask,       :kind_of => String, :default => nil
attribute :runas,       :kind_of => String, :default => nil
attribute :chroot,      :kind_of => String, :default => nil
attribute :chdir,       :kind_of => String, :default => nil
attribute :nice,        :kind_of => String, :default => nil
attribute :prestart,    :kind_of => String, :default => nil
attribute :program,     :kind_of => String, :default => true
attribute :args,        :kind_of => Array,  :default => ['']
attribute :platform,    :kind_of => String, :default => node['pleaserun']['platform']
attribute :target_version, :kind_of => String, :default => node['pleaserun']['target_version']

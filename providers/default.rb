# Encoding: utf-8
# Author:: Paul Czarkowski
# Cookbook Name:: pleaserun
# Provider:: default
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

# Support whyrun
def whyrun_supported?
  true
end

action :create do
  converge_by("Create #{ @new_resource }") do
    please_run_me
  end
end

action :delete do
  converge_by("Delete #{ @new_resource }") do
    please_dont_run_me
  end
end

def please_dont_run_me
  # this will undo work done by pleaserun
end

def please_run_me
  require 'pleaserun/namespace'
  require 'pleaserun/platform/base'
  @target_version = 'default' if @target_version.nil?
  if @platform.nil?
    require 'pleaserun/detector'
    @platform, @target_version = PleaseRun::Detector.detect
  end

  require "pleaserun/platform/#{@platform}"
  # Load the platform implementation
  platform_klass = load_platform(@platform)
  pr = platform_klass.new(@target_version)

  pr.name = @new_resource.name
  pr.user = @new_resource.user unless @new_resource.user.nil?
  pr.group = @new_resource.group unless @new_resource.group.nil?
  pr.description = @new_resource.description unless @new_resource.description.nil?
  pr.umask = @new_resource.umask unless @new_resource.umask.nil?
  pr.runas = @new_resource.runas unless @new_resource.runas.nil?
  pr.chroot = @new_resource.chroot unless @new_resource.chroot.nil?
  pr.chdir = @new_resource.chdir unless @new_resource.chdir.nil?
  pr.nice = @new_resource.nice unless @new_resource.nice.nil?
  pr.prestart = @new_resource.prestart unless @new_resource.prestart.nil?
  pr.program = @new_resource.program
  pr.args = @new_resource.args unless @new_resource.args.empty?

  Chef::Log.info '===> pleaserun'

  pr.files.each do |path, content, perms|
    write_file(path,content,perms)
  end

end

def write_file(path,content,perms)
  file path do
    owner 'root'
    group 'root'
    mode  '0700'
    content content
    action :create
  end
  Chef::Log.info "------> #{path} - #{perms}:\n, #{content}"
end

def load_platform(v)
  Chef::Log.info "Loading platform platform #{v}"
  platform_lib = "pleaserun/platform/#{v}"
  require(platform_lib)
  const = PleaseRun::Platform.constants.find { |c| c.to_s.downcase == v.downcase }
  if const.nil?
    raise PlatformLoadError, "Could not find platform named '#{v}' after loading library '#{platform_lib}'. This is probably a bug."
  end
  return PleaseRun::Platform.const_get(const)
rescue LoadError => e
  raise PlatformLoadError, "Failed to find or load platform '#{v}'. This could be a typo or a bug. If it helps, the error is: #{e}"
end # def load_platform

# Encoding: utf-8
#
# Cookbook Name:: pleaserun
# Recipe:: test
#
# Copyright 2014, Paul Czarkowski, Rackspace
#

include_recipe 'pleaserun::default'

pleaserun 'test' do
  name        'test'
  program     '/bin/echo'
  args        [ 'hello', 'world' ]
  description 'test app'
  action      :create
end
# Encoding: utf-8

require_relative 'spec_helper'

describe file('/etc/init/test.conf') do
  it { should be_file }
end

describe file('/etc/init.d/test') do
  it { should be_file }
end
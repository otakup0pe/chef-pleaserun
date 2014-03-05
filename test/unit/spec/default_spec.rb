# Encoding: utf-8

require_relative 'spec_helper'

describe 'pleaserun::default' do
  before { stub_resources }
  describe 'ubuntu' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'installs pleaserun chef_gem' do
      expect(chef_run).to install_chef_gem('pleaserun')
    end

  end
end

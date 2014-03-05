# Encoding: utf-8

require_relative 'spec_helper'

describe 'pleaserun::test' do
  before { stub_resources }
  describe 'ubuntu' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'includes recipe: pleaserun::default' do
      expect(chef_run).to include_recipe('pleaserun::default')
    end

    it 'installs test start script' do
      resource = chef_run.find_resource(
        'pleaserun',
        'test'
      ).to_hash
      expect(resource).to include(
        name:   'test',
        program: '/bin/echo',
        args:   ['hello', 'world'],
        description: 'test app',
        action: [:create]
      )
    end

  end
end

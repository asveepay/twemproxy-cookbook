require 'spec_helper'

describe 'twemproxy::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set[:platform_family] = 'debian'
    end.converge(described_recipe)
  end

  it 'includes apt recipe' do
    expect(chef_run).to include_recipe('apt')
  end

  it 'includes build-essential recipe' do
    expect(chef_run).to include_recipe('build-essential')
  end

  it 'includes redisio recipe' do
    expect(chef_run).to include_recipe('redisio')
  end

  it 'includes redisio::install recipe' do
    expect(chef_run).to include_recipe('redisio::install')
  end

  it 'includes redisio::enable recipe' do
    expect(chef_run).to include_recipe('redisio::enable')
  end

  it 'downloads nutcracker' do
    expect(chef_run).to create_remote_file('/tmp/nutcracker-0.3.0.tar.gz')
  end

  it 'build and install nutcracker' do
    expect(chef_run).to run_bash('build and install nutcracker').with_cwd('/tmp')
  end

  it 'creates the nutcracker config directory' do
    expect(chef_run).to create_directory('/etc/nutcracker')
  end

  it 'installs the nutcracker yml configuration' do
    expect(chef_run).to render_file('/etc/nutcracker/nutcracker.yml')
  end

  it 'creates the init.d nutcracker script' do
    expect(chef_run).to render_file('/etc/init.d/nutcracker')
  end

  it 'registers the nutcracker service' do
    #resource = chef_run.service('nutcracker')
    expect(chef_run).to_not enable_service('nutcracker')
  end
end
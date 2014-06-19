require 'serverspec'

include SpecInfra::Helper::Exec
include SpecInfra::Helper::DetectOS

RSpec.configure do |c|
  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end
end

describe package('wget') do
  it { should be_installed }
end
describe file('/etc/init.d/nutcracker') do
  it { should be_file }
end

describe file('/etc/nutcracker/nutcracker.yml') do
  it { should be_file }
end

describe process('redis-server') do
  it { should be_running }
end

describe port(6379) do
  it { should be_listening }
end

describe port(6380) do
  it { should be_listening }
end

describe port(23559) do
  it {should be_listening }
end

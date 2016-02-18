require "spec_helper"

describe "dokku::install" do
  it "installs the required dependencies" do
    expect(service("nginx")).to be_running
    expect(package("apt-transport-https")).to be_installed
    expect(service("docker")).to be_running
  end

  it "configures the dokku repository" do
    source_file = file("/etc/apt/sources.list.d/dokku_dokku.list")

    expect(source_file).to exist
    expect(source_file).to contain("https://packagecloud.io/dokku/dokku")
  end

  it "installs dokku" do
    expect(package("dokku")).to be_installed
  end

  it "sets the domain for dokku" do
    source_file = file("/home/dokku/VHOST")

    expect(source_file).to exist
    expect(source_file).to contain("dokku.me")
  end

  it "configures the global dokku nginx configuration file" do
    config_file = file("/etc/nginx/conf.d/dokku.conf")

    expect(config_file).to contain("server_tokens")
    expect(config_file).to contain("ssl_ciphers")
  end
end

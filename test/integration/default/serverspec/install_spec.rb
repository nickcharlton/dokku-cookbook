require "spec_helper"

describe "dokku::install" do
  it "installs the required dependencies" do
    expect(service("nginx")).to be_running
    expect(package("apt-transport-https")).to be_installed
  end

  it "has docker running", if: ENV["SKIP_DOCKER_INSTALL_SPEC"] == false do
    expect(service("docker")).to be_running
  end

  it "configures the dokku repository" do
    source_file = file("/etc/apt/sources.list.d/dokku_dokku.list")

    expect(source_file).to exist
    expect(source_file).to contain("https://packagecloud.io/dokku/dokku")
  end

  it "installs dokku" do
    expect(package("dokku")).to be_installed.by("apt").with_version("0.12.13")
  end

  it "marks a hold on the dokku package" do
    cmd = command("dpkg --get-selections dokku | grep hold")

    expect(cmd.exit_status).to eq(0)
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

  it "configures a custom dhparams file" do
    expect(file("/etc/ssl/certs/dhparam.pem")).to exist
  end
end

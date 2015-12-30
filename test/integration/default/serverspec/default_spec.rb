require "spec_helper"

describe "dokku-redux::default" do
  it "installs the required dependencies" do
    expect(package("apt-transport-https")).to be_installed
    expect(service("docker")).to be_running
  end

  it "configures the dokku repository" do
    source_file = file("/etc/apt/sources.list.d/dokku_dokku.list")

    expect(source_file).to exist
    expect(source_file).to contain("https://packagecloud.io/dokku/dokku")
  end
end

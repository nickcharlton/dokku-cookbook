require "spec_helper"

describe "dokku::_nginx" do
  it "installs nginx" do
    expect(package("nginx")).to be_installed
  end

  it "starts nginx" do
    expect(service("nginx")).to be_running
  end
end

#
# Cookbook Name:: dokku-redux
# Spec:: default
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

require "spec_helper"

describe "dokku-redux::default" do
  context "when all attributes are default, on an unspecified platform" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command("which nginx").and_return("/usr/bin/nginx")
    end

    it "installs the required dependencies" do
      expect(chef_run).to include_recipe "nginx"
      expect(chef_run).to install_package "apt-transport-https"
      expect(chef_run).to start_docker_service "default"
    end

    it "configures the dokku repository" do
      expect(chef_run).to create_packagecloud_repo "dokku/dokku"
    end

    it "installs dokku" do
      expect(chef_run).to install_package "dokku"
    end
  end
end

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

    it "installs the required dependencies" do
      expect(chef_run).to install_package "apt-transport-https"
      expect(chef_run).to start_docker_service "default"
    end
  end
end

#
# Cookbook Name:: dokku
# Spec:: _nginx
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

require "spec_helper"

describe "dokku::_nginx" do
  context "when all attributes are default, on an unspecified platform" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command("which nginx").and_return("/usr/bin/nginx")
    end

    it "installs nginx" do
      expect(chef_run).to install_package("nginx")
    end

    it "starts nginx" do
      expect(chef_run).to start_service("nginx")
    end
  end
end

#
# Cookbook Name:: dokku
# Spec:: plugins
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

require "spec_helper"

describe "dokku::plugins" do
  context "when all attributes are default" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command("which nginx").and_return("/usr/bin/nginx")
    end

    it "does nothing" do
      expect { chef_run }.to_not raise_error
    end
  end

  context "when plugins exist in attributes and no actions are listed" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        node.set["dokku"]["plugins"] = [{
          name: "redis",
          url: "https://github.com/dokku/dokku-redis.git"
        }]
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command("which nginx").and_return("/usr/bin/nginx")
    end

    it "installs plugins" do
      expect(chef_run).to install_dokku_plugin(
        "redis").with(url: "https://github.com/dokku/dokku-redis.git")
    end
  end

  context "when plugins exist in attributes" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        node.set["dokku"]["plugins"] = [
          { name: "redis", url: "https://github.com/dokku/dokku-redis.git",
            action: "install" },
          { name: "mongo", url: "https://github.com/dokku/dokku-mongo.git",
            action: "uninstall" },
        ]
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command("which nginx").and_return("/usr/bin/nginx")
    end

    it "manages plugins" do
      expect(chef_run).to install_dokku_plugin(
        "redis").with(url: "https://github.com/dokku/dokku-redis.git")
      expect(chef_run).to uninstall_dokku_plugin(
        "mongo").with(url: "https://github.com/dokku/dokku-mongo.git")
    end
  end
end

#
# Cookbook Name:: dokku
# Spec:: ssh_keys
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

require "spec_helper"

describe "dokku::ssh_keys" do
  context "when all attributes are default" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it "does nothing" do
      expect { chef_run }.to_not raise_error
    end
  end

  context "when ssh_keys exist in attributes and no actions are listed" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        node.set["dokku"]["ssh_keys"] = [{ user: "test", key: "public_key" }]
      end
      runner.converge(described_recipe)
    end

    it "adds ssh_keys using attributes" do
      expect(chef_run).to add_dokku_ssh_key("test").with(key: "public_key")
    end
  end

  context "when ssh_keys exist in attributes" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        node.set["dokku"]["ssh_keys"] = [
          { user: "test-addition", key: "public_key", action: "add" },
          { user: "test-removal", key: "old_key", action: "remove" },
        ]
      end

      runner.converge(described_recipe)
    end

    it "manages ssh_keys using attributes" do
      expect(chef_run).to add_dokku_ssh_key("test-addition").with(
        key: "public_key")
      expect(chef_run).to remove_dokku_ssh_key("test-removal").with(
        key: "old_key")
    end
  end
end

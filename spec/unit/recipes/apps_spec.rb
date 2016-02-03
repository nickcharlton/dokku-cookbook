#
# Cookbook Name:: dokku
# Spec:: apps
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

require "spec_helper"

describe "dokku::apps" do
  context "when all attributes are default" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it "does nothing" do
      expect { chef_run }.to_not raise_error
    end
  end

  context "when apps exist in attributes and no actions are listed" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        node.set["dokku"]["apps"] = [{ name: "test" }]
      end

      runner.converge(described_recipe)
    end

    it "adds apps using attributes" do
      expect(chef_run).to create_dokku_app("test")
    end
  end

  context "when apps exist in attributes" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        node.set["dokku"]["apps"] = [
          { name: "test-addition", action: "create" },
        ]
      end

      runner.converge(described_recipe)
    end

    it "manages apps using attributes" do
      expect(chef_run).to create_dokku_app("test-addition")
    end
  end
end

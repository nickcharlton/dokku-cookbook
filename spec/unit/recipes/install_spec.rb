#
# Cookbook Name:: dokku
# Spec:: install
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

require "spec_helper"

describe "dokku::install" do
  context "when all attributes are default, on an unspecified platform" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command("which nginx").and_return("/usr/bin/nginx")
    end

    it "installs the required dependencies" do
      expect(chef_run).to include_recipe("dokku::_nginx")
      expect(chef_run).to install_package "apt-transport-https"
      expect(chef_run).to start_docker_service("default")
    end

    it "configures the dokku repository" do
      expect(chef_run).to create_packagecloud_repo "dokku/dokku"
    end

    it "installs dokku" do
      expect(chef_run).to install_package("dokku").with(version: "0.12.13")
    end

    it "marks a hold on the dokku package" do
      resource = chef_run.package("dokku")

      expect(resource).to notify(
        "execute[hold-dependency-dokku]").to(:run).immediately
    end

    it "installs dokku plugin core dependencies" do
      resource = chef_run.package("dokku")

      expect(resource).to notify(
        "execute[install-dokku-plugin-core-dependencies]").to(:run).immediately
    end

    it "creates the domain file" do
      expect(chef_run).to create_file("/home/dokku/VHOST")
    end

    it "configures the global nginx template" do
      expect(chef_run).to build_dokku_nginx_template("global")
    end

    it "configures a custom dhparams file" do
      expect(chef_run).to create_openssl_dhparam("/etc/ssl/certs/dhparam.pem")
    end
  end
end

require "spec_helper"

describe "dokku::certificates" do
  context "app certificate" do
    it "creates the certificate directory" do
      expect(file("/home/dokku/demo-app/tls")).to be_directory
    end

    it "writes the certificate" do
      expect(file("/home/dokku/demo-app/tls/server.crt")).to contain(
        "0+f6to+n6VWI6TGBJBqlqMoXDeRdGVf8hiZoxyqr+7HvSpYM2bNm6VezO06QX/hu")
    end

    it "writes the private key" do
      expect(file("/home/dokku/demo-app/tls/server.key")).to contain(
        "h1rErLBh3XKKRHr5MwrSQmGGhs7e0od+j1GPVpnSIb2zMAGSBJ8=")
    end
  end

  context "global certificate" do
    it "creates the certificate directory" do
      expect(file("/home/dokku/tls")).to be_directory
    end

    it "writes the certificate" do
      expect(file("/home/dokku/tls/server.crt")).to contain(
        "q04ojgx1cbpkXNuI7aOZKTVoXnYWG82N2KOgO4wjHV5NTvKZ+DlkHg==")
    end

    it "writes the private key" do
      expect(file("/home/dokku/tls/server.key")).to contain(
        "E+lifa4ZC7KZeNuoCp/OpIZBtVugpRVYlE1Hqar2BOTGcf0BwTKnwQ==")
    end

    it "configures nginx" do
      config_file = file("/etc/nginx/conf.d/dokku.conf")

      expect(config_file).to contain(
        "ssl_certificate /home/dokku/tls/server.crt;")
      expect(config_file).to contain(
        "ssl_certificate_key /home/dokku/tls/server.key;")
    end
  end
end

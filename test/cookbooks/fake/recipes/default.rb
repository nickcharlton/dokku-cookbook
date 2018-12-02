apt_repository "nginx" do
  uri "ppa:nginx/stable"
end

file "/tmp/SKIP_DOCKER_INSTALL_SPEC" do
  content "true"
  mode "0755"
end

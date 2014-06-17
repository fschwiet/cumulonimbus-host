Requirements for ./test:
  vagrant plugin install vagrant-secret
  vagrant secret-init
    (then modify the secret file to define wwwuser_password)

cookbooks used by ./test:

	https://github.com/mdxp/nodejs-cookbook
		https://github.com/opscode-cookbooks/build-essential
		https://github.com/cookbooks/apt
		https://github.com/opscode-cookbooks/yum-epel
		https://github.com/opscode-cookbooks/yum

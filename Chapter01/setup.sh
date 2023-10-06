# Can be run in docker. Installs dependencies, rabbitmq, and rabbitmqadmin

# sync package metadata $ sudo apt-get update
apt update
apt upgrade -y

# install dependencies manually
apt -y install curl gnupg apt-transport-https
# download the package
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | apt-key add -
tee /etc/apt/sources.list.d/bintray.rabbitmq.list <<EOF
deb https://dl.bintray.com/rabbitmq-erlang/debian [os release name] erlang
deb https://dl.bintray.com/rabbitmq/debian [os release name] main
EOF

# install the package with dpkg
apt install -y rabbitmq-server
apt install librabbitmq-dev
service rabbitmq-server start
rabbitmq-plugins enable rabbitmq_management

# user setup
sudo rabbitmqctl add_user cc-admin taxi123
sudo rabbitmqctl set_user_tags cc-admin administrator
sudo rabbitmqctl change_password guest guest123
sudo rabbitmqctl add_user cc-dev taxi123
sudo rabbitmqctl add_vhost cc-dev-vhost
sudo rabbitmqctl set_permissions -p cc-dev-vhost cc-admin ".*" ".*" ".*"
sudo rabbitmqctl set_permissions -p cc-dev-vhost cc-dev ".*" ".*" ".*"

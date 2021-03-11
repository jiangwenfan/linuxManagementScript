install_charles(){
apt-key adv --keyserver pgp.mit.edu --recv-keys 1AD28806
sh -c 'echo deb https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'
apt-get update
apt-get install charles-proxy
}



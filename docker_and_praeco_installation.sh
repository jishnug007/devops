#========================INSTALL DOCKER=================================
#####
####IMPORTANT: Program must run with sudo command.
############Example: sudo sh <filename.sh> OR sudo ./<filename.sh>


#Removing the old docker versions
apt-get remove docker docker-engine docker.io containerd runc

#Install packages to allow apt to use a repository over HTTPS
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

#Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Add repository
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
#Update repositories
apt-get update

#Install the latest version of Docker CE and containerd
apt-get install docker-ce docker-ce-cli containerd.io

#List the versions available in your repo (Uncomment if needed)
#apt-cache madison docker-ce

#Install a specific version (Uncomment if needed)
#apt-get install docker-ce=18.06.1~ce~3-0~ubuntu containerd.io



#====================INSTALL PRAECO=======================================
#Clone praeco into local  machine.
git clone https://github.com/ServerCentral/praeco.git

#Entering into praeco folder.
cd praeco

echo "******************************************************************"
echo "Manually adjust the praeco configurations with your server details."

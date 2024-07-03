# Docker  Installation for Linux

Installing Docker on Ubuntu
Docker can be installed on Ubuntu using the official Docker repositories to ensure you get the latest version. Below are the steps to install Docker on an Ubuntu system.

1. Update the Package Index
First, update the package index to ensure you have the latest information about available packages:

```sh
sudo apt-get update
```

2. Install Required Packages
Install the necessary packages to allow apt to use repositories over HTTPS:

```sh
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
```

3. Add Docker’s Official GPG Key
Add Docker’s official GPG key to your system:

```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

4. Set Up the Docker Repository
Add the Docker repository to apt sources:

```sh
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

5. Update the Package Index Again
After adding the Docker repository, update the package index again:

```sh
sudo apt-get update
```

6. Install Docker CE (Community Edition)
Install Docker CE:

```sh
sudo apt-get install -y docker-ce
```

7. Verify the Docker Installation
Check if Docker is installed correctly by running the hello-world image:

```sh
sudo docker run hello-world
```

You should see a message indicating that Docker is installed and running correctly.

8. Manage Docker as a Non-Root User (Optional)
By default, Docker commands need to be run with sudo. To avoid using sudo with Docker commands, add your user to the docker group:

```sh
sudo usermod -aG docker $USER
```

After adding your user to the docker group, log out and log back in to apply the changes. Verify you can run Docker commands without sudo:

```sh
docker run hello-world
```

9. Enable Docker to Start on Boot
Enable Docker to start on boot:

```sh
sudo systemctl enable docker
```

10. Troubleshooting
If you encounter any issues, you can check the status of the Docker service:

```sh
sudo systemctl status docker
```
To restart the Docker service:

```sh
sudo systemctl restart docker
```

Conclusion
By following these steps, you can install Docker on an Ubuntu system. Docker provides a powerful platform for developing, shipping, and running applications inside containers, and installing it on Ubuntu is straightforward using the official Docker repositories.
# Jenkins in Docker

The scripts in this repo will initialize a simple Jenkins setup inside of docker on one computer.

## Installation

### The Master Jenkins Server

The `docker-server-startup.sh` script should set up the Jenkins master server for you. It will create a `jenkins-net` docker overlay network and forward ports 8080 and 50000.

Once up and running you can navigate to [localhost:8080](http://localhost:8080) to log into the control panel. You'll need the secret found in `~/jenkins/vol/jenkins-server/secrets/master.key`

Then create a new user and log in.

### Adding a worker agent

Log into the Jenkins Control Panel. Select "Manage Jenkins" > "Manage Nodes" > "New Node"

Make a new name for the worker and make it a Permanent Agent

Type `/home/jenkins/agent` for the "Remote Root Directory" and save

Click on the new worker and you should see a list of ways to connect. From this screen grab the secret. Then run the command:

```
./docker-worker-startup.sh [SECRET] [NAME OF YOUR NODE]
```

Give it a few seconds and your new node should appear in your [Jenkins panel](http://localhost:8080/computer/)


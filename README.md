

## Local Development Setup
### Pre-requisites
1. Install [python3](https://www.python.org/downloads/release/python-3910/)
2. Install virtualenv - `python3 -m pip install virtualenv`


### Setup virtual environment
1. Create virtual environment
```shell
python3 -m venv venv
```
2. Activate virtual environment
```shell
source venv/bin/activate
```
3. Install required libraries
```shell
pip3 install -r requirements.txt
```
### Run helloworld app locally
1. With virtual environment being activated, run the following command
```shell
python3 app.py
```
2. Go to http://127.0.0.1:3000 and verify you see `Hello Equal Experts`

### Run tests
To execute test for the project, from the project root directory, run the following command
```shell
pytest 
```

### Build and run docker image locally
1. To build the docker image, while under the root directory, run the following command
```shell
docker build -t helloworld .
```
2. Run the docker container with the following command
```shell
docker run -p 3000:3000 helloworld
```
3. Go to http://127.0.0.1:3000 and verify you see `Hello Equal Experts`

## Deploy to minikube
1. Ensure minikube is running
```shell
minikube status
```
2. Enable minikube addons registry
```shell
minikube addons enable registry
```
3. Create a local docker registry by running
```shell
docker run -d -p 5000:5000 --restart=always --name registry registry:2 
```
4. Use docker daemon inside minikube
```shell
eval $(minikube docker-env)  
```
5. Build and tag helloworld image
```shell
docker build -t localhost:5000/helloworld .
```
6. Push image to local repository
```shell
docker push localhost:5000/helloworld
```
7. Deploy helloworld kubernetes objects
```shell
kubectl apply -f deploy/helloworld.yaml
```
8. Start minikube tunnel in another shell to access the application
```shell
minikube tunnel
```
9. To access the application `curl http://127.0.0.1:3000`

## Test minikube deployment
1. Install [bats-core](https://bats-core.readthedocs.io/en/stable/installation.html)
2. Execute tests by running `bats tests`
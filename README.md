# BDC 2020
![Node.js CI](https://github.com/adam-watkins/bdc/workflows/Node.js%20CI/badge.svg?branch=master)


Use conda to install requirements.
```
conda env create -f env.yml
conda activate bdc
``` 

## Build and Run Backend
Make sure you are in your bdc conda env, or have installed the requirements with pip. First set some environment variables.
```bash
# linux
$ export FLASK_ENV=development

# windows
$ set FLASK_ENV=developemnt
```

Now run the backend server.
```bash
$ cd backend
$ flask run
```


## Build and Run Frontend
Make sure you have NodeJs 14.3.0 (12.16.3 should also work). If you installed the conda env then you have already installed nodejs.
```bash
$ cd frontend

# install dependencies
$ npm install

# serve with hot reload at localhost:3000
$ npm run dev
```

## Deployment
The frontend is automatically built and served after every push to master.  It can be found [here](bdc-theta.now.sh).

Currently the backend is being hosted on a google compute engine server.  To update the app make sure you have access to the server.
To update and start the backend.
```bash
$ cd /home/bdc
$ sudo git pull
$ sudo docker-compose up --build -d
```


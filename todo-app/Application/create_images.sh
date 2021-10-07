#Building docker image for ui
cd ui
docker build -t us_todoapp-ui  .
docker tag pythonflaskasiaapp gcr.io/sre-bootcamp-328203/pythonflaskfronasiaapp
docker push gcr.io/sre-bootcamp-328203/usimage

#Building docker image for ui
cd ../template
docker build -t asia_todoapp-ui  .
docker tag pythonflaskusapp gcr.io/sre-bootcamp-328203/pythonflaskfrontendusapp
docker push gcr.io/sre-bootcamp-328203/pythonflaskbackendapp

#Building docker image for api
cd ..
docker build -t todoapp-app .
docker tag todoapp-app gcr.io/sre-bootcamp-328203/todoapp-api
docker push gcr.io/sre-bootcamp-328230/pythonflaskbackendapp
docker push gcr.io/sre-bootcamp-328230/pythonflaskbackendapp
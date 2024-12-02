## Analysis of Wine Quality Based on Wine Magazine Reviews

This repository holds a copy of the data from the Wine Reviews Kaggle Dataset found [here](https://www.kaggle.com/datasets/zynicide/wine-reviews/data).

### Using this Repository

This repository is best used via Docker. To build the container, you'll need to create a file named `.password` which contains the password you'd like to use for the rstudio user in the docker container. Then, run the following:

```
docker build . --build-arg user_pass="$(cat .password)" -t wine-reviews
```

This will create a docker container. Then from a unix command line, you can start the server by running:

```
docker run  --rm -t -e PASSWORD="$(cat .password)" -p 8787:8787 wine-reviews
```

The server can be accessed at http://localhost:8787 via the browser on your machine. Use the username "rstudio" and the password you created in `.password` to log in. 
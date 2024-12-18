## Analysis of Wine Quality Based on Wine Magazine Reviews

This repository holds a copy of the data from the Wine Reviews Kaggle Dataset found [here](https://www.kaggle.com/datasets/zynicide/wine-reviews/data).

### Using this Repository

This repository is best used via Docker. To build the container, you'll need to create a file named `.password` which contains the password you'd like to use for the rstudio user in the docker container. Then, you can run the following:

```
docker build . --build-arg user_pass="$(cat .password)" -t wine-reviews
```

This will create a docker container. Then from a unix command line, you can start the server by running:

```
docker run -p 8787:8787 --rm \
           -e PASSWORD="$(cat .password)" \
           -v $HOME/.ssh \
           -v $HOME/.gitconfig \
           -v $(pwd):/home/rstudio \
           -it wine-reviews
```

The server can be accessed at http://localhost:8787 via the browser on your machine. Use the username "rstudio" and the password you created in `.password` to log in. 

To run the analysis and build the report, run:
```
make
```

or 

```
make report.pdf
```

in the terminal on the RStudio session that you opened in the browser. This should run all the analyses, build all figures, and assemble the final report. You can view report.pdf once the make has completed to see the results. 
# shiny karyoploteR

An R Shiny interfacte for <a href="http://bioconductor.org/packages/release/bioc/html/karyoploteR.html#:~:text=karyoploteR%20creates%20karyotype%20plots%20of,coordinates%20into%20the%20plot%20coordinates." target="_blank">karyoploteR</a> library.

A live demo can be found on: <a href="https://mcocam.shinyapps.io/karyo_1/" target="_blank">Shiny karyoploteR</a>

The app has been build with R 4.3.

# Set up and installation (local)

First, download the project and open it with code editor. Be sure that the root of the project is settled as working directory.

Then run 
```
renv::install()
```
  
And, finally, run shiny:
```
shiny::runApp()
```

## Running in linux system

Some problems have been detected when trying to set up the app in Linux system. Please, be sure that the following dependencies are in your system. You can install them all at once with the following command:

```
sudo apt install \
 libcairo2-dev \
 libxt-dev \
 libbz2-dev \
 libcurl4-gnutls-dev \
 gfortran \
 libblas-dev \ 
 liblapack-dev \
 libgsl0-dev \
 libxml2-dev \
```

# Deployment

Like any other shiny application, the code can be deployed automatically to shinyapps site.
Also, docker can be used. As you can see, there is a docker-compose file in the project.
The execution of docker file, deploy the application and makes available through port 80.

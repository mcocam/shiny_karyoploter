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
sudo apt-get install -y libcairo2-dev libxt-dev libbz2-dev libcurl4-gnutls-dev gfortran libblas-dev liblapack-dev libgsl-dev libxml2-dev libssl-dev
```

# Deployment

Like any other shiny application, the code can be deployed automatically to shinyapps site.
However, other alternatives have been tested.

The first and most simple alternative is to dockerize the application. Please note that, regardless of your deployment strategy, dockerizing the application is likely the first step to achieving a robust architecture.

Here is the Dockerfile code that deploys the application via port 80. You need to place Docerfile outside shiny_karyoploter
folder. If you change folder name or if you want to change the exposed port, feel free to change the configuration accordingly.

**Dockerfile**
```
# Get last R version available
FROM r-base:latest

# Update the linux docker
RUN apt-get update
RUN apt-get install -y libcairo2-dev libxt-dev libbz2-dev libcurl4-gnutls-dev gfortran libblas-dev liblapack-dev libgsl-dev libxml2-dev libssl-dev

# Make sure renv is installed
RUN R -e 'install.packages("renv")'

# Move karyoploteR project to docker
COPY shiny_karyoploter /app

# Set working directory to the app
WORKDIR /app

# Install packages with renv
RUN R -e 'renv::install()'

# Port 80 expose (change it if needed)
EXPOSE 80

# Run the application
CMD ["R", "-e", "shiny::runApp(host='0.0.0.0', port=80)"]
```

**.dockerignore**
```
# History files
.Rhistory
.Rapp.history

# Session Data files
.RData
.RDataTmp

# User-specific files
.Ruserdata

# Example code in package build process
*-Ex.R

# Output files from R CMD build
/*.tar.gz

# Output files from R CMD check
/*.Rcheck/

# RStudio files
.Rproj.user/

# produced vignettes
vignettes/*.html
vignettes/*.pdf

# OAuth2 token, see https://github.com/hadley/httr/releases/tag/v0.3
.httr-oauth

# knitr and R markdown default cache directories
*_cache/
/cache/

# Temporary files created by R markdown
*.utf8.md
*.knit.md

# R Environment Variables
.Renviron

# pkgdown site
docs/

# translation temp files
po/*~

# RStudio Connect folder
rsconnect/

# Ignore renv folder
renv/
```

Once the files have been placed, you can build the image and run the container. For example:

Set terminal to the main folder of Dockerfile and run:
```
docker build . -t karyoploter
```
Notice the command builds an image of the project with tag name 'karyoploter'.

Once the image is done (first time takes a while), run it as a container (it takes ~1 minute to fully set up)
```
docker run -d -p 80:80 karyoploter
```

Now, you can acces the app via: http://[your_ip]

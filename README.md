# shiny karyoploteR

An R Shiny interfacte for <a href="http://bioconductor.org/packages/release/bioc/html/karyoploteR.html#:~:text=karyoploteR%20creates%20karyotype%20plots%20of,coordinates%20into%20the%20plot%20coordinates." target="_blank">karyoploteR</a> library.

A live demo can be found on: <a href="https://mcocam.shinyapps.io/karyo_1/" target="_blank">Shiny karyoploteR</a>

# Set up and installation (local)

First, download the project and set working directory on it.

Then run 
```
renv::install()
```
  
And, finally, run shiny:
```
shiny::runApp()
```

## Running in linux system

In linux systems (Ubuntu), the installation of Cairo package could be problematic. Two dependencies are missed: cairo.h and Intrinsic.h

In order to fix cairo.h the following packages should be installed:

```
sudo apt install libcairo2-dev
```

For Intrinsic.h:

```
sudo apt-get install libxt-dev
```

# Deployment

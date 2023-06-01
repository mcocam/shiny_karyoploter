# shiny karyoploteR

An R Shiny interfacte for <a href="http://bioconductor.org/packages/release/bioc/html/karyoploteR.html#:~:text=karyoploteR%20creates%20karyotype%20plots%20of,coordinates%20into%20the%20plot%20coordinates." target="_blank">karyoploteR</a> library.

A live demo can be found on: <a href="https://mcocam.shinyapps.io/karyo_1/" target="_blank">Shiny karyoploteR</a>

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

Some problems have been detected when trying to set up the app in Linux system. The following ependencies are missed: cairo.h, Intrinsic.h, bzlib.h, curl.h, gfortran.

In order to fix cairo.h the following packages should be installed:

```
sudo apt install libcairo2-dev
```

For Intrinsic.h:

```
sudo apt-get install libxt-dev
```

For bzlib.h:

```
sudo apt install libbz2-dev
```

For curl.h:

```
sudo apt install libcurl4-gnutls-dev
```

For gfortran:

```
sudo apt-get install gfortran
```

# Deployment

# This file allows packrat (used by rsconnect during deployment) to pick up dependencies.

library(bslib)          # Bootstrap 5 set up
library(Cairo)          # Export plot as image
library(dplyr)          # Manipulate data
library(karyoploteR)    # Generate karyotype plots
library(rhino)          # Rhino Shiny Framework
library(grDevices)      # Capturing plots
library(shinyAce)       # For code rendering
library(shiny)          # Shiny framework
library(data.table)     # Handle file reading
library(GenomicRanges)  # Handle GRanges objects
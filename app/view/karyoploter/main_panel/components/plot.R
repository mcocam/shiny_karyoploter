box::use(
  shiny[
    moduleServer,
    NS,
    renderPlot,
    plotOutput],

    karyoploteR[
      plotKaryotype, 
      kpPlotMarkers,
      kpBars,
      autotrack,
      kpAxis,
      kpDataBackground,
      kpPoints,
      kpLines,
      kpPlotDensity,
      kpPlotHorizon,
      kpPlotCoverage,
      kpPlotManhattan
      ],

    GenomicRanges[makeGRangesFromDataFrame],

      app/logic/normalize_data[normalize_y],
      app/logic/get_min_max_y[get_min_max_y]

)

#' @export
ui = function(id){
    ns = NS(id)

    plotOutput(ns("plot"))

}

#' @export
server = function(id,karyo_params, marker_data, plot_data){
  moduleServer(id,function(i,o,s){

    # Main panel plot
    o$plot = renderPlot({
      tryCatch({

          params = karyo_params()
          marker_data = marker_data()
          plot_data = plot_data()

          # Initalize the idiogram
          plot = do.call(plotKaryotype,karyo_params())

          # Initialize track 
          track = data.frame(
            r0 = NULL,
            r1 = NULL
          )
          # If some plot data has been added
          if(!is.null(plot_data)){

            kpDataBackground(plot, col = "#F1F6F9")

            total_tracks = length(plot_data)
            current_track = 1

            for(index in total_tracks:1){

              panel = plot_data[[index]]

              type  = panel$type
              data  = as.data.frame(panel$data)
              chrs  = unique(data$chr)

              margin = 0 
              if (total_tracks > 0){
                margin = 0.2
              }

              track = autotrack(
                current.track = current_track,
                total.tracks = total_tracks,
                margin = margin)

              global_min_max = get_min_max_y(data)
              y_min = global_min_max[1]
              y_max = global_min_max[2]

              # High-level plot functions
              if(type %in% c("plot_density", "plot_horizon", "plot_coverage", "plot_manhattan") ){

                switch(
                  type,
                  "plot_coverage" = {
                    kpPlotCoverage(
                      plot,
                      data = makeGRangesFromDataFrame(data),
                      r0 = track$r0,
                      r1 = track$r1
                    )
                  },
                  "plot_density" = {
                    kpPlotDensity(
                      plot,
                      data = makeGRangesFromDataFrame(data),
                      r0 = track$r0,
                      r1 = track$r1
                    )
                  },
                  "plot_horizon" = {

                    kpPlotHorizon(
                      plot,
                      data = makeGRangesFromDataFrame(data, keep.extra.columns = TRUE),
                      r0 = track$r0,
                      r1 = track$r1
                    )
                  },
                  "plot_manhattan" = {
                    kpPlotManhattan(
                      plot,
                      data = makeGRangesFromDataFrame(data, keep.extra.columns = TRUE),
                      r0 = track$r0,
                      r1 = track$r1
                    )
                  }
                )

              # Low-level plot functions
              }else{

                kpAxis(
                plot, 
                r0 = track$r0, 
                r1 = track$r1,
                ymin = y_min,
                ymax = y_max)

                for(chr in chrs){

                filtered_data = data[data$chr == chr,]

                switch(
                  type,
                  "plot_bar" = {
                    kpBars(
                      plot,
                      chr = chr, 
                      x0 = filtered_data$x0,
                      x1 = filtered_data$x1,
                      y1 = filtered_data$y1,
                      r0 = track$r0,
                      r1 = track$r1,
                      ymax = y_max)
                  },
                  "plot_points" = {
                    kpPoints(
                      plot,
                      chr = chr,
                      x = filtered_data$x,
                      y = filtered_data$y,
                      r0 = track$r0,
                      r1 = track$r1,
                      ymax = y_max,
                      ymin = y_min
                    )
                  },
                  "plot_lines" = {
                    kpLines(
                      plot,
                      chr = chr,
                      x = filtered_data$x,
                      y = filtered_data$y,
                      r0 = track$r0,
                      r1 = track$r1,
                      ymax = y_max,
                      ymin = y_min
                    )

                  }
                )

              }

              }

              current_track = current_track + 1 

            }
          }else{

          }

          # If some marker has been added
          if(!is.null(marker_data)){

            if(length(track) > 0){
              
              track$r0 = track$r0 * 1.7
              track$r1 = track$r1 * 1.7
            }

            if(params[["plot.type"]] %in% c("3", "4", "5")){
              kpPlotMarkers(
                plot,
                chr=marker_data$chr,
                x=marker_data$x,
                labels=marker_data$labels,
                label.margin = 5,
                r1 = track$r1)

            }else{
              kpPlotMarkers(
                plot,
                chr=marker_data$chr,
                x=marker_data$x,
                labels=marker_data$labels,
                text.orientation = "horizontal",
                r1 = track$r1)
            }
            
          }

          

          # Return plot
          plot
        },
        error = function(e) print(e),
        warning = function(c) "warning")
      })
  })
}





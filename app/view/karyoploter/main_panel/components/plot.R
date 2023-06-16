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
          track_up = data.frame(
            r0 = NULL,
            r1 = NULL
          )
          track_down = data.frame(
            r0 = NULL,
            r1 = NULL
          )
          # If some plot data has been added
          if(!is.null(plot_data)){

            total_tracks_up = 0
            total_tracks_down = 0

            for(index in seq_along(plot_data)){
              track = plot_data[[index]]

              if(track$placement == 1){
                total_tracks_up = total_tracks_up + 1
              }else{
                total_tracks_down = total_tracks_down + 1
              }
            }

            total_tracks = total_tracks_up + total_tracks_down

            current_track_up = 1
            current_track_down = 1

            if(total_tracks_down > 0 & total_tracks_up > 0){
              kpDataBackground(plot, col = "#F1F6F9", data.panel = 1)
              kpDataBackground(plot, col = "#F1F6F9", data.panel = 2)
            }else{
              if(total_tracks_down>0){
              kpDataBackground(plot, col = "#F1F6F9", data.panel = 2)
              }else if (total_tracks_up > 0) {
                kpDataBackground(plot, col = "#F1F6F9", data.panel = 1)
              }
            }

            

            for(index in total_tracks:1){

              panel = plot_data[[index]]

              type  = panel$type
              data  = as.data.frame(panel$data)
              chrs  = unique(data$chr)
              placement = panel$placement

              margin = 0 
              if(placement == 1){

                if (total_tracks_up > 0){
                  margin = 0.2
                }

                track = autotrack(
                  current.track = current_track_up,
                  total.tracks = total_tracks_up,
                  margin = margin)

                current_track_up = current_track_up + 1 
              }else{

                if (total_tracks_down > 0){
                  margin = 0.2
                }

                track = autotrack(
                  current.track = current_track_down,
                  total.tracks = total_tracks_down,
                  margin = margin)

                current_track_down = current_track_down + 1 

              }

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
                      data.panel = placement,
                      r0 = track$r0,
                      r1 = track$r1
                    )
                  },
                  "plot_density" = {
                    kpPlotDensity(
                      plot,
                      data = makeGRangesFromDataFrame(data),
                      data.panel = placement,
                      r0 = track$r0,
                      r1 = track$r1
                    )
                  },
                  "plot_horizon" = {

                    kpPlotHorizon(
                      plot,
                      data = makeGRangesFromDataFrame(data, keep.extra.columns = TRUE),
                      data.panel = placement,
                      r0 = track$r0,
                      r1 = track$r1
                    )
                  },
                  "plot_manhattan" = {
                    kpPlotManhattan(
                      plot,
                      data = makeGRangesFromDataFrame(data, keep.extra.columns = TRUE),
                      data.panel = placement,
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
                data.panel = placement,
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
                      data.panel = placement,
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
                      data.panel = placement,
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
                      data.panel = placement,
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

            }
          }else{

          }

          # If some marker has been added
          if(!is.null(marker_data)){

            data_panel_position = unique(marker_data$position)

            track = data.frame(
              r0 = 0,
              r1 = 0
            )

            if(data_panel_position == 1){
              track$r0 = track_up$r0
              track$r1 = track_up$r1
            }else if (data_panel_position == 2) {
               track$r0 = track_down$r0
               track$r1 = track_down$r1
            }

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
                data.panel = data_panel_position,
                r1 = track$r1)

            }else{
              kpPlotMarkers(
                plot,
                chr=marker_data$chr,
                x=marker_data$x,
                labels=marker_data$labels,
                text.orientation = "horizontal",
                data.panel = data_panel_position,
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





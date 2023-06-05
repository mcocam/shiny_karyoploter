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
      kpDataBackground
      ],

      app/logic/normalize_data[normalize_y]

)

#' @export
ui = function(id){
    ns = NS(id)

    plotOutput(ns("plot"))

}

#' @export
server = function(id,karyo_params, marker_data, plot_data){
  moduleServer(id,function(i,o,s){

    o$plot = renderPlot({
      tryCatch({

          params = karyo_params()
          marker_data = marker_data()
          plot_data = plot_data()

          # Initalize the idiogram
          plot = do.call(plotKaryotype,karyo_params())

          # If some marker has been added
          if(!is.null(marker_data)){
            if(params[["plot.type"]] %in% c("3", "4", "5")){
              kpPlotMarkers(plot, chr=marker_data$chr, x=marker_data$x, labels=marker_data$labels, label.margin = 5)

            }else{
              kpPlotMarkers(plot, chr=marker_data$chr, x=marker_data$x, labels=marker_data$labels, text.orientation = "horizontal" )
            }
            
          }

          # If some plot data has been added
          if(!is.null(plot_data)){

            kpDataBackground(plot, col = "#F1F6F9")

            total_tracks = length(plot_data)
            current_track = 1

            for(index in total_tracks:1){

              panel = plot_data[[index]]

              type  = panel$type
              data  = as.data.frame(panel$data)
              chrs   = unique(data$chr)

              margin = 0 
              if (total_tracks > 0){
                margin = 0.2
              }

              track = autotrack(
                current.track = current_track,
                total.tracks = total_tracks,
                margin = margin)

              kpAxis(
                plot, 
                r0 = track$r0, 
                r1 = track$r1,
                ymin = min(data$y),
                ymax = max(data$y))

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
                      y1 = normalize_y(filtered_data$y),
                      r0 = track$r0,
                      r1 = track$r1)
                  }
                )

              }

              current_track = current_track + 1 

            }
          }else{
          }

          

          # Return plot
          plot
        },
        error = function(c) print(c),
        warning = function(c) "warning",
        message = function(c) "message")
      })
  })
}





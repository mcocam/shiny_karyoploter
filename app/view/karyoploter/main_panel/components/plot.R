box::use(
  shiny[
    moduleServer,
    NS,
    renderPlot,
    plotOutput],

    karyoploteR[plotKaryotype, kpPlotMarkers],

)

#' @export
ui = function(id){
    ns = NS(id)

    plotOutput(ns("plot"))

}

#' @export
server = function(id,karyo_params, marker_data){
  moduleServer(id,function(i,o,s){

    o$plot = renderPlot({
      tryCatch({

          params = karyo_params()
          marker_data = marker_data()
          plot = do.call(plotKaryotype,karyo_params())

          if(!is.null(marker_data)){
            if(params[["plot.type"]] %in% c("3", "4", "5")){
              kpPlotMarkers(plot, chr=marker_data$chr, x=marker_data$x, labels=marker_data$labels, label.margin = 5)

            }else{
              kpPlotMarkers(plot, chr=marker_data$chr, x=marker_data$x, labels=marker_data$labels, text.orientation = "horizontal" )
            }
            
          }

          plot
        },
        error = function(c) print(c),
        warning = function(c) "warning",
        message = function(c) "message")
      })
  })
}





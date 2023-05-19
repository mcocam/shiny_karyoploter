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
          marker_data = marker_data()
          plot = do.call(plotKaryotype,karyo_params())

          if(!is.null(marker_data)){
            kpPlotMarkers(plot, chr=marker_data$chr, x=marker_data$pos, labels=marker_data$labels)
          }

          plot
        },
        error = function(c) print(c),
        warning = function(c) "warning",
        message = function(c) "message")
      })
  })
}





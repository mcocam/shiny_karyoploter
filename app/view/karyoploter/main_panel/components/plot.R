box::use(
  shiny[
    moduleServer,
    NS,
    renderPlot,
    plotOutput],

    karyoploteR[plotKaryotype, kpAddChromosomeNames],

)

#' @export
ui = function(id){
    ns = NS(id)

    plotOutput(ns("plot"))

}

#' @export
server = function(id,karyo_params){
  moduleServer(id,function(i,o,s){

    o$plot = renderPlot({
      tryCatch({
          plot = do.call(plotKaryotype,karyo_params())

          plot
        },
        error = function(c) print(c),
        warning = function(c) "warning",
        message = function(c) "message")
      })
  })
}





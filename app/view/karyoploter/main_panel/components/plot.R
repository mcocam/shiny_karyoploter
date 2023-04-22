box::use(
  shiny[
    moduleServer,
    NS,
    renderPlot,
    plotOutput],

    karyoploteR[plotKaryotype],

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
        plot = do.call(plotKaryotype,karyo_params())
        plot
        })



  })
}





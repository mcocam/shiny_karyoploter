box::use(
  shiny[
    moduleServer,
    NS,
    renderPlot,
    plotOutput],

    bslib[card],
    karyoploteR[plotKaryotype],

)

#' @export
ui = function(id){
    ns = NS(id)

    card(class="mt-3 mt-sm-0", plotOutput(ns("plot"),height = "80vh"))

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





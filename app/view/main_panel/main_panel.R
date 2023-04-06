box::use(
  shiny[
    moduleServer,
    NS,
    mainPanel],

    app/view/main_panel/components/plot
)

#' @export
ui = function(id){
  ns = NS(id)

    mainPanel(
        plot$ui(ns("plot"))
    )
}

#' @export
server = function(id,karyo_params){
  moduleServer(id,function(i,o,s){

    plot$server("plot",karyo_params)

  })
}
box::use(
  shiny[
    moduleServer,
    NS,
    sidebarPanel],

    app/view/sidebar/components/export,
    app/view/sidebar/components/genomes
)

#' @export
ui = function(id){
  ns = NS(id)

sidebarPanel(
    genomes$ui(ns("genomes")),
    export$ui(ns("btn"))
    )
}

#' @export
server = function(id,karyo_params){
  moduleServer(id,function(i,o,s){

    genomes$server("genomes")
    export$server("btn",karyo_params)


  })
}

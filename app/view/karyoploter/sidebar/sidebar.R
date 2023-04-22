box::use(
  shiny[
    moduleServer,
    NS,
    sidebarPanel,
    div,
    hr],

    app/view/karyoploter/sidebar/components/export,
    app/view/karyoploter/sidebar/components/genomes,
    app/view/karyoploter/sidebar/components/panels
)

#' @export
ui = function(id){
  ns = NS(id)

    sidebarPanel(
      genomes$ui(ns("genomes")),
      hr(),
      div(class="my-3 fw-bold text-dark","Add custom panels"),
      panels$ui(ns("regions")),
      hr(),
      export$ui(ns("btn"))
    )
}

#' @export
server = function(id,karyo_params){
  moduleServer(id,function(i,o,s){

    genomes$server("genomes")
    export$server("btn",karyo_params)
    panels$server("regions")


  })
}

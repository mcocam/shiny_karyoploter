box::use(
  shiny[
    moduleServer,
    NS,
    sidebarPanel,
    div,
    hr],

    app/view/karyoploter/sidebar/components/buttons,
    app/view/karyoploter/sidebar/components/genomes,
    app/view/karyoploter/sidebar/components/plot_type,
    app/view/karyoploter/sidebar/components/panels
)

#' @export
ui = function(id){
  ns = NS(id)

    sidebarPanel(
      div(class="my-3 fw-bold text-dark text-center","Ideogram options"),
      genomes$ui(ns("genomes")),
      plot_type$ui(ns("plot_type")),

      hr(),

      div(class="my-3 fw-bold text-dark text-center","Add panels"),
      panels$ui(ns("regions")),

      hr(),

      buttons$ui(ns("btn"))
    )
}

#' @export
server = function(id,karyo_params){
  moduleServer(id,function(i,o,s){

    genomes$server("genomes")
    plot_type$server("plot_type")
    buttons$server("btn",karyo_params)
    panels$server("regions")


  })
}

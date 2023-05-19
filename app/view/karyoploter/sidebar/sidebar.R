box::use(
  shiny[
    moduleServer,
    NS,
    sidebarPanel,
    div,
    hr,
    reactive,
    tabsetPanel,
    tabPanel],

    app/view/karyoploter/sidebar/components/genomes/genomes,
    app/view/karyoploter/sidebar/components/genomes/plot_type,
    app/view/karyoploter/sidebar/components/genomes/chromosomes,

    app/view/karyoploter/sidebar/components/panels/panels,

    app/view/karyoploter/sidebar/components/footer_buttons/buttons,

    app/view/karyoploter/sidebar/components/panels/markers
)

#' @export
ui = function(id){
  ns = NS(id)

    sidebarPanel(
      div(class="my-3 fw-bold text-dark text-center","Ideogram options"),
      genomes$ui(ns("genomes")),
      plot_type$ui(ns("plot_type")),
      chromosomes$ui(ns("chromosomes")),

      hr(),

      tabsetPanel(id = ns("user_data"),
      
        tabPanel(
          "Markers",
            div(class="my-3 fw-bold text-dark text-center","Markers (optional)"),
            markers$ui(ns("markers"))
        ),
        tabPanel(
          "Plots",
          div(class="my-3 fw-bold text-dark text-center","Add plot"),
          panels$ui(ns("panels"))
        )
      ),

      hr(),

      buttons$ui(ns("btn"))
    )
}

#' @export
server = function(id,karyo_params,selected_genome){
  moduleServer(id,function(i,o,s){

    genomes$server("genomes")
    plot_type$server("plot_type")
    chromosomes$server("chromosomes",selected_genome)
    panels$server("panels")
    buttons$server("btn",karyo_params)
    markers$server("markers")

  })
}

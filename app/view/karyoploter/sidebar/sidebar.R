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
    app/view/karyoploter/sidebar/components/genomes/chr_labels,

    app/view/karyoploter/sidebar/components/panels/panels,

    app/view/karyoploter/sidebar/components/footer_buttons/buttons,

    app/view/karyoploter/sidebar/components/panels/markers
)

#' @export
ui = function(id){

  ns = NS(id)

  #Sidebar component UI

    sidebarPanel(
      class = "mb-3",
      div(class="my-3 fw-bold text-dark text-center","Ideogram options"),
      genomes$ui(ns("genomes")),
      plot_type$ui(ns("plot_type")),
      chromosomes$ui(ns("chromosomes")),
      chr_labels$ui(ns("chr_labels")),

      hr(),

      tabsetPanel(id = ns("user_data"),
      
        tabPanel(
          "Add markers",
            div(class="my-3 fw-bold text-dark text-center","Markers (optional)"),
            markers$ui(ns("markers"))
        ),
        tabPanel(
          "Add plots",
          div(class="my-3 fw-bold text-dark text-center", "Add plot"),
          panels$ui(ns("panels"))
        )
      ),

      hr(),

      buttons$ui(ns("btn"))
    )
}

#' @export
server = function(id, karyo_params, selected_genome, marker_data, plot_data){
  moduleServer(id, function(i, o, s) {

    # Sidebar server logic

    # Selected genome
    genomes$server("genomes")

    # Karyoplot type
    plot_type$server("plot_type")

    # Selected chromosomes
    chromosomes$server("chromosomes", selected_genome)

    # Select if display chromosome labels or not
    chr_labels$server("chr_labels")

    # Dynamic panels
    panels$server("panels", plot_data)

    # Footer buttons
    buttons$server("btn", karyo_params, marker_data, plot_data)

    # Handle marker input
    markers$server("markers", marker_data)

  })
}

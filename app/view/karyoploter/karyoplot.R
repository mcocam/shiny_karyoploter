box::use(
    shiny[
        moduleServer,
        NS,
        sidebarLayout,
        reactive
        ],

    app/view/karyoploter/sidebar/sidebar,
    app/view/karyoploter/main_panel/main_panel
)

#' @export
ui = function(id){
    ns = NS(id)

    sidebarLayout(
        sidebar = sidebar$ui(ns("sidebar")),
        mainPanel = main_panel$ui(ns("mainPanel"))
    )

}

#' @export
server = function(id,karyo_params){
    moduleServer(id,function(i,o,s){



    karyo_params = reactive({
      params = list(
        genome = i[["sidebar-genomes-genome"]]
      ) # Input params
    })

    input_data = reactive({}) # Input user data

        sidebar$server("sidebar",karyo_params)
        main_panel$server("mainPanel",karyo_params)

    })
}

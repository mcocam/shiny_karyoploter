box::use(
    shiny[
        moduleServer,
        NS,
        sidebarLayout
        ],

    app/view/sidebar/sidebar,
    app/view/main_panel/main_panel
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

        sidebar$server("sidebar",karyo_params)
        main_panel$server("mainPanel",karyo_params)

    })
}

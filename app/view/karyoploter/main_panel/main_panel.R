box::use(
  shiny[
    moduleServer,
    NS,
    mainPanel,
    div],

    bslib[card,navset_card_tab,nav_panel,card_body],

    app/view/karyoploter/main_panel/components/plot,
    app/view/karyoploter/main_panel/components/code
)

#' @export
ui = function(id){
  ns = NS(id)

    # Main plot area
    mainPanel(
      div(
    class="sticky-top my-3 my-sm-0",
        navset_card_tab(
                  height = "95vh",
                  title = "Result",
                  full_screen = TRUE,
                  wrapper = card_body,
                  nav_panel(
                    "Plot",
                    plot$ui(ns("plot"))
                  ),
                  nav_panel(
                    "Code",
                    code$ui(ns("code"))
                  )
    )
  )
        
    )
}

#' @export
server = function(id,karyo_params, marker_data, plot_data){
  moduleServer(id,function(i,o,s){

    # Plot server logic

    ## Render plot
    plot$server("plot",karyo_params, marker_data, plot_data)

    ## Do the code
    code$server("code",karyo_params, marker_data, plot_data)

  })
}
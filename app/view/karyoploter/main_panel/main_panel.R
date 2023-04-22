box::use(
  shiny[
    moduleServer,
    NS,
    mainPanel,
    div],

    bslib[card,navs_tab_card,nav,card_body_fill],

    app/view/karyoploter/main_panel/components/plot
)

#' @export
ui = function(id){
  ns = NS(id)

    mainPanel(
      div(
    class="sticky-top my-3 my-sm-0",
        navs_tab_card(
                  height = "88vh",
                  title = "Result",
                  full_screen = TRUE,
                  wrapper = card_body_fill,
                  nav(
                    "Plot",
                    plot$ui(ns("plot"))
                  ),
                  nav(
                    "Code",
                    "Here: textOutput with the code"
                  )
    )
  )
        
    )
}

#' @export
server = function(id,karyo_params){
  moduleServer(id,function(i,o,s){

    plot$server("plot",karyo_params)

  })
}
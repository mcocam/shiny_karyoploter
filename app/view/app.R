box::use(
    shiny[
        moduleServer,
        NS,
        renderPlot,
        plotOutput,
        mainPanel,
        sidebarLayout,
        sidebarPanel,
        div
        ],
    bslib[card],
    karyoploteR[plotKaryotype],
    app/view/export
)

#' @export
ui = function(id){
    ns = NS(id)

    sidebarLayout(
        sidebarPanel(
            export$ui(ns("btn"))
            ),
        mainPanel(card(class="mt-3 mt-sm-0", plotOutput(ns("plot"),height = "80vh")))
    )

}

#' @export
server = function(id,karyo_params){
    moduleServer(id,function(i,o,s){

        options(shiny.usecairo=TRUE)

        o$plot = renderPlot({
          plot = do.call(plotKaryotype,karyo_params())
          plot
        })

        export$server("btn",karyo_params)

    })
}

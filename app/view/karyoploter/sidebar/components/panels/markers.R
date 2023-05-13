box::use(
  shiny[
    moduleServer,
    NS,
    sidebarPanel,
    actionButton,
    div,
    p,
    icon,
    observe,
    tags,
    fileInput],
)

#' @export
ui = function(id){
  ns = NS(id)

      marker_demo_table = tags$table(
        tags$thead(
            class = "text-center fw-bold text-lowercase",
            tags$tr(
                tags$th(style = "text-transform: none;font-weight: bold","chr"),
                tags$th(style = "text-transform: none;font-weight: bold","pos"),
                tags$th(style = "text-transform: none;font-weight: bold","label")
            )
        ),
        tags$tbody(
          class = "text-center",
          tags$tr(
            tags$td("chr1"),
            tags$td("1000"),
            tags$td("Gene 1")
          ),
          tags$tr(
            tags$td("chr2"),
            tags$td("5325"),
            tags$td("Gene 2")
          ),
          tags$tr(
            tags$td("chr8"),
            tags$td("82563"),
            tags$td("Gene 3")
          )
        ),
        class = "table"
    )

    div(
        id = id,
        class = "card my-3",
        div(
            class = "card-body",
            div(
                p("Upload a text file to add markers. Please, be sure that your data is CSV separated with ';' and follows this sctructure:"),
                div(
                  class="my-2",
                  marker_demo_table
                ),
                div(
                  fileInput(ns("marker_file"), "Markers file",
                    multiple = FALSE,
                    accept = c("text/csv",
                         "text/comma-separated-values,text/plain",
                         ".csv"))
                )
            )
        )
    )

}

#' @export
server = function(id){
  moduleServer(id,function(i,o,s){

    ns = s$ns

  })
}

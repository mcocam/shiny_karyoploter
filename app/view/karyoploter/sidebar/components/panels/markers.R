box::use(
  shiny[
    moduleServer,
    NS,
    sidebarPanel,
    actionButton,
    div,
    p,
    icon,
    tags,
    fileInput,
    observeEvent,
    req,
    insertUI,
    removeUI,
    HTML],
  tools[file_ext],
  data.table[fread]
)

marker_text = HTML("Upload a text file to add <a href = 'https://bernatgel.github.io/karyoploter_tutorial//Tutorial/PlotMarkers/PlotMarkers.html' target = '_blank'>markers</a>. Please, be sure that your data is CSV separated with ';' and follows this sctructure:")


#' @export
ui = function(id){
  ns = NS(id)

      marker_demo_table = tags$table(
        tags$thead(
            class = "text-center fw-bold text-lowercase",
            tags$tr(
                tags$th(style = "text-transform: none;font-weight: bold","chr"),
                tags$th(style = "text-transform: none;font-weight: bold","x"),
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
                p(marker_text),
                div(
                  class="my-2",
                  marker_demo_table
                ),
                div(
                  fileInput(ns("marker_file"), "",
                    multiple = FALSE,
                    accept = c("text/csv",
                         "text/comma-separated-values,text/plain",
                         ".csv"))
                ),
                div(id = "marker_feedback")
            )
        )
    )

}

#' @export
server = function(id, marker_data, is_multi_panel){
  moduleServer(id,function(i,o,s){

    ns = s$ns

    observeEvent(i$marker_file,{
      req(i$marker_file)
      removeUI("#marker_feedback > p", multiple = TRUE)

      tryCatch(
        {
          file_path = i$marker_file$datapath
          
          if(file_ext(file_path) != "csv"){
            unlink(file_path)
            stop("Invalid file")
          }

          data = fread(file_path, sep=";")

          if(ncol(data) == 3 & all(c("chr", "x", "labels") %in% colnames(data)) ) {
            marker_data(data)
          }else{
            stop("Invalid file")
          }

        },
        error = function(e){
          NULL
          insertUI(
            selector = "#marker_feedback", 
            ui = p("Invalid file, please check the expected format",
                  class="text-danger"))
        }
        )
    })

  })
}

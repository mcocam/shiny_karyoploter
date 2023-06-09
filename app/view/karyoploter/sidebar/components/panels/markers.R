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
    HTML,
    conditionalPanel,
    radioButtons,
    checkboxInput],

  tools[file_ext],

  data.table[fread],

  glue[glue]
)

marker_text = HTML("Upload a text file to add <a href = 'https://bernatgel.github.io/karyoploter_tutorial//Tutorial/PlotMarkers/PlotMarkers.html' target = '_blank'>markers</a>. Please, be sure that your data is CSV separated with ';' and follows this sctructure:")


#' @export
ui = function(id){
  ns = NS(id)

  is_multi_id = paste0(id, "_multi")
  label.dist_id = paste0(id,"_label.dist")

      # Marker HTML demo table
      marker_demo_table = tags$table(
        tags$thead(
            class = "text-center fw-bold text-lowercase",
            tags$tr(
                tags$th(style = "text-transform: none;font-weight: bold","chr"),
                tags$th(style = "text-transform: none;font-weight: bold","x"),
                tags$th(style = "text-transform: none;font-weight: bold","labels")
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

    # marker input
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
                div(
                conditionalPanel(
                    condition = glue("input[['{is_multi_id}']]"),
                    div(
                      class = "mx-2",
                      radioButtons(
                        ns("marker_panel"),
                        label = HTML("<p class='fw-bold'>Where the markers should be placed?</p>"),
                        choices = c("Upper section" = 1, "Lower section" = 2)
                      )
                    )
                )
              ),
              div(
                class = "d-none",
                checkboxInput(is_multi_id,
                                label = "",
                                value = FALSE)
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

    # Handle new marker file event
    observeEvent(i$marker_file,{
      req(i$marker_file)
      removeUI("#marker_feedback > p", multiple = TRUE)

      # Evaluate if correct
      tryCatch(
        {
          file_path = i$marker_file$datapath
          
          if(file_ext(file_path) != "csv"){
            unlink(file_path)
            stop("Invalid file")
          }

          data = fread(file_path, sep=";")

          if(ncol(data) == 3 & all(c("chr", "x", "labels") %in% colnames(data)) ) {
            data$position = i[["marker_panel"]]
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

    observeEvent(i[["marker_panel"]],{
      data = marker_data()
      if(!is.null(data)){
        data$position = i[["marker_panel"]]
        marker_data(data)
      }
    })

  })
}

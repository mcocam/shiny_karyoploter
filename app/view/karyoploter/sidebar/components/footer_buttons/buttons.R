box::use(
  shiny[
    moduleServer,
    NS,
    downloadButton,
    downloadHandler,
    actionButton,
    radioButtons,
    tagList,
    isolate,
    div,
    span,
    reactiveValuesToList,
    icon],

  Cairo[CairoSVG],
  grDevices[dev.off],
  karyoploteR[plotKaryotype]
)

#' @export
ui = function(id){
  ns = NS(id)
  tagList(
    div(class="mt-3"),
    div(
      class="row",
      div(class="col",
      div(class="d-flex justify-content-around",
        actionButton(ns("update"),label="Add panel data to plot",icon=icon("arrows-rotate"), disabled = TRUE, onclick="App.disablePanelButton()"),
        downloadButton(ns("img"),label="Export as SVG")),
      )
    )
  )


}

#' @export
server = function(id,karyo_params){
  moduleServer(id,function(i,o,s){

    options(shiny.usecairo=TRUE)

    o$img = downloadHandler(
      filename = function(){paste0("karyoplot.svg")},
      content = function(file){

        CairoSVG(file,  width = 15, height = 10)
        do.call(plotKaryotype,karyo_params())
        dev.off()
      }
    )

  })
}

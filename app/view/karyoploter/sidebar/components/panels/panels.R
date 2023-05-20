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
    observeEvent,
    renderUI,
    reactiveValues,
    tagList,
    insertUI,
    removeUI,
    HTML],
  app/logic/add_panel[add_panel]
)

data_text = HTML("
<p>This section allows you to dynamically include graphics (+). Each new panel includes a new track above or below the karyotype. Spacing is managed using the <a href='https://bernatgel.github.io/karyoploter_tutorial//Tutorial/Autotrack/Autotrack.html' target='_blank'>autotrack</a> function.</p> 
In order to update the plot data, you need to click on 'Update plot data' button.
")

#' @export
ui = function(id){
  ns = NS(id)

  tagList(
      div(
        class = "card my-3",
        div(
          class = "card-body",
          div(
            p(data_text)
          )
        )
      ),
      div(id="custom_areas"),
      div(
        class="text-end",
        actionButton(
          ns("add_field"),
          style   = "border: 0px",
          label   = NULL,
          icon("circle-plus"),
          onclick="App.enablePanelButton()"
        )
      )
    )

}

#' @export
server = function(id, plot_data){
  moduleServer(id,function(i,o,s){

    ns = s$ns

    panel_count = reactiveValues(values = 0)
    panel_names = reactiveValues(names = character(0))

    observeEvent(i$add_field,{
      id = paste0("panel_",panel_count$values)
      insertUI(
        selector = "#custom_areas",
        ui = add_panel(ns(id))
      )
      panel_count$values = panel_count$values+1
      panel_names$names = c(panel_names$names,ns(id))

      observeEvent(i[[id]],{
        removeUI(selector=paste0("#",ns(id) ))
      })
    })

    





  })
}

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
    removeUI],
  app/logic/add_panel[add_panel]
)

#' @export
ui = function(id){
  ns = NS(id)

  tagList(
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
server = function(id){
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

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
    updateCheckboxInput,
    HTML],
  app/logic/add_panel[add_panel],
  app/logic/find_plot_files[find_plot_files]
)

data_text = HTML("
<p>This section allows you to include graphics dynamically (+). 
Each new panel includes a new track above or below the karyotype. 
Spacing is managed using the <a href='https://bernatgel.github.io/karyoploter_tutorial//Tutorial/Autotrack/Autotrack.html' target='_blank'>autotrack</a> function.</p> 
<p>This section is not reactive so, in order to add plots: 

  <ol>
  
    <li>first, click on + button below</li>
    <li>Choose the plot type and add the CSV file</li>
    <li>Add as many panels as needed</li>
    <li>Finally, click update plot data</li>

  </ol>

Each panel will show a feedback if data has been processed or has errors.
  
</p>
<p>All input data is expected to be a CSV file separated with ;.</p>
<p>The expected data for each plot can be seen on cards.</p>
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

      # Dynamic panel area
      div(id="custom_areas"),

      # Add new panel button
      div(
        class="text-end",
        actionButton(
          ns("add_field"),
          style   = "border: 0px",
          label   = NULL,
          icon("circle-plus", class = "text-white"),
          class = "bg-dark"
        )
      )
    )

}

#' @export
server = function(id, plot_data){
  moduleServer(id,function(i,o,s){

    ns = s$ns

    # Inital state of dynamic panel count
    panel_count = reactiveValues(values = 0)
    panel_names = reactiveValues(names = character(0))

    # Handle new panel creation
    observeEvent(i$add_field,{
      id = paste0("panel_",panel_count$values)

      # Add
      insertUI(
        selector = "#custom_areas",
        ui = add_panel(ns(id))
      )
      panel_count$values = panel_count$values+1
      panel_names$names = c(panel_names$names,ns(id))

      # Remove
      observeEvent(i[[id]],{
        
        target_id = paste0(id,"_valid")

        updateCheckboxInput(
          session = s,
          inputId = target_id,
          label = "",
          value = FALSE
        )

        removeUI(selector=paste0("#",ns(id) ))
      })
    })
  })
}

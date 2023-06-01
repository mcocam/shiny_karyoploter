
box::use(
    shiny[insertUI,removeUI,div,p,actionButton,icon,NS, selectInput, conditionalPanel],
    bslib[card,card_body_fill],
    htmlTable[htmlTable],
    shiny[tags, HTML]
)

#' @export
add_panel = function(id){

    panel_type_choices = c(
        "Bars" = "plot_bar",
        "Points" = "plot_points",
        "Lines" = "plot_lines"
    )

    type_selector = paste0(id, "_type")
    data_selector = paste0(id, "_data")

    div(
        id = id,
        class = "card my-3",
        div(
            class = "card-body",
            div(
                selectInput(type_selector,
                label = "Plot type",
                choices = panel_type_choices,
                selected = "plot_bar")
            ),
            div(
                class="text-end mt-3",
                actionButton(inputId=id,label="Delete",icon=icon("trash"),style="background-color: red;color: white", onclick="App.enablePanelButton()")
            ),

        )
    )

}

box::use(
    shiny[
        insertUI,
        removeUI,
        div,
        p,
        actionButton,
        icon,
        NS,
        selectInput,
        conditionalPanel,
        fileInput,
        checkboxInput,
        uiOutput],
    bslib[
        card,
        card_body_fill],
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
    is_valid_panel = paste0(id, "_valid")
    message_id = paste0(id, "_message")

    div(
        id = id,
        class = "card my-2",

        # Plot type selector
        div(
            class = "card-body",
            div(
                selectInput(type_selector,
                label = "Plot type",
                choices = panel_type_choices,
                selected = "plot_bar")
            ),

            # Handle input data for plots
            div(
                fileInput(data_selector, "",
                            multiple = FALSE,
                            accept = c("text/csv",
                            "text/comma-separated-values,text/plain",
                            ".csv")
                            )
            ),

            # Dynamic user feedback text: has the data been processed?
            div(
                uiOutput(
                    message_id
                )
            ),
            # Handle delete panel
            div(
                class="text-end mt-3",
                actionButton(inputId=id,
                            label="Delete",
                            icon=icon("trash"),
                            style="background-color: red;color: white", 
                            onclick="App.enablePanelButton()")
            ),
            # Hidden state of the data (boolean)
            div(
                class = "d-none",
                checkboxInput(is_valid_panel,
                                label = "",
                                value = TRUE)
            )

        )
    )

}
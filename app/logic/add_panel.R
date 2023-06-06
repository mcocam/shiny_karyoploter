
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
        uiOutput,
        HTML],
    bslib[
        card,
        card_body_fill],
    htmlTable[htmlTable],
    shiny[tags, HTML],
    glue[glue]
)

#' @export
add_panel = function(id){

    panel_type_choices = c(
        "Bars" = "plot_bar",
        "Points" = "plot_points",
        "Lines" = "plot_lines"
    )

    panel_type_messages = c(
        "bars" = "
                <p>The plot function is 
                based on 
                <a href = 'https://rdrr.io/bioc/karyoploteR/man/kpBars.html' 
                target='_blank' >kpBars</a>. The function is based on rectangles geometries 
                (for each row).</p>
                <p>The expected data is a data.frame with the following named columns: 
                    <ul>
                        <li>
                            <span class='fw-bold'>chr</span>:
                            chromosome, 
                            can be multiple and must match the same 
                            label as seen in 'filter chromosome' section)
                        </li>
                        <li>
                            <span class='fw-bold'>x0</span>:
                            initial x position for the rectangle
                        </li>
                        <li>
                            <span class='fw-bold'>x1</span>:
                            final x position for the rectangle
                        </li>
                        <li>
                            <span class='fw-bold'>y1</span>:
                            height of the rectangle
                        </li>
                    <ul>
                </p>
                ",
        "lines" = "
                <p>The plot function is 
                based on 
                <a href = 'https://rdrr.io/bioc/karyoploteR/man/kpLines.html' 
                target='_blank' >kpLines</a>.</p>
                <p>The expected data is a data.frame with the following named columns: 
                    <ul>
                        <li>
                            <span class='fw-bold'>chr</span>:
                            chromosome, 
                            can be multiple and must match the same 
                            label as seen in 'filter chromosome' section)
                        </li>
                        <li>
                            <span class='fw-bold'>x</span>:
                            x value
                        </li>
                        <li>
                            <span class='fw-bold'>y</span>:
                            y value
                        </li>
                    <ul>
                </p>
                ",
        "points" = "
                <p>The plot function is 
                based on 
                <a href = 'https://rdrr.io/bioc/karyoploteR/man/kpPoints.html' 
                target='_blank' >kpPoints</a>.</p>
                <p>The expected data is a data.frame with the following named columns: 
                    <ul>
                        <li>
                            <span class='fw-bold'>chr</span>:
                            chromosome, 
                            can be multiple and must match the same 
                            label as seen in 'filter chromosome' section)
                        </li>
                        <li>
                            <span class='fw-bold'>x</span>:
                            x value
                        </li>
                        <li>
                            <span class='fw-bold'>y</span>:
                            y value
                        </li>
                    <ul>
                </p>
        "
    )

    type_selector = paste0(id, "_type")
    data_selector = paste0(id, "_data")
    is_valid_panel = paste0(id, "_valid")
    message_id = paste0(id, "_message")
    conditional_id = gsub("app-layout-sidebar-panels-","",type_selector)

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

            div(style="font-size: 0.9rem",
                conditionalPanel(
                    condition = glue("input[['{type_selector}']] == 'plot_bar'"),
                    div(class = "mx-2", HTML(panel_type_messages["bars"]))
                ),
                conditionalPanel(
                    condition = glue("input[['{type_selector}']] == 'plot_lines'"),
                    div(class = "mx-2", HTML(panel_type_messages["lines"]))
                ),
                conditionalPanel(
                    condition = glue("input[['{type_selector}']] == 'plot_points'"),
                    div(class = "mx-2", HTML(panel_type_messages["points"]))
                )
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
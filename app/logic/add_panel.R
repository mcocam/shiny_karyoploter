
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
        radioButtons,
        uiOutput,
        tags,
        HTML],
    bslib[
        card,
        card_body],
    htmlTable[htmlTable],
    shiny[tags, HTML],
    glue[glue]
)

#' Generates a new panel ready to be inserted on shiny
#' @param id Shiny server id
#' @return HTML bundle to be inserted in the UI
#' @export 
add_panel = function(id){

    # Plot types available
    panel_type_choices = c(
        "Bars" = "plot_bar",
        "Coverage" = "plot_coverage",
        "Density" = "plot_density",
        "Lines" = "plot_lines",
        "Manhattan" = "plot_manhattan",
        "Points" = "plot_points"
    )

    # Data description depending on plot type selection
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
                            <span class='fw-bold'>chr</span> (character):
                            chromosome, 
                            can be multiple and must match the same 
                            label as seen in 'filter chromosome' section)
                        </li>
                        <li>
                            <span class='fw-bold'>x0</span> (numeric):
                            initial x position for the rectangle
                        </li>
                        <li>
                            <span class='fw-bold'>x1</span> (numeric):
                            final x position for the rectangle
                        </li>
                        <li>
                            <span class='fw-bold'>y1</span> (numeric):
                            height of the rectangle
                        </li>
                    <ul>
                </p>
                ",
        "coverage" = "
            <p>The plot function is 
                based on 
                <a href = 'https://rdrr.io/bioc/karyoploteR/man/kpPlotCoverage.html' 
                target='_blank' >kpPlotCoverage</a>.</p>
                <p>The expected data is a data.frame with the following named columns: 
                    <ul>
                        <li>
                            <span class='fw-bold'>chr</span> (character):
                            chromosome, 
                            can be multiple and must match the same 
                            label as seen in 'filter chromosome' section)
                        </li>
                        <li>
                            <span class='fw-bold'>start</span> (numeric):
                            start x value
                        </li>
                        <li>
                            <span class='fw-bold'>end</span> (numeric):
                            end x value
                        </li>
                    </ul>
                The dataframe is coerced 
                to GRanges object and then density is computed
                (<a href = 'https://rdrr.io/bioc/GenomicRanges/man/makeGRangesFromDataFrame.html' 
                target = '_blank'>makeGRangesFromDataFrame</a>).
                </p>
                
            </p>
        ",
        "density" = "
            <p>The plot function is 
                based on 
                <a href = 'https://rdrr.io/bioc/karyoploteR/man/kpPlotDensity.html' 
                target='_blank' >kpPlotDensity</a>.</p>
                <p>The expected data is a data.frame with the following named columns: 
                    <ul>
                        <li>
                            <span class='fw-bold'>chr</span> (character):
                            chromosome, 
                            can be multiple and must match the same 
                            label as seen in 'filter chromosome' section)
                        </li>
                        <li>
                            <span class='fw-bold'>start</span> (numeric):
                            start x value
                        </li>
                        <li>
                            <span class='fw-bold'>end</span> (numeric):
                            end x value
                        </li>
                    </ul>
                The dataframe is coerced 
                to GRanges object and then density is computed
                (<a href = 'https://rdrr.io/bioc/GenomicRanges/man/makeGRangesFromDataFrame.html' 
                target = '_blank'>makeGRangesFromDataFrame</a>).
                </p>
                
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
                            <span class='fw-bold'>x</span> (numeric):
                            x value
                        </li>
                        <li>
                            <span class='fw-bold'>y</span> (numeric):
                            y value
                        </li>
                    <ul>
                </p>
                ",
        "horizon" = "
        <p>The plot function is 
                based on 
                <a href = 'https://rdrr.io/bioc/karyoploteR/man/kpPlotHorizon.html' 
                target='_blank' >kpPlotHorizon</a>.</p>
                <p>The expected data is a data.frame with the following named columns: 
                    <ul>
                        <li>
                            <span class='fw-bold'>chr</span> (character):
                            chromosome, 
                            can be multiple and must match the same 
                            label as seen in 'filter chromosome' section)
                        </li>
                        <li>
                            <span class='fw-bold'>start</span> (numeric):
                            start x value
                        </li>
                        <li>
                            <span class='fw-bold'>end</span> (numeric):
                            end x value
                        </li>
                        <li>
                            <span class='fw-bold'>y</span> (numeric):
                            y value
                        </li>
                    </ul>
                The dataframe is coerced 
                to GRanges object 
                (<a href = 'https://rdrr.io/bioc/GenomicRanges/man/makeGRangesFromDataFrame.html' 
                target = '_blank'>makeGRangesFromDataFrame</a>).
                </p>
                
            </p>
        ",
        "manhattan" = "
            <p>The plot function is 
                based on 
                <a href = 'https://rdrr.io/github/bernatgel/karyoploteR/man/kpPlotManhattan.html' 
                target='_blank' >kpPlotManhattan</a>.</p>
                <p>The expected data is a data.frame with the following named columns: 
                    <ul>
                        <li>
                            <span class='fw-bold'>chr</span> (character):
                            chromosome, 
                            can be multiple and must match the same 
                            label as seen in 'filter chromosome' section)
                        </li>
                        <li>
                            <span class='fw-bold'>start</span> (numeric):
                            start x value
                        </li>
                        <li>
                            <span class='fw-bold'>end</span> (numeric):
                            end x value
                        </li>
                        <li>
                            <span class='fw-bold'>pval</span> (numeric):
                            y value
                        </li>
                    </ul>
                The dataframe is coerced 
                to GRanges object 
                (<a href = 'https://rdrr.io/bioc/GenomicRanges/man/makeGRangesFromDataFrame.html' 
                target = '_blank'>makeGRangesFromDataFrame</a>).
                </p>
                
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

    # IDs for components
    type_selector = paste0(id, "_type")
    data_selector = paste0(id, "_data")
    is_valid_panel = paste0(id, "_valid")
    is_multi_id = paste0(id, "_multi")
    message_id = paste0(id, "_message")
    panel_position_id = paste0(id, "_data.panel")
    conditional_id = gsub("app-layout-sidebar-panels-","",type_selector)

    # HTML bundle to be RETURNED
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
                selected = "plot_bar"),
                tags$head(tags$script(HTML(glue("
                    $('body').on('change', '#{type_selector}', () => App.enablePanelButton())
                    "))))
            ),

            div(style="font-size: 0.9rem",
                conditionalPanel(
                    condition = glue("input[['{type_selector}']] == 'plot_bar'"),
                    div(class = "mx-2", HTML(panel_type_messages["bars"]))
                ),
                conditionalPanel(
                    condition = glue("input[['{type_selector}']] == 'plot_coverage'"),
                    div(class = "mx-2", HTML(panel_type_messages["coverage"]))
                ),
                conditionalPanel(
                    condition = glue("input[['{type_selector}']] == 'plot_density'"),
                    div(class = "mx-2", HTML(panel_type_messages["density"]))
                ),
                conditionalPanel(
                    condition = glue("input[['{type_selector}']] == 'plot_lines'"),
                    div(class = "mx-2", HTML(panel_type_messages["lines"]))
                ),
                conditionalPanel(
                    condition = glue("input[['{type_selector}']] == 'plot_horizon'"),
                    div(class = "mx-2", HTML(panel_type_messages["horizon"]))
                ),
                conditionalPanel(
                    condition = glue("input[['{type_selector}']] == 'plot_manhattan'"),
                    div(class = "mx-2", HTML(panel_type_messages["manhattan"]))
                ),
                conditionalPanel(
                    condition = glue("input[['{type_selector}']] == 'plot_points'"),
                    div(class = "mx-2", HTML(panel_type_messages["points"]))
                )
            ),

            div(
                conditionalPanel(
                    condition = glue("input[['{is_multi_id}']]"),
                    div(
                      class = "mx-2",
                      radioButtons(
                        panel_position_id,
                        label = HTML("<p class='fw-bold'>Where the panel should be placed?</p>"),
                        choices = c("Upper section" = 1, "Lower section" = 2)
                      ),
                      tags$head(tags$script(HTML(glue("
                        $('body').on('change', '#{panel_position_id}', () => App.enablePanelButton())
                        "))))
                    )
                )
            ),
            # Handle input data for plots
            div(
                fileInput(data_selector, "",
                            multiple = FALSE,
                            accept = c("text/csv",
                            "text/comma-separated-values,text/plain",
                            ".csv")
                            ),
                tags$head(tags$script(HTML(glue("
                    $('body').on('change', '#{data_selector}', () => App.enablePanelButton())
                "))))
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
                                value = TRUE),
                checkboxInput(is_multi_id,
                                label = "",
                                value = FALSE)
            )

        )
    )

}
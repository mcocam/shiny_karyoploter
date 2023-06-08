box::use(
    shiny[
        moduleServer,
        NS,
        sidebarLayout,
        reactive,
        observeEvent,
        observe,
        reactiveVal,
        isTruthy,
        HTML,
        div,
        renderUI,
        updateActionButton,
        updateCheckboxInput,
        updateRadioButtons
        ],

    data.table[fread],

    app/view/karyoploter/sidebar/sidebar,
    app/view/karyoploter/main_panel/main_panel,

    app/logic/find_params[find_params],
    app/logic/find_plot_files[find_plot_files],
    app/logic/validate_panel_data[validate_panel_data],
    app/logic/find_multiplot_inputs[find_multiplot_inputs],

    karyoploteR[kpAddChromosomeNames]
)

#' @export
ui = function(id){

    ns = NS(id)

    sidebarLayout(
        sidebar = sidebar$ui(ns("sidebar")),
        mainPanel = main_panel$ui(ns("mainPanel"))
    )

}

#' @export
server = function(id,karyo_params){
    moduleServer(id,function(i,o,s){

    # Base plotKaryotype params
    karyo_params = reactive({

        params = list()

        argument_values = find_params(i)

        for (argument in names(argument_values) ){

            if(argument == "labels.plotter"){
                if(unlist(i[[argument_values[[argument]]]]) == FALSE){
                    params[argument] = list(NULL)
                }else{
                    next
                }
            }else{
                params[[argument]] = unlist(i[[argument_values[[argument]]]])
            }
        }

        if(params[["plot.type"]] %in% c("3", "4", "5")){
            params[["srt"]] = "90"
        }

        params
    })

    marker_data = reactiveVal(NULL) # Marker data initialization
    plot_data = reactiveVal(NULL)   # Plot data initialization

    # When update plot is clicked, get all the valid input data
    observeEvent(i[["sidebar-btn-update"]],{

        plot_data(NULL)

        tryCatch({

            input_references = find_plot_files(i)

            if(length(input_references) > 0){

                plot_data_list = list()

                for (index in 1:nrow(input_references) ){

                    input_ref = input_references[index,]
                    type_id = input_ref$type
                    file_id = input_ref$data 
                    valid_id = input_ref$valid
                    message_id = input_ref$message
                    placement_id = input_ref$placement

                    selected_type = i[[type_id]]
                    file_path = i[[file_id]]$datapath
                    is_valid = i[[valid_id]]
                    placement = i[[placement_id]]

                    if(!isTruthy(file_path)){
                        o[[message_id]] = renderUI({ 
                                div(HTML("<p class='text-danger'> ❌ No data</p>"))
                                })
                        next
                    }

                    if(is_valid){
                        data = fread(file_path, sep = ";")

                        is_data_valid = validate_panel_data(selected_type, data)

                        if(is_data_valid){

                            temp_list = list(
                                "type" = selected_type,
                                "placement" = placement,
                                "data" = list(data)
                            )

                            plot_data_list[[index]] = temp_list

                            o[[message_id]] = renderUI({ 
                                div(HTML("<p class='text-success fw-bold'>✅ Correct data</p>"))
                                })

                        }else{
                            o[[message_id]] = renderUI({ 
                                div(HTML("<p class='text-danger'> ❌ Incorrect data. Please check the specifications</p>"))
                                })
                            next
                        }
                    }
                }

                if(length(plot_data_list) > 0){

                    cleaned_data_list = list()
                    valid_list_index = 1
                    for (index in 1:length(plot_data_list)){
                        
                        list_temp = plot_data_list[[index]]

                        if(length(list_temp) > 1){
                            cleaned_data_list[[valid_list_index]] = list_temp 
                            valid_list_index = valid_list_index + 1
                        }
                    }

                    if(length(cleaned_data_list) > 0){
                        plot_data(cleaned_data_list)
                    }else{
                        plot_data(NULL)
                    }
                    
                }

            }

    },
    error = function(e) NULL,
    warning = function(w) print(w)
    )

    })

    selected_genome = reactive({
        i[["sidebar-genomes-kparams_genome"]]
    })

    observe({
        selected_type = i[["sidebar-plot_type-kparams_plot.type"]]
        inputs = find_multiplot_inputs(i)
        plot_inputs = find_plot_files(i)

        if(selected_type %in% c("2","3")){
            for(input in inputs){
                updateCheckboxInput(s, input, value = TRUE)
            }
        }else{
            for(input in inputs){
                updateCheckboxInput(s, input, value = FALSE)
            }
            for(index in seq_along(plot_inputs)){
                placement_id = plot_inputs[index,]$placement
                updateRadioButtons(s, placement_id, selected = 1)
            }
        }

    })

    # observe({
    #     plot_inputs = find_plot_files(i)
    #     type_input_id = plot_inputs$type 

    #     observeEvent(sapply(type_input_id, function(name) i[[name]]), {
    #         updateActionButton(
    #             s,
    #             "sidebar-btn-update",
    #             disabled = FALSE
    #         )
    #     })
    # })

    sidebar$server("sidebar",karyo_params,selected_genome, marker_data, plot_data)
    main_panel$server("mainPanel",karyo_params, marker_data, plot_data)

    })
}

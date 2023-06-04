box::use(
    shiny[
        moduleServer,
        NS,
        sidebarLayout,
        reactive,
        observeEvent,
        observe,
        reactiveVal,
        isTruthy
        ],

    app/view/karyoploter/sidebar/sidebar,
    app/view/karyoploter/main_panel/main_panel,

    app/logic/find_params[find_params],
    app/logic/find_plot_files[find_plot_files]
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
            params[[argument]] = unlist(i[[argument_values[[argument]]]])
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

        input_references = find_plot_files(i)

        if(length(input_references) > 0){

            for (index in 1:nrow(input_references) ){

                input_ref = input_references[index,]
                type_id = input_ref$type
                file_id = input_ref$data 
                valid_id = input_ref$valid

                selected_type = i[[type_id]]
                file_path = i[[file_id]]$filepath 
                is_valid = i[[valid_id]]

                print(is_valid)
            }

        }

        

    })

    selected_genome = reactive({
        i[["sidebar-genomes-kparams_genome"]]
    })

        sidebar$server("sidebar",karyo_params,selected_genome, marker_data, plot_data)
        main_panel$server("mainPanel",karyo_params, marker_data, plot_data)

    })
}

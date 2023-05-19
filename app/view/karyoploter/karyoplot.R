box::use(
    shiny[
        moduleServer,
        NS,
        sidebarLayout,
        reactive,
        observeEvent,
        observe,
        reactiveVal
        ],

    app/view/karyoploter/sidebar/sidebar,
    app/view/karyoploter/main_panel/main_panel,

    app/logic/find_inputs[find_inputs]
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

        argument_values = find_inputs(i,".*-kparams_(.*)")

        for (argument in names(argument_values) ){
            params[[argument]] = unlist(i[[argument_values[[argument]]]])
        }

        if(params[["plot.type"]] %in% c("3", "4", "5")){
            params[["srt"]] = "90"
        }

        params
    })

    marker_data = reactiveVal(NULL) # Marker data initialization

    selected_genome = reactive({
        i[["sidebar-genomes-kparams_genome"]]
    })

        sidebar$server("sidebar",karyo_params,selected_genome, marker_data)
        main_panel$server("mainPanel",karyo_params, marker_data)

    })
}

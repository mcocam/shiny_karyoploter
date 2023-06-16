
box::use(
    stringr[str_match_all]
)


#' Find the the plot type of dynamic panels
#' @param input Shiny server object
#' @return A dataframe with the input references. Columns: (1) type, (2) file
#' @export
find_plot_files = function(input){
    input_names = names(input)
    expression = "(.*-panels-panel_[:digit:]_)type"

    input_references = data.frame(
        type = character(),
        file = character(),
        valid = character(),
        message = character()
    )

    for (input_name in input_names){
        match = str_match_all(input_name, expression)
        n_matches = length(match[[1]])

        if(n_matches == 2){

            input_found = match[[1]][2]

            type = paste0(input_found, "type")
            data = paste0(input_found, "data")
            valid = paste0(input_found, "valid")
            message = paste0(input_found, "message")
            placement = paste0(input_found, "data.panel")

            temp = data.frame(
                type = type,
                data = data,
                valid = valid,
                message = message,
                placement = placement
            )

            input_references = rbind(input_references, temp)

        }
    }

    return(input_references)

}
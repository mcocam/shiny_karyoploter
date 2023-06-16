
box::use(
    stringr[str_match_all]
)

#' Find dynamically generated input files for plots
#' @param input Shiny server object
#' @return A list with matched param name and the input name reference
#' @export 
find_multiplot_inputs = function(input){

    input_names = names(input)
    expression = ".*-panel_.*_multi$"
    inputs_found = c()

    for (input_name in input_names){
        match = str_match_all(input_name,expression)
        n_matches = length(match[[1]])

        if(n_matches == 1){

            input_name = match[[1]][1]

            inputs_found = c(inputs_found, input_name)

        }
    }

    return(inputs_found)


}
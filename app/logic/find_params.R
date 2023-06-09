
box::use(
    stringr[str_match_all]
)


#' Find input user parameters for plotKaryotype() function
#' @param input Shiny server object
#' @return A list with matched param name and the input name reference
#' @export 
find_params = function(input){

    input_names = names(input)
    expression = ".*-kparams_(.*)"
    inputs_found = list()

    for (input_name in input_names){
        match = str_match_all(input_name,expression)
        n_matches = length(match[[1]])

        if(n_matches == 2){

            argument = match[[1]][2]
            input_name = match[[1]][1]

            inputs_found[argument] = input_name

        }
    }

    return(inputs_found)


}
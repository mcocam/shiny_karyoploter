
box::use(
    stringr[str_match_all]
)


#' Find input user parameters for plotKaryotype() function
#' Default expression: kparams52
#' @param input Shiny server object
#' @return A list with matched param name and the input name reference
#' @export 
find_inputs = function(input, expression){

    input_names = names(input)
    regexp = paste0(".*-kparams_(.*)")
    inputs_found = list()

    for (input_name in input_names){
        match = str_match_all(input_name,regexp)
        n_matches = length(match[[1]])

        if(n_matches == 2){

            argument = match[[1]][2]
            input_name = match[[1]][1]

            inputs_found[argument] = input_name

            if(argument == "plot.type"){
                value = as.numeric(input[[input_name]])

                if(value >= 3){
                    inputs_found["srt"] = "90"
                }
            }

        }
    }

    return(inputs_found)


}


#' Evaluates if the data uploaded by the user is correct
#' @param plot_type selected plot type
#' @param plot_data uploaded plot data
#' @return A list with matched param name and the input name reference
#' @export 
validate_panel_data = function(plot_type, plot_data){

    is_valid = FALSE 

    tryCatch(
        {

            observed_columns    = colnames(plot_data)
            observed_types      = sapply(plot_data, mode)

            switch(
                plot_type,
                "plot_bar" = {
                    expected_columns    = c("chr", "x0", "x1", "y1")
                    expected_types      = c("character", "numeric", "numeric", "numeric")

                    are_variables_valid = all(observed_columns  == expected_columns)
                    are_types_valid     = all(observed_types    == expected_types)

                    if(are_variables_valid & are_types_valid){
                        is_valid = TRUE
                    }
                },
                "plot_coverage" = {
                    expected_columns    = c("chr", "start", "end")
                    expected_types      = c("character", "numeric", "numeric")

                    are_variables_valid = all(observed_columns  == expected_columns)
                    are_types_valid     = all(observed_types    == expected_types) 

                    if(are_variables_valid & are_types_valid){
                        is_valid = TRUE
                    }
                },
                "plot_density" = {
                    expected_columns    = c("chr", "start", "end")
                    expected_types      = c("character", "numeric", "numeric")

                    are_variables_valid = all(observed_columns  == expected_columns)
                    are_types_valid     = all(observed_types    == expected_types) 

                    if(are_variables_valid & are_types_valid){
                        is_valid = TRUE
                    }
                },
                "plot_horizon" = {
                    expected_columns    = c("chr", "start", "end", "y")
                    expected_types      = c("character", "numeric", "numeric", "numeric")

                    are_variables_valid = all(observed_columns  == expected_columns)
                    are_types_valid     = all(observed_types    == expected_types)

                    if(are_variables_valid & are_types_valid){
                        is_valid = TRUE
                    }
                },
                "plot_lines" = {
                    expected_columns    = c("chr", "x", "y")
                    expected_types      = c("character", "numeric", "numeric")

                    are_variables_valid = all(observed_columns  == expected_columns)
                    are_types_valid     = all(observed_types    == expected_types)

                    if(are_variables_valid & are_types_valid){
                        is_valid = TRUE
                    }

                },
                "plot_manhattan" = {
                    expected_columns    = c("chr", "start", "end", "pval")
                    expected_types      = c("character", "numeric", "numeric", "numeric")

                    are_variables_valid = all(observed_columns  == expected_columns)
                    are_types_valid     = all(observed_types    == expected_types)

                    if(are_variables_valid & are_types_valid){
                        is_valid = TRUE
                    }

                },
                "plot_points" = {
                    expected_columns    = c("chr", "x", "y")
                    expected_types      = c("character", "numeric", "numeric")

                    are_variables_valid = all(observed_columns  == expected_columns)
                    are_types_valid     = all(observed_types    == expected_types)

                    if(are_variables_valid & are_types_valid){
                        is_valid = TRUE
                    }
                }
            )
        },
        error = function(e) NULL,
        warning = function(w) NULL
    )

    return(is_valid)

}
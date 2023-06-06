

#' @export
validate_panel_data = function(plot_type, plot_data){

    is_valid = FALSE 

    tryCatch(
        {
            switch(
                plot_type,
                "plot_bar" = {
                    expected_columns    = c("chr", "x0", "x1", "y1")
                    expected_types      = c("character", "numeric", "numeric", "numeric")

                    observed_columns    = colnames(plot_data)
                    observed_types      = sapply(plot_data, class)

                    are_variables_valid = all(observed_columns  == expected_columns)
                    are_types_valid     = all(observed_types    == expected_types)

                    if(are_variables_valid & are_types_valid){
                        is_valid = TRUE
                    }
                },
                "plot_lines" = {
                    expected_columns    = c("chr", "x", "y")
                    expected_types      = c("character", "numeric", "numeric")

                    observed_columns    = colnames(plot_data)
                    observed_types      = sapply(plot_data, class)

                    are_variables_valid = all(observed_columns  == expected_columns)
                    are_types_valid     = all(observed_types    == expected_types)

                    if(are_variables_valid & are_types_valid){
                        is_valid = TRUE
                    }

                },
                "plot_points" = {
                    expected_columns    = c("chr", "x", "y")
                    expected_types      = c("character", "numeric", "numeric")

                    observed_columns    = colnames(plot_data)
                    observed_types      = sapply(plot_data, class)

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
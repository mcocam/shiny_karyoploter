
box::use(
    utils[tail]
)


#' @export
get_min_max_y = function(plot_data){

    min_max_vector = c(0,1)

    tryCatch(
        {
            y_max_pattern = "^y$|^y1$|start"
            y_min_pattern = "^y$|^y0$|^y1$|start"

            col_names = names(plot_data)

            y_max_col = tail(grep(y_max_pattern, col_names, value = TRUE),n=1)
            y_min_col = tail(grep(y_min_pattern, col_names, value = TRUE),n=1)

            y_min = min(plot_data[[y_min_col]])
            y_max = max(plot_data[[y_max_col]])

            min_max_vector[1] = y_min
            min_max_vector[2] = y_max
        },
        error = function(e) NULL,
        warning = function(w) print(w)
    )

    return(min_max_vector)


}
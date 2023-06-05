

#' @export
normalize_y = function(y){

    min_y = min(y)
    max_y = max(y)

    normalized_values = (y - min_y) / (max_y - min_y)

    return(normalized_values)
}
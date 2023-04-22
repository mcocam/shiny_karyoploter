box::use(
    glue[glue]
)


#' @export 
make_plot_code = function(karyo_params){

    karyo_params_v = karyo_params()

    arguments = rev(names(karyo_params_v))
    values = rev(unlist(karyo_params_v))

    arguments_string = paste(arguments, " = '",values, "'", collapse=", ", sep="")

    code = glue("kp = plotKaryoplot({arguments_string})")

    return(code)

}
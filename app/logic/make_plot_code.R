box::use(
    glue[glue]
)


#' @export 
make_plot_code = function(karyo_params, marker_data, plot_data){

    karyo_params_v = karyo_params()

    arguments_code_string = ""
    for (param_name in names(karyo_params_v)){

        argument_name = param_name
        argument_values = karyo_params_v[[argument_name]]

        if(length(argument_values)>1){
            argument_values = paste0("c(",paste0("'",argument_values, collapse="', "), "')")
            argument_value_string = glue("{argument_name} = {argument_values}")
        }else{
            argument_value_string = glue("{argument_name} = '{argument_values}'")
        }

        arguments_code_string = paste0(arguments_code_string,argument_value_string,sep=", ")
    }

    arguments_code_string = substr(arguments_code_string, 1, nchar(arguments_code_string) - 2)

    code = glue("kp = plotKaryoplot({arguments_code_string})")

    return(code)

}
box::use(
  shiny[
    moduleServer,
    NS,
    renderPlot,
    plotOutput,
    textOutput,
    renderText,
    observe,
    reactive],
    shinyAce[aceEditor,updateAceEditor],
    app/logic/make_plot_code[make_plot_code]
)

#' @export
ui = function(id){
    ns = NS(id)

    aceEditor(
        outputId = ns("karyo_code"), 
        value="", 
        readOnly = TRUE, 
        height="100%",
        theme="monokai",
        mode = "r",
        fontSize = 20,
        wordWrap = TRUE)

}

#' @export
server = function(id,karyo_params, marker_data, plot_data){
  moduleServer(id,function(i,o,s){

    code = reactive({
        code = make_plot_code(karyo_params, marker_data, plot_data)
    })

    observe({
        updateAceEditor(s, "karyo_code", value = code())
    })


  })
}
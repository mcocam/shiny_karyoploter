box::use(
  shiny[
    moduleServer,
    NS,
    selectInput,
    reactive,
    span,
    checkboxInput
    ]
)

#' @export
ui = function(id){
  ns = NS(id)
    checkboxInput(
        ns("kparams_labels.plotter"),
        span(class="text-dark",  "Show chromosome labels"),
        value = TRUE
    )

}

#' @export
server = function(id){
  moduleServer(id,function(i,o,s){

    show_chr_labels = reactive({
      i$kparams_labels.plotter
    })

  })
}
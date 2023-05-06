box::use(
  shiny[
    moduleServer,
    NS,
    selectInput,
    reactive,
    span
    ]
)

#' @export
available_types = list(
        "1) Vertical ideogram (1 panel above)" = 1,
        "2) V. ideogram (1 p. above, 1 below)" = 2,
        "3) Horizontal ideogram (muti panel)" = 3,
        "4) H. ideogram (panels above)" = 4,
        "5) H. ideogram (panels below)" = 5
)

#' @export
ui = function(id){
  ns = NS(id)
    selectInput(
        ns("kparams_plot.type"),
        span(class="text-dark fw-bold",  "Plot type:"),
        available_types,
        selected = 1
    )

}

#' @export
server = function(id){
  moduleServer(id,function(i,o,s){

    selected_type = reactive({
      i$kparams_plot.type
    })

  })
}

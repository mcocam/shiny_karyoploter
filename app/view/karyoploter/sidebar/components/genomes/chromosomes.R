box::use(
  shiny[
    moduleServer,
    NS,
    selectizeInput,
    reactive,
    span
    ]
)


#' @export
ui = function(id){
  ns = NS(id)
    selectizeInput(
        ns("kparams_chromosomes"),
        span(class="text-dark fw-bold",  "Filter chromosomes:"),
        multiple = TRUE,
        list("chr1" = "chr1", "chr2" = "chr2", "chr3" = "chr3"),
        selected = c("chr1","chr2")
    )

}

#' @export
server = function(id){
  moduleServer(id,function(i,o,s){

    selected_chromosomes = reactive({
      i$kparams_chromosomes
    })

  })
}
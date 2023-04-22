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
available_genomes = list(

    "Fruitfly (dm6)" = "dm6",
    "Human (hg19)" = "hg19",
    "Human (hg38)" = "hg38",
    "Mouse (mm9)" = "mm9",
    "Mouse (mm10)" = "mm10",
    "Rat (rn5)" = "rn5",
    "Rat (rn6)" = "rn6",
    "Worm (ce6)" = "ce6",
    "Yeast (sacCer3)" = "sacCer3"

)

#' @export
ui = function(id){
  ns = NS(id)
    selectInput(
        ns("genome"),
        span(class="text-dark fw-bold",  "Genome:"),
        available_genomes,
        selected = "hg19"
    )

}

#' @export
server = function(id,karyo_params){
  moduleServer(id,function(i,o,s){

    selected_genome = reactive({
      i$genome
    })

  })
}

box::use(
  shiny[
    moduleServer,
    NS,
    selectizeInput,
    reactive,
    span,
    observe,
    updateSelectizeInput,
    isolate
    ],
    karyoploteR[plotKaryotype]
)

available_chromosomes = c("chr1",
                          "chr2",
                          "chr3",
                          "chr4",
                          "chr5",
                          "chr6",
                          "chr7",
                          "chr8",
                          "chr9",
                          "chr10",
                          "chr11",
                          "chr12",
                          "chr13",
                          "chr14",
                          "chr15",
                          "chr16",
                          "chr17",
                          "chr18",
                          "chr19",
                          "chr20",
                          "chr21",
                          "chr22",
                          "chrX",
                          "chrY")

#' @export
ui = function(id){
  ns = NS(id)
    selectizeInput(
        ns("kparams_chromosomes"),
        span(class="text-dark fw-bold",  "Filter chromosomes:"),
        multiple = TRUE,
        available_chromosomes,
        selected = available_chromosomes
    )

}

#' @export
server = function(id,genome){
  moduleServer(id,function(i,o,s){

    observe({
      genome = genome()
      chromosomes = plotKaryotype(genome)$chromosomes
      updateSelectizeInput(
        s,
        "kparams_chromosomes",
        choices = chromosomes,
        selected = chromosomes
      )
    })

    selected_chromosomes = reactive({
      i$kparams_chromosomes
    })

  })
}
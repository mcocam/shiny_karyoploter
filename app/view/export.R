box::use(
  shiny[
    moduleServer,
    NS,
    downloadButton,
    downloadHandler,
    radioButtons,
    tagList],

  Cairo[CairoPNG,CairoSVG],
  grDevices[dev.off],
  karyoploteR[plotKaryotype]
)

#' @export
ui = function(id){
  ns = NS(id)
  tagList(
    radioButtons(ns("format"),"Export as:",c("PNG"="png","SVG"="svg")),
    downloadButton(ns("img"),label="Export image")
  )


}

#' @export
server = function(id,karyo_params){
  moduleServer(id,function(i,o,s){

    options(shiny.usecairo=TRUE)

    o$img = downloadHandler(
      filename = function(){paste0("prova.",i$format)},
      content = function(file){
        if(i$format == "png"){
          CairoPNG(file)
        }else if(i$format == "svg"){
          CairoSVG(file)
        }
        
        do.call(plotKaryotype,karyo_params())
        dev.off()
      }
    )

  })
}

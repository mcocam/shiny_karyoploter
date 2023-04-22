box::use(
  shiny[moduleServer, NS,a,renderPlot,plotOutput,reactive,p,callModule],
  bslib[page_navbar,nav,bs_theme,font_google],
  app/view/karyoploter/karyoplot
)

# App main theme
karyoploter_theme = bs_theme(
  version = "5",
  base_font = font_google("Roboto"),
  bootswatch = "zephyr"
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  page_navbar(

    # Theme and styles
    theme = karyoploter_theme,
    title = a(href="/",
              style="text-decoration: none;color:black",
              "KaryoploteR"),
    inverse = FALSE,

    # Content modules

    ## Draw karyoploteR
    nav("karyoploteR",
      karyoplot$ui(ns("layout"))
    ),

    ## Get started
    nav("Get started",
      p("Tutorials, examples and more, much more")
    )

  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(i, o, s) {

    karyoplot$server("layout")

  })
}

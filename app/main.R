box::use(
  shiny[moduleServer, NS,a,renderPlot,plotOutput,reactive,p],
  bslib[page_navbar,nav,bs_theme,font_google],
  app/view/app,
  karyoploteR[plotKaryotype]
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
    theme = karyoploter_theme,
    title = a(href="/",
              style="text-decoration: none;color:black",
              "KaryoploteR"),
    inverse = FALSE,

    # Content modules
    nav("App",
    app$ui(ns("plot"))
    ),
    nav("Get started",
    p("Tutorials, examples and more, much more"))

  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(i, o, s) {

    karyo_params = reactive({
      params = list() # Input params
    })

    input_data = reactive({}) # Input user data

    app$server("plot",karyo_params)

  })
}

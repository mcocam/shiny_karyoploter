box::use(
  shiny[moduleServer, NS,a,renderPlot,reactive, p, HTML, div],
  bslib[page_navbar,nav_panel,bs_theme,font_google, nav_item],
  
  app/view/karyoploter/karyoplot,
  app/view/welcome/welcome,
  app/view/examples/examples
)

# File size limit
options(shiny.maxRequestSize = 2 * 1024^2)

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
    title = a(href="https://mcocam.shinyapps.io/shiny_karyoploter/",
              style="text-decoration: none;color:black",
              "KaryoploteR"),
    inverse = FALSE,

    # Content modules

    ## Welcome module
    nav_panel("Welcome",
      welcome$ui(ns("welcome"))
    ),

    ## karyoploteR App
    nav_panel("karyoploteR",
      karyoplot$ui(ns("layout"))
    ),

    ## Examples
    nav_panel("Examples",
      examples$ui(ns("examples"))
    ),

    # Link to github repo
    nav_item(
      class = "ms-md-auto mx-2",
      style = "font-size: 1.1rem; padding: 0; margin: 0",
      HTML("<a href = 'https://github.com/mcocam/shiny_karyoploter' target = '_blank'>
              <i class='fa-brands fa-github'></i></a>")
      )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(i, o, s) {

    ## Packed server logic (karyoploteR module)
    karyoplot$server("layout")

  })
}

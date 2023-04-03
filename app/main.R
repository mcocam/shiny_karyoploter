box::use(
  shiny[bootstrapPage, moduleServer, NS, renderText, tags, textOutput,navbarPage],
  bslib[page_navbar,nav,nav_menu,bs_theme,card,card_body,card_body_fill,font_google]
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
  navbarPage(
    theme = karyoploter_theme,
    title = "KaryoploteR",
    inverse = FALSE,
    nav("Link 1"),
    nav("Link 2")

  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$message <- renderText("Hello!")
  })
}

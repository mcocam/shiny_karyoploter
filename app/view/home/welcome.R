box::use(
  shiny[
    div,
    HTML,
    p
  ]
)


#' @export
ui <- function(id){
  div( class="container-md my-5",
    div(class = "text-center fs-2 text-black fw-bold fade-in","Welcome to Shiny karyoploteR"),

    div(class = "text-center fs-4",
        HTML("An interactive interface for 
              <a href = 'https://bernatgel.github.io/karyoploter_tutorial/', target = 'blank'>
              karyoploteR</a>")),

    # Section
    div( class = "my-4 text-black mx-3",
      div(
        class = "fs-4 mt-5 mb-3",
        "What is Shiny karyoploteR?"
      ),
      HTML("
      <p>
        Shiny karyoploteR is an interactive interface for the
        <a href = 'https://bernatgel.github.io/karyoploter_tutorial/', target = 'blank'> 
        karyoploteR </a>
        R library, that allows you to create representations of various genomes, 
        add data dynamically and also get the code behind the plot.
      </p>
      <p>
        The application has been developed using 
        <a href = 'https://shiny.posit.co/', target = '_blank'>Shiny</a> and
        <a href = 'https://appsilon.github.io/rhino/' target = '_blank'>rhino</a>.
        The code can be downloaded at the following 
        <a href = 'https://github.com/mcocam/shiny_karyoploter' target = '_blank'>link</a>.
      </p>
      <p>
        A live demo of the app can be found on 
        <a href = 'https://mcocam.shinyapps.io/shiny_karyoploter/' target = '_blank'>shinyapps</a> 
        portal. Please note that if you use the demo application, 
        resources are limited, and it may be unstable depending on the traffic.
        In fact, user data is limited to 1MB per file. 
        If your intention is to load large files, please use the local 
        version and modify the parameters in the main.R file
      </p>
      "),
      
    )
  )
}


#' @export
server <- function(id) {}
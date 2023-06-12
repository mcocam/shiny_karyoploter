box::use(
  shiny[
    div,
    HTML,
    p,
    img
  ]
)


#' @export
ui <- function(id){
  div( class="container-md my-5",
    div(class = "text-center fs-2 text-black fw-bold","Welcome to Shiny karyoploteR"),

    div(class = "text-center fs-4",
        HTML("An interactive interface for 
              <a href = 'https://bernatgel.github.io/karyoploter_tutorial/', target = 'blank'>
              karyoploteR</a>")),

    div(
      class = "text-center",
      img(class = "img-fluid", src = "https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/cover.png?raw=true", style = "width: 50%")
    ),

    # Section
    div( class = "my-4 text-black mx-3",
      div(
        class = "fs-4 my-2",
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
      ")
    ),

    div( class = "my-4 text-black mx-3",
      div(
        class = "fs-4 my-2",
        "Where does the application come from??"
      ),
      HTML("
      <p>
        The application is the result of the final project of the 
        <a 
          href='https://www.uoc.edu/ca/estudis/masters/master-universitari-bioinformatica-bioestadistica' 
          target = '_blank'
        >
          Master's Degree in Bioinformatics and Biostatistics
        </a> (Open University of Catalonia).
      </p>
      <p>
        For this reason, the application is not ready for production; rather, 
        it is the first step, a proof of concept, for the integration of karyoploteR with Shiny
      </p>
      ")
    ),

    div( class = "my-4 text-black mx-3",
      div(
        class = "fs-4 my-2",
        "How to use it?"
      ),
      HTML("
      <p>
        The visualization application is composed of 3 main parts: 
        <ul>
          <li>The ideogram</li>
          <li>Markers</li>
          <li>Plots</p>
        </ul>
      </p>
      ")
    )

  )
}


#' @export
server <- function(id) {}
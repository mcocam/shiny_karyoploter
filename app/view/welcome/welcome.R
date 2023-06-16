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
      img(class = "img-fluid", src = "https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/samples/hg38_manhattan.png?raw=true", style = "width: 50vw")
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

    div(class = "my-4 text-black mx-3",
      div(
        class = "fs-4 my-2",
        "How to use it?"
      ),
      HTML("
      <p>
        The visualization application is composed of 3 main parts: 
        <ul>
          <li>The ideogram</li>
          <img style = 'width: 30vw' class = 'rounded mt-1 mb-3 mx-5' src = 'https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/karyoploter_1.png?raw=true'></img>
          <li>Markers</li>
          <img style = 'width: 30vw' class = 'rounded  mt-1 mb-3 mx-5' src = 'https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/karyoploter_2.png?raw=true'></img>
          <li>Plots</p>
          <img style = 'width: 40vw' class = 'rounded  mt-1 mb-3 mx-5' src = 'https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/karyoploter_3.png?raw=true'></img>
        </ul>
      </p>
      <p>
      
        The <span class = 'fw-bold'>ideogram</span> allows you to choose 
        one of the available genomes in the package and use it as template.
        <span class = 'fw-bold'>Markers</span> are just labels placed on a 
        specific position and they are based on user's data (CSV file).

      </p>
      <p>
      
        Finally, <span class = 'fw-bold'>plots</span> allow you to add 
        6 possible visualizations based on your data (CSV). Unlike the previous
        sections, plots are not reactive (do not react to changes). Instead,
        you need to click the button below 'update plot data' in order to see
        the results. Only valid data are processed. Feedback is returned to the user
        once the process is completed.

      </p>
      ")
    ),

    div(class = "my-4 text-black mx-3",
      div(
        class = "fs-4 my-2",
        "From now on"
      ),
      HTML(
        "
        <div class='mb-4'>
          <p>
            The application is simple: the aim is to plot ideograms and add visualizations to it. 
            The full code is available online. Feel free to try the app or to modify the code in order
            to expand functionalities.
          </p>
          <p>
            Also, 'Examples' section gives you some instructions to plot predefined
            representations with the sample data given with the code.
          </p>
        </div>

        "
        )
    )

  )
}


#' @export
server <- function(id) {}
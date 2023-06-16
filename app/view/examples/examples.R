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
    div(class = "text-center fs-2 text-black fw-bold","Example gallery"),

    div(class = "text-center fs-4",
        HTML("Some tips based on sample data")),

    # Section
    div(class = "my-4 text-black mx-3",
      div(
        class = "my-5 mx-3",
        HTML("This section shows some example cases that can be reproduced. 
        All the data used can be found on project 
        <a href = 'https://github.com/mcocam/shiny_karyoploter/tree/master/sample_data' target = '_blank'>sample_data<a> 
        folder. For every available genome, a set of data has been generated. Mix theme as you please.")
      ),
      HTML("
      
      ")
    ),

    div( class = "my-4 text-black mx-3",
      div(
        class = "fs-4 my-2",
        "Manhattan plot with hg38 genome (Homo Sapiens)"
      ),
      div(
        class = "img-fluid",
        HTML(
            "<img src = 'https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/samples/hg38_bars_points_coverage_markers.png?raw=true''></img>"
        )
      ),
      HTML("
      
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
          <img style = 'width: 20rem' class = 'rounded mt-1 mb-3 mx-5' src = 'https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/karyoploter_1.png?raw=true'></img>
          <li>Markers</li>
          <img style = 'width: 20rem' class = 'rounded  mt-1 mb-3 mx-5' src = 'https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/karyoploter_2.png?raw=true'></img>
          <li>Plots</p>
          <img style = 'width: 30rem' class = 'rounded  mt-1 mb-3 mx-5' src = 'https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/karyoploter_3.png?raw=true'></img>
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
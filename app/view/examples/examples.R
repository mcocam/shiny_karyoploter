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
            "<img style = 'width: 80vw' src = 'https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/samples/hg38_manhattan.png?raw=true''></img>"
        )
      ),
      HTML("
        The plot is based on hg38_markers.csv and hg38_manhattan.csv: 
        <ul>
            <li>Choose genome type Human (hg38)</li>
            <li>Select plot type 3) Horizontal ideogram (multiple panel)</li>
            <li>Upload the marker CSV data and select lower section as placement</li>
            <li>On 'Add plot section', insert a new panel (+) choose Manhattan type, 
            upload the data and click on 'Update plot data' below</li>
        </ul>
      ")
    ),

    div( class = "my-4 text-black mx-3",
      div(
        class = "fs-4 my-2",
        "Mix plot with bars, points, coverage and markers (hg38 Homo Sapiens)"
      ),
      div(
        class = "img-fluid",
        HTML(
            "<img style = 'width: 80vw' src = 'https://github.com/mcocam/shiny_karyoploter/blob/master/app/static/img/samples/hg38_bars_points_coverage_markers.png?raw=true'></img>"
        )
      ),
      HTML("
        The plot is based on hg38_markers.csv and hg38_bars.csv, hg38_points.csv and hg38_coverage.csv: 
        <ul>
            <li>Choose genome type Human (hg38) and filter chromosomes (from 1 to 4)</li>
            <li>Select plot type 2) V. ideogram (1 p. above, 1 below)</li>
            <li>Upload the marker CSV data and select lower section as placement</li>
            <li>On 'Add plot section', insert a 3 new panels (+), choose the appropiate type and the related data and click on update plot button</li>
        </ul>
      ")
    )


  )
}


#' @export
server <- function(id) {}
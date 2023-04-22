
box::use(
    shiny[insertUI,removeUI,div,p,actionButton,icon,NS],
    bslib[card,card_body_fill]
)

#' @export
add_panel = function(id){

    div(
        id = id,
        class = "card my-3",
        div(
            class = "card-body",
            div(
                p("Inputs to customize plot. TODO")
            ),
            div(
                class="text-end mt-3",
                actionButton(inputId=id,label="Delete",icon=icon("trash"),style="background-color: red;color: white")
            )
        )
    )

}

#' @export 
remove_panel = function(id){

}
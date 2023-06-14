box::use(
    glue[glue],
    karyoploteR[
      plotKaryotype, 
      kpPlotMarkers,
      kpBars,
      autotrack,
      kpAxis,
      kpDataBackground,
      kpPoints,
      kpLines,
      kpPlotDensity,
      kpPlotHorizon,
      kpPlotCoverage,
      kpPlotManhattan
      ],
      app/logic/get_min_max_y[get_min_max_y]
)


#' @export 
make_plot_code = function(karyo_params, marker_data, plot_data){

    plot_catalogue = c(
        "plot_bar" = "kpBars",
        "plot_coverage" = "kpPlotCoverage",
        "plot_density" = "kpPlotDensity",
        "plot_lines" = "kpLines",
        "plot_manhattan" = "kpPlotManhattan",
        "plot_points" = "kpPoints"
    )

    karyo_params_v = karyo_params()
    marker_data_v = marker_data()
    plot_data_v = plot_data()

    ## Panels
    plot_data_str = ""
    if(!is.null(plot_data_v)){

        plot_type = ""

        total_tracks_up = 0
        total_tracks_down = 0

        # Initialize track 
            track_up = data.frame(
                r0 = NULL,
                r1 = NULL
            )
            track_down = data.frame(
                r0 = NULL,
                r1 = NULL
            )

            for(index in seq_along(plot_data_v)){
              track = plot_data_v[[index]]

              if(track$placement == 1){
                total_tracks_up = total_tracks_up + 1
              }else{
                total_tracks_down = total_tracks_down + 1
              }
            }

            total_tracks = total_tracks_up + total_tracks_down

            current_track_up = 1
            current_track_down = 1

        for(i in total_tracks:1){


              panel = plot_data_v[[i]]

              type  = panel$type
              data  = as.data.frame(panel$data)
              chrs  = unique(data$chr)
              placement = panel$placement

              margin = 0 
              if(placement == 1){

                if (total_tracks_up > 0){
                  margin = 0.2
                }

                track = autotrack(
                  current.track = current_track_up,
                  total.tracks = total_tracks_up,
                  margin = margin)

                current_track_up = current_track_up + 1 
              }else{

                if (total_tracks_down > 0){
                  margin = 0.2
                }

                track = autotrack(
                  current.track = current_track_down,
                  total.tracks = total_tracks_down,
                  margin = margin)

                current_track_down = current_track_down + 1 

              }

                global_min_max = get_min_max_y(data)
                y_min = global_min_max[1]
                y_max = global_min_max[2]


            data_object = glue("csv_data_{i}")

            plot_data_str = glue("{plot_data_str}
            ### Panel {i} ###
            ### Type: {gsub('plot_','',type)}###
            {data_object} = user_data_{i} # Replace it with your dataframe or read CSV handler
            ")

            func = plot_catalogue[[panel$type]]

            data_panel = unique(panel$placement)
            r0 = track$r0 
            r1 = track$r1

            switch(
                panel$type,
                "plot_bar" = {
                    plot_data_str = glue("
                    {plot_data_str}

                    chrs = unique({data_object}$chr)

                    for (chr in chrs){{
                      filtered_data = {data_object}[{data_object}$chr == chr,]
                        kpBars(
                          kp,
                          chr = chr, 
                          data.panel = {data_panel},
                          x0 = filtered_data$x0,
                          x1 = filtered_data$x1,
                          y1 = filtered_data$y1,
                          r0 = {r0},
                          r1 = {r1},
                          ymax = {y_max})
                      }}
                    ")
                },
                "plot_coverage" = {
                  plot_data_str = glue("
                    {plot_data_str}
                      kpPlotCoverage(
                        kp,
                        data = makeGRangesFromDataFrame({data_object}),
                        data.panel = {placement},
                        r0 = {r0},
                        r1 = {r1}
                    )
                    ")
                },
                "plot_density" = {
                  plot_data_str = glue("
                    {plot_data_str}
                    kpPlotDensity(
                      kp,
                      data = makeGRangesFromDataFrame({data_object}),
                      data.panel = {placement},
                      r0 = {r0},
                      r1 = {r1}
                    )
                    
                    ")
                },
                "plot_lines" = {

                  plot_data_str = glue("
                    {plot_data_str}
                    chrs = unique({data_object}$chr)

                    for (chr in chrs){{
                      filtered_data = {data_object}[{data_object}$chr == chr,]
                      kpLines(
                        kp,
                        chr = chr,
                        data.panel = placement,
                        x = filtered_data$x,
                        y = filtered_data$y,
                        r0 = {r0},
                        r1 = {r1},
                        ymax = {y_max},
                        ymin = {y_min}
                    )
                    }}
                    ")
                },
                "plot_manhattan" = {
                  plot_data_str = glue("
                    {plot_data_str}
                    kpPlotManhattan(
                      kp,
                      data = makeGRangesFromDataFrame({data_object}, keep.extra.columns = TRUE),
                      data.panel = {placement},
                      r0 = {r0},
                      r1 = {r1}
                    )
                    ")
                },
                "plot_points" = {

                  plot_data_str = glue("
                    {plot_data_str}
                    chrs = unique({data_object}$chr)

                    for (chr in chrs){{
                      filtered_data = {data_object}[{data_object}$chr == chr,]
                      kpPoints(
                        kp,
                        chr = chr,
                        data.panel = {placement},
                        x = filtered_data$x,
                        y = filtered_data$y,
                        r0 = {r0},
                        r1 = {r1},
                        ymax = {y_max},
                        ymin = {y_min}
                    )
                    }}
                    ")
                }
            )
        }
    }

    arguments_code_string = ""
    for (param_name in names(karyo_params_v)){

        argument_name = param_name
        argument_values = karyo_params_v[[argument_name]]

        if(length(argument_values)>1){
            argument_values = paste0("c(",paste0("'",argument_values, collapse="', "), "')")
            argument_value_string = glue("{argument_name} = {argument_values}")
        }else{
            argument_value_string = glue("{argument_name} = '{argument_values}'")
            if(argument_name == "labels.plotter"){
              argument_value_string = "labels.plotter = NULL"
            }
        }

        arguments_code_string = paste0(arguments_code_string,argument_value_string,sep=", ")
    }

    arguments_code_string = substr(arguments_code_string, 1, nchar(arguments_code_string) - 2)


    # Set variables
    ## Markers 
    marker_data_str = ""
    if(!is.null(marker_data_v)){

      data_panel_position = unique(marker_data_v$position)

        if (karyo_params_v[["plot.type"]] %in% c("3", "4", "5")){

           marker_data_str = glue("
          marker_data = your_marker_data #Replace it with your data or reader function

          kpPlotMarkers(
                  kp,
                  chr=marker_data$chr,
                  x=marker_data$x,
                  labels=marker_data$labels,
                  text.orientation = 'horizontal',
                  data.panel = {data_panel_position})
          ")

        }else{

          marker_data_str = glue("
            marker_data = your_marker_data #Replace it with your data or reader function

            kpPlotMarkers(
                    kp,
                    chr=marker_data$chr,
                    x=marker_data$x,
                    labels=marker_data$labels,
                    data.panel = {data_panel_position})
          ")

        }

       
    }



    code = glue("
    # Code generator
    ## Please note that the user-entered data cannot be fully replicated

    # Plot code (ideogram)
    kp = plotKaryotype({arguments_code_string})

    # Plots if any
    ## Please note that the order of panels (left sidebar) 
    ## is from bottom to top. Hence, last panel becomes 1 and the first n
    {plot_data_str}

    # Markers if any
    {marker_data_str}
    
    ")



    return(code)

}
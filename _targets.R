# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)

# Set target options:
tar_option_set(
  # Packages that your targets need for their tasks.
  packages = c("tibble", "dplyr", "ggplot2", "readr", "tidyr",
               "yaml", "reticulate"), 
  format = "qs", # Optionally set the default storage format. qs is fast.
)

# Global settings

config_file_name <- "triangulate-config.yml";

# Run the R scripts in the R/ folder with your custom functions:
tar_source()

# Replace the target list below with your own:
tar_plan(
  tar_file_read(config, config_file_name,
               read_config_file(!!.x)),

  calibration_video_names =
    with(config, 
         add_base_path(calibration_videos, base_path)),
  
  tar_files(calibration_video_files, calibration_video_names)
)
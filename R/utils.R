library(cli)
library(assertthat)

add_base_path <- function(fns, bp)
{
  for (i in seq_along(fns)) {
    fns[[i]] <- file.path(bp, fns[[i]])
  }
  fns
}

check_config_file <- function(config_file_name)
{
  cli::cli_alert_info("Thingy!")
  
  TRUE
}

read_config_file <- function(config_file_name)
{
  cli_alert_info("Checking config file {config_file_name}")
  
  if (file.exists(config_file_name))
    cli_alert_success("Config file found")
  else
    cli_alert_danger("Config file not found!")
  
  config <- yaml::read_yaml(config_file_name)
  
  with(config, {
    if (file.exists(base_path))
      cli_alert_success("Successfully accessed base path: {base_path}")
    else
      cli_alert_danger("Cannot access base path: {base_path}")
    
    cli_alert_info("Checking calibration files...")
    for (i in seq_along(calibration_videos)) {
      fn <- file.path(base_path, calibration_videos[[i]])
      if (file.exists(fn))
        cli_alert_success("Found calibration video: {fn}")
      else
        cli_alert_danger("Cannot access calibration video: {fn}")
    }
    
    if (length(calibration_videos) == length(camera_names))
      cli_alert_success("Found {length(camera_names)} camera names for {length(calibration_videos)} calibration videos.")
    else
      cli_alert_danger("Number of camera names ({length(camera_names)}) does not match number of calibration videos ({length(calibration_videos)}).")
    
    cli_alert_info("Checking axes files...")
    for (i in seq_along(axes_files)) {
      fn <- file.path(base_path, axes_files[[i]])
      if (file.exists(fn))
        cli_alert_success("Found axes file: {fn}")
      else
        cli_alert_danger("Cannot access axes file: {fn}")
    }
    
    fn <- file.path(base_path, points_files_list)
    if (file.exists(fn))
      cli_alert_success("Found points files list: {fn}")
    else
      cli_alert_danger("Cannot access points files list: {fn}")
    
  })
  
  config
}

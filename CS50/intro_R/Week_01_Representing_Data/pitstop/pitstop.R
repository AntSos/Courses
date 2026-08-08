# CS50 Pit Stop.

# Prompt the user to enter a CSV file to analyze.
user_input <- readline(prompt = "Enter the path to your CSV file: ")

# Check if user_data is a .csv file.
if (tolower(tools::file_ext(user_input)) == "csv") {
  message("Valid CSV file selected!")
  # Read users data.
  user_data <- read.csv(user_input)
} else {
  stop("Invalid file type! Please select a .csv file.")
}

# Required columns.
r_columns <- c("team", "driver", "time", "lap")
# Check if r_columns are in user_data.
all_columns <- all(r_columns %in% names(user_data))
# Print message result.
if (all_columns) {
  cat("Success: All required columns are present!\n")
} else {
  cat("Error: Missing one or more required columns.\n")
}
# The total number of pit stops, using length() function.
t_n_pitstops <- paste("Number of pit stops", length(user_data$team))
# The duration of the shortest pit stop, using min() function.
min_time_val <- paste("Shortest pit stop", min(user_data$time))
# The duration of the longest pit stop, using max() function.
max_time_val <- paste("Longest pit stop", max(user_data$time))
# The total time spent on pit stops during the race, across all racers, using function sum(.)
t_time_racer <- paste("Total time spent on pit stops during the race", sum(user_data$time))
# Print values.
print(t_n_pitstops)
print(min_time_val)
print(max_time_val)
print(t_time_racer)





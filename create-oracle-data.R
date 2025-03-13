target_data <- read.csv("https://raw.githubusercontent.com/cdcepi/FluSight-forecast-hub/refs/heads/main/target-data/target-hospital-admissions.csv")

# keep selected columns
oracle_output <- target_data[c("date", "location", "value")]
colnames(oracle_output) <- c("target_end_date", "location", "oracle_value")

write.csv(oracle_output, "oracle-output.csv", row.names = FALSE)

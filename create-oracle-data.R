target_data <- read.csv("https://raw.githubusercontent.com/cdcepi/FluSight-forecast-hub/refs/heads/main/target-data/target-hospital-admissions.csv")

# keep selected columns
oracle_output <- target_data[c("date", "location", "value")]
colnames(oracle_output) <- c("target_end_date", "location", "oracle_value")

# drop US
oracle_output <- oracle_output[oracle_output$location != "US", ]

# cross-join with horizon. This is a hack to drop evaluations at horizon -1
oracle_output <- merge(oracle_output, data.frame(horizon = 0:3))

write.csv(oracle_output, "oracle-output.csv", row.names = FALSE)

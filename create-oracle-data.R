target_data <- read.csv("https://raw.githubusercontent.com/cdcepi/FluSight-forecast-hub/refs/heads/main/target-data/target-hospital-admissions.csv")

# keep selected columns
oracle_output <- target_data[c("date", "location", "value")]
colnames(oracle_output) <- c("target_end_date", "location", "oracle_value")

# drop US
# This should be done as part of a specification of an evaluation set
# once predevals issue #8 is resolved
oracle_output <- oracle_output[oracle_output$location != "US", ]

# cross-join with horizon. This is a hack to drop evaluations at horizon -1
# This should be done as part of a specification of an evaluation set
# once predevals issue #8 is resolved
oracle_output <- merge(oracle_output, data.frame(horizon = 0:3))

# drop reference_date 2025-01-25
# reference_date is (7 days) * horizon days before the target_end_date
# Data were not publicly released that week and the FluSight team
# did not produce baseline forecasts.
# This should be done as part of a specification of an evaluation set
# once predevals issue #8 is resolved
oracle_output$reference_date <- as.Date(oracle_output$target_end_date) - oracle_output$horizon * 7L
oracle_output <- oracle_output[oracle_output$reference_date != "2025-01-25", ]

write.csv(oracle_output, "oracle-output.csv", row.names = FALSE)

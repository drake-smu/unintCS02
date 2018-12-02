library(readxl);
library(tidyverse);


# Load Data ---------------------------------------------------------------
# Create target file
hr_data_file <- file("data/hr-data.rds");
hr_definitions_file <- file("data/hr-definitions.rds");
#' Read first sheet excel document into R
hr_data <- read_excel("data/raw-client-data.xlsx");
hr_definitions <- read_excel("data/raw-client-data.xlsx", sheet = 2, col_names = F, trim_ws = T);



# Save objects
saveRDS(hr_data, hr_data_file);
saveRDS(hr_definitions, hr_definitions_file)


# close files -------------------------------------------------------------
close(hr_definitions_file,hr_data_file);

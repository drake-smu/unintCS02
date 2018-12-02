library(readxl);
library(tidyverse);

hr_data <- readRDS("data/hr-data.rds");
pairs(hr_data)

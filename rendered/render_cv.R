# This script builds both the HTML and PDF versions of your CV

# If you want to speed up rendering for googlesheets driven CVs you can cache a
# version of your data This avoids having to fetch from google sheets twice and
# will speed up rendering. It will also make things nicer if you have a
# non-public sheet and want to take care of the authentication in an interactive
# mode.
# To use, simply uncomment the following lines and run them once.
# If you need to update your data delete the "ddcv_cache.rds" file and re-run

library(tidyverse)


cache_data <- TRUE

### HTML ####

# Knit the HTML version
rmarkdown::render(here::here("resume.rmd"),
                  params = list(pdf_mode = FALSE, cache_data = cache_data),
                  output_file = "rendered/resume.html")

### PDF - Data Science  ####

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render(here::here("resume.rmd"),
                  params = list(pdf_mode = TRUE, cache_data = cache_data),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = paste0("rendered/kerr_resume_", Sys.Date(), ".pdf"),
                       wait = 20)


### PDF - Biostatistician ###

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render(here::here("R", "resume_biostats.rmd"),
                  params = list(pdf_mode = TRUE, cache_data = cache_data),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "kerr_resume_biostats.pdf", wait = 20)




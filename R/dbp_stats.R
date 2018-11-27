library(tidyverse)


names <- str_c("2018-11-", c(parse_character(seq(16,20)),"16_20"))

# read_delim_dbp <- function(file){
#     read_delim(file, delim = ";") %>% 
#         mutate(TINT = parse_character(TINT))
# }
# 
# lens <- map(files, read_delim_dbp) %>% 
#     bind_rows() 
# 
# lens %>% 
#     write_delim("data/2018-11-16_20.csv", delim = ";")

render_doc <- function(name){
    rmarkdown::render(
        "R/dbp_stats.Rmd", 
        params = list(name = name),
        output_file = str_c(name, ".html"))
}

map(names, render_doc)

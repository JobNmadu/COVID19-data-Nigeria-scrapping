library(rvest)
#library(stringr)
#library(xml2)
#library(jsonlite)

url <- "https://covid19.ncdc.gov.ng/report/"

COVID19 <- url %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="custom1"]') %>%    #get the xpath by right-clicking on the website
  html_table()

COVID19 <- COVID19[[1]]

xlsx::write.xlsx2(COVID19, file = "Daily/Daily160920.xlsx",
                  col.names = TRUE, row.names = FALSE)

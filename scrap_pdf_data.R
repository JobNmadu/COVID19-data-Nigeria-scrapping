
library(pdftools)
library(tidyverse)
text <- pdf_text("PDF/An update of COVID-19 outbreak in Nigeria_030920_36.pdf") %>% #the PDF file is downloaded into a drive and then the data is scrapped
  readr::read_lines()
text   # displaing the text will give the relevant lines where the data appears which is saved as DATA
Data <- as.data.frame(text[48:92])
write_delim(Data, "XLSX/030920.csv", delim = " ")

KK <- data.frame(read_delim("XLSX/020920.csv", delim = " ",
                            skip = 1, skip_empty_rows = TRUE,
                            trim_ws = TRUE, col_names = FALSE))

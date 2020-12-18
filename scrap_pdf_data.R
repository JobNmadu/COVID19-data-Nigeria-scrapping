
library(pdftools)
library(tidyverse)
text <- pdf_text("PDF/An update of COVID-19 outbreak in Nigeria_030920_36.pdf") %>%
  readr::read_lines()
text
Data <- as.data.frame(text[48:92])
write_delim(Data, "XLSX/030920.csv", delim = " ")

KK <- data.frame(read_delim("XLSX/020920.csv", delim = " ",
                            skip = 1, skip_empty_rows = TRUE,
                            trim_ws = TRUE, col_names = FALSE))

library(splitstackshape)
cSplit(KK, c("CONFIRMED CASES          DISCHARGED CASES                  DEATHS                              DAYS SINCE", "TOTAL" ,"LAST", "STATES                                                                                             ACTIVE")
, sep = " ")

#xlsx::write.xlsx2(DData, file = "DATA2902.xlsx")
#readr::write_csv2(Data, "DATA3108.csv")


library(xml2)
library(rvest)

website <- read.csv("indeed_pfizer.txt", header = F, stringsAsFactors = F)

all_web <- c(1:204)
for(i in 1:21){
  web <- read_html(website[i,1])
  position <- web %>% 
    html_nodes("h2.jobtitle") %>% 
    html_nodes("a") %>% 
    html_attrs()
  for(j in 1:length(position)) {
    all_web[(i-1)*10+j] <- paste0("https://www.indeed.com",position[[j]][2])
  }
}

jobdescripe <- c(1:194)
for(i in 1:194){
  web <- read_html(all_web[i])
  position1 <- web %>% 
    html_nodes("span.summary") %>%
    html_text()
  jobdescripe[i] <- position1
}

Data_expert <- c(1:194)
for(i in 1:194) {
  Data_expert1 <- str_detect(jobdescripe[i], c("[Da]ata", "[Aa]naly", "[Ss]cientist"))
  Data_expert[i] <- Data_expert1[1]|Data_expert1[2]|Data_expert1[3]                           
}

table(Data_expert)

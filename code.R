library(data.table)
library(XML)

# load the data
books <- fread(input = './data/books-input.csv', header = F, sep = ';', stringsAsFactors = F)

# subset to our fields of interest
books <- books[, 1:5, with = F]

# generate some (plausible) prices
# mean=30, sd=5.8 + a random choice of (0.5, 0.9, 0.99) 
# so we obtain prices like 15.99, 24.5, 49.9 and so on..
price <- (round(rnorm(nrow(books),mean = 30, 5.8), digits = 0) + sample(c(0.50,0.90,0.99),size = nrow(books), replace=T))

# add the new column
books$price <- price

# add the id column as autoinc
books$id <- seq(1, nrow(books))

# set column names
setnames(books,1:7,c('isin', 'title', 'author', 'year', 'publisher', 'price', 'id'))

# convert the year field to numeric
books$year <- as.numeric(books$year)

write.table(x=books,file = "albabooks.csv",append = F,sep = ',', row.names = F,quote = F)

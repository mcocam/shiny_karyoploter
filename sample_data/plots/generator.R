library(data.table)

x0 <- 1:23*10e6
x1 <- 2:24*10e6
y1 <- rnorm(23, mean=0.6, sd=0.1)

data_bars_1 = data.frame(
  chr = "chr1",
  x0 = x0,
  x1 = x1,
  y = y1
)

fwrite(data_bars_1, "chr1_bars.csv", sep = ";")

x0 <- 1:23*10e6
x1 <- 2:24*10e6
y1 <- rnorm(23, mean=1, sd=0.6)

data_bars_2 = data.frame(
  chr = "chr3",
  x0 = x0,
  x1 = x1,
  y = y1
)

fwrite(data_bars_2, "chr3_bars.csv", sep = ";")


data_bars_full = rbind(
  data_bars_1,
  data_bars_2
)

fwrite(data_bars_full, "chr1_chr3_bars.csv", sep=";")


###############


x <- 1:23*10e6
y <- rnorm(23, mean=0.5, sd=0.25)

data_lines = data.frame(
  chr = "chr1",
  x = x,
  y = y
)

fwrite(data_lines, "chr1_lines.csv", sep = ";")




###########

expected_columns = c("chr", "x0", "x1", "y1")
expected_types = c("character", "numeric", "numeric", "numeric")
observed_types = sapply(data_bars, class)

are_variables_valid = all(colnames(data_bars) == expected_columns)
are_types_valid = all(observed_types == expected_types)



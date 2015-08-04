# read GC count from a file
count_path <- "/Users/wlxiong/Projects/fasta-data-practice/GC-count.txt"
count <- read.table(count_path, col.names=c("GC"))
# plot histogram of GC count
hist(count$GC, prob=T, breaks=100)
# plot probability density curve
lines(density(count$GC), col='red')

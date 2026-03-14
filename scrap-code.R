
install.packages("remotes")
install.packages("tidygeocoder")
remotes::install_github("tylermorganwall/rayshader")
library(rayshader)
library(ggplot2)
library(tidyverse)
library(tidygeocoder)

library(libry)

install.packages("libr")

install.packages("Rlinkedin")



library(RedditExtractoR)




getwd()

getwd()

## pulling Pennsylvania data


pgh_r_thread <- find_thread_urls(subreddit = "pittsburgh", sort_by = "new", period = "all")
pgh_r_thread_comments <- get_thread_content(pgh_r_thread$url)

pgh_r_thread_comment_text <- pgh_r_thread_comments$comments
pgh_r_thread_text <- pgh_r_thread_comments$threads

write_csv(pgh_r_thread_comment_text,"data/reddit_pittsburgh_comments_2025-0505_2025-0521.csv")
write_csv(pgh_r_thread_text,"data/reddit_pittsburgh_theads_2025-0505_2025-0521.csv")





pa_r_thread <- find_thread_urls(subreddit="Pennsylvania", sort_by = "new", period = "all")
pa_r_thread_comments <- get_thread_content(pa_r_thread$url)

head(pa_r_thread)


pa_r_thread_comment_text <- pa_r_thread_comments$comments
pa_r_thread_text <- pa_r_thread_comments$threads

write_csv(pa_r_thread_comment_text,"data/reddit_pennsylvania_comments_2025-0504_2025-0520.csv")
write_csv(pa_r_thread_text,"data/reddit_pennsylvania_theads_2025-0504_2025-0520.csv")



getwd()


# library(RedditExtractoR)
# library(tidyverse)
# library(tidytext)
# library(sf)
# library(stringr)
# library(spacyr)
# library(purrr)
# library(igraph)
# library(tidygraph)
# library(ggraph)
# library(sf)


## set up packages object for bulk for loading and installation (adapted from Text Analysis lesson)
packages <- c("tidyverse", "tidytext", "SnowballC", "tidyr", "ggplot2", 
              "stringr", "topicmodels", "reshape2", "stm", "RedditExtractoR",
              "spacyr", "igraph", "tidygraph", "ggraph", "purrr", "sf")
installed <- packages %in% installed.packages()
if (any(!installed)) install.packages(packages[!installed])

# Load all packages
lapply(packages, library, character.only = TRUE)

# spacy nees its own install (not sure why)
spacy_install()
spacy_initialize()
spacy_initialize(model = "en_core_web_sm")

# setting working directory
getwd()
setwd("/Users/ian/Google Drive/CUNY GC/Classes/2025 Summer/SICSS-CMU/group-project")
getwd()

##### bloc of script to scrape reddit data... should use to update at end of project
# pgh_r_thread <- find_thread_urls(subreddit = "pittsburgh", sort_by = "new", period = "all")
# pgh_r_thread_comments <- get_thread_content(pgh_r_thread$url)
# 
# pgh_r_thread_comment_text <- pgh_r_thread_comments$comments
# pgh_r_thread_text <- pgh_r_thread_comments$threads

# write_csv(pgh_r_thread_comment_text,"data-big/reddit_pittsburgh_comments_2025-0504_2025-0520.csv")
# write_csv(pgh_r_thread_text,"data-big/reddit_pittsburgh_theads_2025-0504_2025-0520.csv")

pgh_r_thread_comment_text <- read_csv("data/reddit_pittsburgh_comments_2025-0504_2025-0520.csv")

pgh_r_thread_text <- read_csv("data/reddit_pittsburgh_theads_2025-0504_2025-0520.csv")

#load and inspect corpus (assembled outside of this script)
pgh_reddit_corpus <- read_csv("data/pgh_reddit_corpus_2025-0504_2025-0520.csv")
glimpse(pgh_reddit_corpus)
head(pgh_reddit_corpus)

#load Pittsburghese dictionary
pittsburghese <- read_csv("data/pittsburghese_dictionary.csv")

pittsburghese


## tokenize

pgh_r_comment_text(line = 1, text = sampleText) %>%
  unnest_tokens(word, text)
#unnest_tokens(character, text, token = "characters")
#unnest_tokens(sentence, text, token = "sentences")
#unnest_tokens(bigram, text, token = "ngrams", n = 2)
#unnest_tokens(trigram, text, token = "ngrams", n = 3)


### making tokens
comment_tokens <- phgh_reddit_text %>%
  mutate(text = comment) %>% ### select comment variable
  mutate(text = str_to_lower(text)) %>% ### make lowercase
  mutate(text = str_remove_all(text, "http\\S+")) %>% ### URLs
  mutate(text = str_remove_all(text, "\\b[a-zA-Z{1,2\\d+\\b")) ## standalone numbers
  mutate(text = str_remove_all())

unnest_tokens(pgh_reddit_corpus(line = 1, text = text), bigram, text, token = "ngrams", n = 2)


## Later on... mapping
# load geometry for Pittsburgh
neighborhoods_file <- "https://data.wprdc.org/dataset/e672f13d-71c4-4a66-8f38-710e75ed80a4/resource/4af8e160-57e9-4ebf-a501-76ca1b42fc99/download/neighborhoods.geojson"


## sf - read simple features
hoods_sf <- read_sf(neighborhoods_file)

# making a plot neighborhood shape file
ggplot() +
  geom_sf(data = hoods_sf) +
  theme_void()


## not sure what this does... making neighborhood variable
pgh_nbhd <- hoods_sf %>%
  st_drop_geometry() %>%
  mutate(hood = str_to_lower(hood)) %>%
  pull(hood)

pgh_nghd_filter <- paste(pgh_nbhd, collapse = "|")

# forcing lower-case in all text
pgh_reddit <- pgh_r_thread_comment_text %>%
  mutate(comment = str_to_lower(comment))

pgh_reddit_nbhd <- pgh_reddit %>%
  filter(str_detect(comment,pgh_nghd_filter))


# Extract sentences and keep the neighborhood name
tidy_sentences <- pgh_reddit_nbhd %>%
  mutate(hood = str_extract(comment, pgh_nghd_filter)) %>%  # Extract the neighborhood name
  unnest_tokens(sentence, comment, token = "sentences") %>%
  mutate(sentence_id = as.character(row_number())) %>%
  mutate(id_match = paste0("text",sentence_id)) # Create a unique ID for each sentence and convert it to character

# Parse sentences with spacyr
parsed_sentences <- spacy_parse(tidy_sentences$sentence, tag = TRUE)

# Combine the parsed data with the original sentences
adj_tags <- parsed_sentences %>%
  filter(pos == "ADJ") %>%
  left_join(tidy_sentences, by = c("doc_id" = "id_match")) %>%
  select(hood, sentence, lemma)  # Keep the neighborhood name, original sentence, and the lemma (adjective)

# Now you can use this data to create a graph mapping adjectives to neighborhoods
adjacency_matrix <- adj_tags %>%
  group_by(hood, lemma) %>%
  summarise(weight = n(), .groups = 'drop')

# Convert your data to a tidygraph object
g <- tbl_graph(edges = adjacency_matrix, directed = FALSE) %>%
  activate(nodes) %>%
  mutate(node_type = ifelse(name %in% unique(adjacency_matrix$hood), "hood", "adjective"))

# Calculate the weighted degree (sum of weights for each node)
g <- g %>%
  mutate(weighted_degree = centrality_degree(weights = weight)) %>%
  activate(edges) %>%
  mutate(edge_width = weight)  # Use the weight as edge width

g

# Visualize the graph with ggraph
ggraph(g %>% activate(nodes) %>% filter(weighted_degree > 1), layout = "fr") +  # Fruchterman-Reingold layout
  geom_edge_link(aes(width = edge_width), color = "gray", alpha = 0.8) +  # Edges with width based on weight and gray color
  geom_node_point(aes(size = weighted_degree, color = node_type), alpha = 0.9) +  # Nodes with size based on weighted degree and color by type
  # Customize the text for neighborhoods and adjectives, prioritize higher degree nodes
  geom_node_text(aes(label = ifelse(weighted_degree > quantile(weighted_degree, 0.5),  # Show label if degree is in the top 50%
                                    ifelse(node_type == "hood", toupper(name), name), NA),  # Convert to uppercase for neighborhoods
                     size = ifelse(weighted_degree > quantile(weighted_degree, 0.5),  # Scale label size based on degree
                                   ifelse(node_type == "hood", 5, 2), 0),  # Bigger size for neighborhoods, smaller for adjectives
                     color = ifelse(weighted_degree > quantile(weighted_degree, 0.5),  # Color labels accordingly
                                    ifelse(node_type == "hood", "black", "darkgray"), NA)), 
                 repel = TRUE) +  # Use repel to avoid text overlap
  scale_edge_width(range = c(0.5, 5)) +  # Scale for edge width
  scale_size(range = c(3, 15)) +  # Scale for node size
  theme_void() +  # Clean theme without axis or grid lines
  theme(legend.position = "none")  # Remove the legend if not needed

# Convert to an affiliation matrix using pivot_wider
affiliation_matrix <- adjacency_matrix %>%
  pivot_wider(names_from = lemma,  # Columns are adjectives (lemmas)
              values_from = weight,  # Values are the weights
              values_fill = 0)  # Fill missing values with 0

# Convert the affiliation matrix to long format
affiliation_long <- affiliation_matrix %>%
  pivot_longer(cols = -hood,  # All columns except 'hood' are adjectives
               names_to = "lemma", 
               values_to = "weight") %>%
  filter(weight > 0)  # Remove entries with zero weight

affiliation_long_trim <- affiliation_long %>%
  filter(weight > 1)

# Create a graph from the long format data with an explicit type attribute
g_aff <- tbl_graph(edges = affiliation_long, directed = FALSE) %>%
  activate(nodes) %>%
  mutate(type = ifelse(name %in% affiliation_matrix$hood, TRUE, FALSE),  # TRUE for neighborhoods, FALSE for adjectives
         node_type = ifelse(type, "hood", "adjective")) %>%
  activate(edges) %>%
  mutate(edge_width = weight)  # Assign the weight as the edge width

g_aff

# Calculate the weighted degree (sum of weights for each node)
g_aff <- g_aff %>%
  activate(nodes) %>%
  mutate(weighted_degree = centrality_degree(weights = E(g)$weight))

g_aff_trim <- g_aff %>%
  filter(weighted_degree > 1)

g_aff_trim

# Visualize the graph with ggraph
## note - need to fix this error
### Warning message:
## ggrepel: 148 unlabeled data points (too many overlaps). Consider increasing max.overlaps 
ggraph(g_aff_trim, layout = "bipartite", types = V(g)$type) +  # Use the type attribute to distinguish the two sets
  geom_edge_link(aes(width = edge_width), color = "gray", alpha = 0.8) +  # Edges with width based on weight and gray color
  geom_node_point(aes(size = weighted_degree, color = node_type), alpha = 0.9) +  # Nodes with size based on weighted degree and color by type
  geom_node_text(aes(label = ifelse(node_type == "hood", toupper(name), name),  # Uppercase for neighborhoods
                     size = ifelse(node_type == "hood", 5, 2),  # Larger text for neighborhoods
                     color = ifelse(node_type == "hood", "black", "darkgray")),  # Color: black for neighborhoods, dark gray for adjectives
                 repel = TRUE) +  # Use repel to avoid text overlap
  scale_edge_width(range = c(0.5, 5)) +  # Scale for edge width
  scale_size(range = c(3, 15)) +  # Scale for node size
  theme_void() +  # Clean theme without axis or grid lines
  theme(legend.position = "none")  # Remove the legend if not needed

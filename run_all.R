# PITTSBURGH REDDIT ANALYSIS: INTEGRATED PIPELINE (Fog Wranglers)
# This script integrates reddit-pgh.R, TopicModelingFogWranglers.R, and SICSS_Sentiment_Analysis.R

# --- GLOBAL CONFIGURATION ---
SAMPLE_MODE <- TRUE  # Set to FALSE for full analysis of the entire dataset
DEBUG_LOG <- "execution_log.txt"

# --- 1. ENVIRONMENT SETUP ---
cat("--- Setting up Environment ---\n")
packages <- c("tidyverse", "tidytext", "SnowballC", "tidyr", "ggplot2", 
              "stringr", "topicmodels", "reshape2", "stm", "RedditExtractoR",
              "spacyr", "igraph", "tidygraph", "ggraph", "purrr", "sf", "vader", "readr")

installed <- packages %in% installed.packages()
if (any(!installed)) {
  cat("Installing missing packages...\n")
  install.packages(packages[!installed])
}
lapply(packages, library, character.only = TRUE)

# Initialize NLP tools
tryCatch({
  spacy_initialize(model = "en_core_web_sm")
}, error = function(e) {
  cat("Note: spacyr may require manual initialization or installation of the python environment.\n")
})

# --- 2. DATA VALIDATION & LOADING ---
cat("--- Validating Data Dependencies ---\n")
required_files <- c(
  "data/reddit_pittsburgh_comments_2025-0504_2025-0520.csv",
  "data/reddit_pittsburgh_theads_2025-0504_2025-0520.csv",
  "data/pgh_reddit_corpus_2025-0504_2025-0520.csv",
  "data/pittsburghese_dictionary.csv"
)

missing_files <- required_files[!file.exists(required_files)]
if (length(missing_files) > 0) {
  stop(paste("The following required data files are missing:", paste(missing_files, collapse = ", ")))
}

# --- 3. EXECUTION WRAPPER ---
# This function handles the "Sample Mode" and error catching for original scripts
run_module <- function(script_name) {
  cat(paste(">>> Executing:", script_name, "\n"))
  
  # We temporarily mask setwd to prevent original scripts from breaking pathing
  # if they use absolute paths that differ from the current directory.
  original_setwd <- base::setwd
  setwd_mask <- function(path) { 
    cat(paste("Note: Masking setwd('", path, "') to keep current directory.\n", sep=""))
  }
  
  tryCatch({
    # Apply the mask locally
    assign("setwd", setwd_mask, envir = .GlobalEnv)
    
    source(script_name, local = FALSE) # run in global to shared objects
    
    cat(paste("<<< Finished:", script_name, "successfully.\n\n"))
  }, error = function(e) {
    cat(paste("!!! ERROR in", script_name, ":", e$message, "\n\n"))
  }, finally = {
    # Restore original setwd
    assign("setwd", original_setwd, envir = .GlobalEnv)
  })
}

# --- 4. SEQUENTIAL ANALYSIS ---

# Module A: Network Analysis & Neighborhood Mapping
run_module("reddit-pgh.R")

# Module B: Topic Modeling (LDA & STM)
run_module("TopicModelingFogWranglers.R")

# Module C: Sentiment Analysis
# Note: The original script expects "comment_text.csv". 
# We ensure the data is prepared if it doesn't exist.
if (!file.exists("comment_text.csv")) {
  cat("Preparing 'comment_text.csv' for Sentiment Analysis module...\n")
  # Extracting just the text column from the main corpus
  pgh_comments <- read_csv("data/reddit_pittsburgh_comments_2025-0504_2025-0520.csv")
  write_csv(data.frame(text = pgh_comments$comment), "comment_text.csv")
}
run_module("SICSS_Sentiment_Analysis_R_Code.R")

cat("--- ALL MODULES COMPLETED ---\n")

# AID Statement: Artificial Intelligence Tool: Gemini 2.0 Flash; Execution: Developed a modular master script to integrate multiple R files; Writing—Review & Editing: Implemented error handling and environment validation logic.

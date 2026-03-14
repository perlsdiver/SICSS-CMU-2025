# Performing a "Yinzer" Dialect in Social Text: An Exploration of /r/Pittsburgh

This exploratory project analyzes the Pittsburgh subreddit using NLP, Network Analysis, and Topic Modeling, using roughgly two weeks of data scraped in May 2025.

It was created by the team **Fog Wranglers**, during the Summer Institute in Computational Social Science at Carnegie Mellon University ([SICSS-CMU](https://sicss.io/2025/cmu/)) in Pittsburgh, PA.

Our intent was to demonstrate computational social science skills learned during SICSS and situate our within our local and embodied experiences of Pittsburgh.

## Project Team
**SICSS-CMU 2025: Fog Wranglers**
- **Will Martin** - project conceptualization and ideation, scaping file, data source
- **Ian G. Williams** - project conceptualization and ideation, lexicon creation, project management, presentation slides and planning, code review
- **Kuheli Sai** - sentiment analysis
- **Hanh Phan** - topic modeling

## Project Components
1.  **Network Analysis & Adjective Mapping** (`reddit-pgh.R`): Extracts adjectives from Reddit comments to map descriptive terms to Pittsburgh neighborhoods.
2.  **Topic Modeling** (`TopicModelingFogWranglers.R`): Uses LDA and STM models to identify key themes in subreddit discussions.
3.  **Sentiment Analysis** (`SICSS_Sentiment_Analysis_R_Code.R`): Applies VADER sentiment scoring to understand the emotional tone of subreddit interactions.

## Data Sources

- [/r/Pittsburgh](https://www.reddit.com/r/pittsburgh/) threads and comments from 5/4/25-5/20/2025 (two week window)
- n = 8177 (266 threads; 7,911 comments)
- Largest thread contained 497 comments, and was topically about Pittsburgh

## How to Run the Integrated Pipeline
Use the `run_all.R` script to execute the entire analysis in one step. 
This script handles package installation, data loading, and environment setup without modifying the original scripts.

```r
source("run_all.R")
```

### Script Execution Order
- `reddit-pgh.R` (Preparation & Network Mapping)
- `TopicModelingFogWranglers.R` (Topic Discovery)
- `SICSS_Sentiment_Analysis_R_Code.R` (Sentiment Scoring)

## Data Requirements
Place all `.csv` and `.xlsx` files in the `data/` directory. 
*Note: Large data files are ignored by Git and should be managed locally.*

## Artificial Intelligence Disclosure (AID)
This project follows the **Artificial Intelligence Disclosure (AID) Framework** for documenting the use of AI tools in research and code development. 

*   **Link to Framework:** [AID Framework (ACRL News)](https://crln.acrl.org/index.php/crlnews/article/view/26548/34482)

For the project, Google Gemini CLI was used to integrate all code using the run_all.R file, create this directory, push it to Github in March 2026, and automaticaly write portions of this README file, which were then manually reviewed and edited by Ian Williams.

### Why Disclosure Matters
Transparency in the use of AI is essential for:
1.  **Academic Integrity:** Clearly documenting where AI assisted in code generation vs. where researchers provided the domain expertise.
2.  **Reproducibility:** Ensuring future researchers know exactly which versions of AI and software tools were used to produce the results.
3.  **Ethical Standards:** Upholding professional norms for transparency in collaborative computational social science.


All content other than portions of this README file were written by human authors during the Summer Institute in Compuational Social Science at Carnegie Mellon University (SICSS-CMU) in May 2025.

## Presentation Highlights
The complete presentation (20 slides) is available in the `slides/` directory.

### Title Slide
![Title Slide](slides/png/FOG-WRANGLERS-Presentation-Slides-5-23-2025_Page_01.png)

### Research Summary
![Insights](slides/png/FOG-WRANGLERS-Presentation-Slides-5-23-2025_Page_02.png)
![Methodology](slides/png/FOG-WRANGLERS-Presentation-Slides-5-23-2025_Page_03.png)

*(See `slides/png/` for all 20 slides)*

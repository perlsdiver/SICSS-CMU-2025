# Pittsburgh Reddit Analysis: Fog Wranglers Project

This project analyzes the Pittsburgh subreddit using NLP, Network Analysis, and Topic Modeling. 

## Artificial Intelligence Disclosure (AID)
This project follows the **Artificial Intelligence Disclosure (AID) Framework** for documenting the use of AI tools in research and code development. 

*   **Link to Framework:** [AID Framework (ACRL News)](https://crln.acrl.org/index.php/crlnews/article/view/26548/34482)

### Why Disclosure Matters
Transparency in the use of AI is essential for:
1.  **Academic Integrity:** Clearly documenting where AI assisted in code generation vs. where researchers provided the domain expertise.
2.  **Reproducibility:** Ensuring future researchers know exactly which versions of AI and software tools were used to produce the results.
3.  **Ethical Standards:** Upholding professional norms for transparency in collaborative computational social science.

## Project Components
1.  **Network Analysis & Adjective Mapping** (`reddit-pgh.R`): Extracts adjectives from Reddit comments to map descriptive terms to Pittsburgh neighborhoods.
2.  **Topic Modeling** (`TopicModelingFogWranglers.R`): Uses LDA and STM models to identify key themes in subreddit discussions.
3.  **Sentiment Analysis** (`SICSS_Sentiment_Analysis_R_Code.R`): Applies VADER sentiment scoring to understand the emotional tone of subreddit interactions.

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

## Project Team
**SICSS-CMU 2025: Fog Wranglers**
- **Will Martin**
- **Ian G. Williams**
- **Kuheli Sai**
- **Hanh Phan**

## Presentation Highlights
The complete presentation (20 slides) is available in the `slides/` directory.

### Title Slide
![Title Slide](slides/png/FOG-WRANGLERS-Presentation-Slides-5-23-2025_Page_01.png)

### Research Summary
![Insights](slides/png/FOG-WRANGLERS-Presentation-Slides-5-23-2025_Page_02.png)
![Methodology](slides/png/FOG-WRANGLERS-Presentation-Slides-5-23-2025_Page_03.png)

*(See `slides/png/` for all 20 slides)*

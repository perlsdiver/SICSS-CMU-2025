# Performing a "Yinzer" Dialect in Social Text: An Exploration of /r/Pittsburgh

This exploratory project analyzes the Pittsburgh subreddit using NLP, Network Analysis, and Topic Modeling, using data scraped between 5/4/25-5/20/2025. It was created over a week-long period in May 2025.

The project was created by the team **Fog Wranglers**, during the Summer Institute in Computational Social Science at Carnegie Mellon University [SICSS-CMU](https://sicss.io/2025/cmu/) in Pittsburgh, PA. In the first week, we went through training and courses in the foundations of computational social science. In the second week, we worked in teams, encouraged to think creatively, play with our new skills, and not be afraid of failure along the way. We took a voluntary pledge to use no AI coding assistants or tools during this time, so all materials were assembled by the team.

Our intent was to demonstrate [computational social science skills learned during SICSS](https://github.com/sicss-cmu/2025-materials), while situating the computational work within - and in dialogue with - our embodied experiences of Pittsburgh that existed outside of the data frame.

As a diverse team of mixed technical, conceptual, and skill backgrounds, we conceptualized a project that could draw from our strengths and areas of expertise, and divided up work based on our interests and capacities.



## Project Team
**SICSS-CMU 2025: Fog Wranglers**

![Fog Wranglers logo](/media/Fog-Wranglers-Logo-3.png)


- **[Will Martin](https://www.design.cmu.edu/profiles/william-martin)** - School of Design, Carnegie Mellon University - project conceptualization and ideation, data scraping script, data source, code review
- **[Ian G. Williams](https://www.gc.cuny.edu/people/ian-g-williams)** - PhD Program in Social Welfare, CUNY Graduate Center - project conceptualization and ideation, lexicon creation, project management, presentation slides and planning, literature review
- **[Kuheli Sai](https://sites.google.com/view/kuhelisai/)** - School of Computing and Information, University of Pittsburgh - project conceptualization and ideation, sentiment analysis, descriptive statistics
- **[Hanh Phan](https://www.chatham.edu/academics/undergraduate/accounting/faculty/hanh-phan.html)** School of Business & Enterprise, Chatham University - project conceptualization and ideation, topic modeling

## Project Components
1. **Data Scraping**
2. **Data Wrangling**
3. **Lexicon Creation** Creation of Pittsburghese dictionary CSV file.
4.  **Network Analysis & Adjective Mapping** (`reddit-pgh.R`): Extracts adjectives from Reddit comments to map descriptive terms to Pittsburgh neighborhoods.
5.  **Topic Modeling** (`TopicModelingFogWranglers.R`): Uses LDA and STM models to identify key themes in subreddit discussions.
6.  **Sentiment Analysis** (`SICSS_Sentiment_Analysis_R_Code.R`): Applies VADER sentiment scoring to understand the emotional tone of subreddit interactions.
7.  **Assembly and Presentation of Findings**

## Data Sources

- [/r/Pittsburgh](https://www.reddit.com/r/pittsburgh/) threads and comments from 5/4/25-5/20/2025 (two week window)
- n = 8177
  - 266 threads
  - 7,911 comments
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

Most of this project was made by its human authors, without the use of AI tools, in May 2025. Some of the code was originally written in Python, and later translated to R. In March 2026, Google Gemini CLI was used to integrate all code by generating the run_all.R file, create this directory, push it to Github in March 2026, and automaticaly write portions of this README file, which were then manually reviewed and edited by Ian Williams.

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

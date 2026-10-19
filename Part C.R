#install.packages("tidytuesdayR")
#install.packages("ggplot2")
#install.packages("scales")
#install.packages("tidyverse")
#install.packages("ggridges")
library(ggridges)
library(tidyverse)
library(scales)
library(ggplot2)
library(tidytuesdayR)

# Load datasets
tuesdata <- tidytuesdayR::tt_load('2025-07-29')
movies <- tuesdata$movies
shows <- tuesdata$shows

# Remove entries with missing viewcount and global availability data
movies_clean <- movies %>%
  filter(!is.na(available_globally)) %>%
  filter(!is.na(views))

shows_clean <- shows %>%
  filter(!is.na(available_globally)) %>%
  filter(!is.na(views))

# Combine movie and show datasets
q2_netflix <- bind_rows(
  movies_clean %>% 
    mutate(content_type = "Movie"),
  shows_clean %>% 
    mutate(content_type = "Show"))

ggplot(q2_netflix,
       aes(x = views,
           y = available_globally,
           fill = available_globally)) +
  # Display view axis values using log-10 scale and change from scientific notation to commas
  scale_x_log10(labels = label_comma()) +
  geom_density_ridges(alpha = 0.5) +
  guides(fill = "none") +
  # Separate movies and shows into different graphs
  facet_grid( . ~ content_type) +
  labs(
    title = "Frequency of Viewcounts for Globally Available and Region-locked Movies and Shows on Netflix",
    x = "Views (log scale)",
    y = "Global Availability"
  )

ggplot(q2_netflix,
       aes(x = available_globally,
           y = views)) +
  # Display view axis values using log-10 scale and change from scientific notation to commas
  scale_y_log10(labels = label_comma()) +
  geom_violin(fill = "green3") +
  geom_boxplot(width = 0.05) +
  # Separate movies and shows into different graphs
  facet_grid( . ~ content_type) +
  labs(
    title = "Distribution of Viewcounts for Globally Available and Region-locked Movies and Shows on Netflix",
    x = "Global Availability",
    y = "Views (log scale)"
  )



   

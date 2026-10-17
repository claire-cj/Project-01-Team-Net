#install.packages("tidytuesdayR")
tuesdata <- tidytuesdayR::tt_load('2025-07-29')
movies <- tuesdata$movies
shows <- tuesdata$shows

library(tidyverse)
movies_clean <- movies %>%
  filter(!is.na(available_globally)) %>%
  filter(!is.na(views))

shows_clean <- shows %>%
  filter(!is.na(available_globally)) %>%
  filter(!is.na(views))

ggplot(movies_clean,
       aes(x = available_globally,
           y = views)) +
  scale_y_log10() +
  geom_violin() +
  geom_boxplot(width = 0.1)

ggplot(shows_clean,
       aes(x = available_globally,
           y = views)) +
  scale_y_log10() +
  geom_violin() +
  geom_boxplot(width = 0.1)

   

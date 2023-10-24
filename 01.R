# install.packages("devtools")

# https://devtools.r-lib.org/reference/remote-reexports.html
library(devtools)
library(ggplot2)
library(dplyr)
library(tibble)
library(ggpointdensity)
library(jsonlite)

# install_version("styler", version = "1.10.2")
# install_version("ggplot2", version = "3.4.4")
# install_version("tibble", version = "3.2.1")
# install_version("dplyr", version = "1.1.3")
# install_github("LKremer/ggpointdensity", ref = "02f3ab24eb22e3e34294baeca23a8998db43be70")

set.seed(1234)

# first_n_points <- 7000
# second_n_points <- 3000
first_n_points <- 70
second_n_points <- 30

dat <- bind_rows(
  tibble(
    x = rnorm(first_n_points, sd = 1),
    y = rnorm(first_n_points, sd = 10),
    # group = "foo"
  ),
  tibble(
    x = rnorm(second_n_points, mean = 1, sd = .5),
    y = rnorm(second_n_points, mean = 7, sd = 5),
    # group = "bar"
  )
)

# https://ggplot2.tidyverse.org/reference/scale_viridis.html
# https://github.com/LKremer/ggpointdensity/tree/02f3ab24eb22e3e34294baeca23a8998db43be70
ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity(method = "default") +
  scale_colour_viridis_c()

# ggplot_build(plot = last_plot())
# layer_data(plot = last_plot())
head(layer_data(plot = last_plot()), 5)

ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity(method = "kde2d") +
  scale_colour_viridis_c()

# layer_data(plot = last_plot())
head(layer_data(plot = last_plot()), 5)

output_filename <- paste0("data_", first_n_points + second_n_points, ".json")
output_filename
write_json(dat, output_filename, pretty = FALSE)

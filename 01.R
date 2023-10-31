# install.packages("devtools")

# https://devtools.r-lib.org/reference/remote-reexports.html
library(devtools)
library(ggplot2)
library(dplyr)
library(tibble)
library(ggpointdensity)
library(jsonlite)
library(MASS)

packageVersion("MASS")

# install_version("styler", version = "1.10.2")
# install_version("ggplot2", version = "3.4.4")
# install_version("tibble", version = "3.2.1")
# install_version("dplyr", version = "1.1.3")
# install_github("LKremer/ggpointdensity", ref = "02f3ab24eb22e3e34294baeca23a8998db43be70")

set.seed(1234)

# first_n_points <- 7000
# second_n_points <- 3000
# first_n_points <- 70
# second_n_points <- 30
first_n_points <- 700
second_n_points <- 300

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
head(dat, 5)

# https://ggplot2.tidyverse.org/reference/scale_viridis.html
# https://github.com/LKremer/ggpointdensity/tree/02f3ab24eb22e3e34294baeca23a8998db43be70
ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity(method = "default") +
  scale_colour_viridis_c()

# ggplot_build(plot = last_plot())
# layer_data(plot = last_plot())
head(layer_data(plot = last_plot()), 5)

adjust <- 1
ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity(method = "kde2d", adjust = adjust) +
  scale_colour_viridis_c(direction = -1)
# scale_colour_viridis_c()

# https://github.com/LKremer/ggpointdensity/blob/a202ac73d1e18facb57acab8ea0a9b00680518d4/R/geom_pointdensity.R#L153
# layer_data(plot = last_plot())
head(layer_data(plot = last_plot()), 5)

output_filename <- paste0("data_", first_n_points + second_n_points, ".json")
output_filename
output_path <- file.path("demo", "src", output_filename)
output_path

write_json(dat, output_path, pretty = FALSE)

# https://github.com/LKremer/ggpointdensity/blob/a202ac73d1e18facb57acab8ea0a9b00680518d4/R/geom_pointdensity.R#L120
kde_output <- kde2d(dat$x, dat$y)
# kde_output
kde_output$x
kde_output$y
kde_output$z

is.finite(dat$x)
# is.finite(dat$y)

finites <- is.finite(dat$x) & is.finite(dat$y)
dat[finites, ]

bandwidth.nrd(dat$x)
bandwidth.nrd(dat$y)

# n <- 5
n <- 100
h <- c(bandwidth.nrd(dat$x), bandwidth.nrd(dat$y)) * adjust
h

dens <- kde2d(dat$x, dat$y, n = n, h = h)
dens

head(dat$x, 5)
dens$x
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/findInterval
# https://rdrr.io/cran/MASS/man/kde2d.html
findInterval(dat$x, dens$x)

ix <- findInterval(dat$x, dens$x)
iy <- findInterval(dat$y, dens$y)
ii <- cbind(ix, iy)
ii[1, ]

dat$density <- dens$z[ii]
dat
head(layer_data(plot = last_plot()), 1)

dat$density / max(dat$density)

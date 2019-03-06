# map with uncertainty cloud
library(sf)
library(tidyverse)
library(ggplot2)
sf_phu <- st_read('maps/midcentral_phu.shp')

# Load in data
spat_risk <- read_csv('data/risk.csv')
map_dat <- sf_phu %>% left_join(spat_risk, by=c('MB06' = 'Spatial'))

# Single plot
ggplot(map_dat %>% filter(Iteration == 201)) + geom_sf(aes(fill=Risk), size=0, colour = 'grey80') + 
  geom_sf(aes(alpha=Uncertainty), fill='grey50', size=0, colour = NA) +
  scale_fill_distiller(palette = "BrBG") +
  scale_alpha_continuous(range = c(0,1)) + theme_minimal()

# Fancy animated plot
library(gganimate)
anim <- ggplot(map_dat) + geom_sf(aes(fill=Risk), size=0, colour = 'grey80') + 
  geom_sf(aes(alpha=Uncertainty), fill='grey50', size=0, colour = NA) +
  scale_fill_distiller(palette = "BrBG") +
  scale_alpha_continuous(range = c(0,1)) + theme_minimal() +
  transition_states(Iteration, state_length = 1/20)

# This will take ages with this many frames (~3 hours...)
animate(anim, nframes = 40*21, fps=24, renderer=ffmpeg_renderer())

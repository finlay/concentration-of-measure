library(data.table)
library(ggplot2)
library(gganimate)
library(png)
library(gifski)
library(transformr)

dat <- readRDS('data.rds')
dat <- dat[cols < 20]

state_length <- c(200,150,130,90,50, rep(10, length(unique(dat$cols)) - 5))

p <-
    ggplot(dat, aes(length)) +
      geom_density(alpha=0.1, fill='darkred', colour='darkred') +
      theme_minimal() +
      labs(title = "Dimension = {cols}") +
      transition_states(cols, transition_length=8, state_length=state_length) +
      ease_aes('cubic-in-out') +
      xlim(0,2)

anim_save(p, file='plot.gif')













## ggplot(dat, aes(x=cols, y=length)) +
##     geom_jitter(alpha=0.01) +
##     geom_line(data=dat[, .(mean = mean(length)), cols], aes(x=cols, y=mean),
##               colour = 'blue') +
##     geom_line(data=dat[, .(lower = mean(length) - 2*sd(length)), cols], aes(x=cols, y=lower),
##               colour = 'blue') +
##     geom_line(data=dat[, .(upper = mean(length) + 2*sd(length)), cols], aes(x=cols, y=upper),
##               colour = 'blue')






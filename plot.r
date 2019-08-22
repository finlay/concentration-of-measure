library(data.table)
library(ggplot2)
library(gganimate)
library(png)
library(gifski)
library(transformr)

dat <- readRDS('data.rds')
dat <- dat[cols < 20]
##
## state_length <- c(200,150,130,90,50, rep(10, length(unique(dat$cols)) - 5))
##
## p <-
##     ggplot(dat, aes(length)) +
##       geom_density(alpha=0.1, fill='darkred', colour='darkred') +
##       theme_minimal() +
##       labs(title = "Dimension = {cols}") +
##       transition_states(cols, transition_length=8, state_length=state_length) +
##       ease_aes('cubic-in-out') +
##       xlim(0,2)
##
## anim_save(p, file='plot.gif')
##











pdf(file='plot.pdf', width=9, height=5)

ggplot(dat, aes(x=cols, y=length)) +
    geom_jitter(alpha=0.1, width=0.2) +
    geom_line(data=dat[, .(median = median(length)), cols], aes(y=median),
              colour = 'blue', alpha=0.8) +
    geom_line(data=dat[, .(lower = quantile(length, 0.025)), cols], aes(y=lower),
              colour = 'lightblue', alpha=0.8) +
    geom_line(data=dat[, .(upper = quantile(length, 0.975)), cols], aes(y=upper),
              colour = 'lightblue', alpha=0.8) +
    xlab("Number of dimensions") +
    ylab("Normalised length of random vector") +
    labs(title="Concentration of measure for random vectors with Gaussian components",
         subtitle="The blue line indicates the median, the light blue lines indicate of 95% confidence interval" )

dev.off()





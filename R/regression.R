library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)

# import dataset using import data
summary(income.data)
hist(income.data$happiness)
hist(income.data$income)
plot(happiness ~ income, data = income.data)

income.happiness.lm <- lm(happiness ~ income, data = income.data)

summary(income.happiness.lm)

par(mfrow=c(2,2))
plot(income.happiness.lm)
par(mfrow=c(1,1))

income.graph<-ggplot(income.data, aes(x=income, y=happiness))+
  geom_point()
income.graph

income.graph <- income.graph + geom_smooth(method="lm", col="black")

income.graph

income.graph <- income.graph +
  stat_regline_equation(label.x = 3, label.y = 7)

income.graph

income.graph +
  theme_bw() +
  labs(title = "Reported happiness as a function of income",
       x = "Income (x$10,000)",
       y = "Happiness score (0 to 10)")


library(ggplot2)
library(RColorBrewer)

diamonds <- diamonds[,c("carat", "price", "cut", "color")]



#Introductory images
ggplot() +
  geom_point(data = diamonds,
             aes(x = carat, price))+
  theme_classic()+
  theme(axis.line = element_line(colour = 'black', size = 3))

ggplot() +
  geom_point(data = diamonds,
             aes(x = carat,
                 price,
                 color = cut,
                 shape = color,
                 size = 10))+
  theme_classic()+
  theme(axis.line = element_line(colour = 'black', size = 3))

ggplot() +
  geom_point(data = diamonds,
             aes(x = carat,
                 price,
                 color = cut,
                 size = 10))+
  theme_classic()+
  theme(axis.line = element_line(colour = 'black', size = 3))+
  facet_grid(~color)



#Effectiveness of plots
#example plots for

#accessibility

#hard to read
ggplot() +
  geom_boxplot(data = diamonds,
               aes(x = color,
                   y = price,
                   fill = cut),
               outlier.shape = NA)+
  theme_classic()+
  scale_fill_brewer(palette = "Set1",
                    name = "")


#better
ggplot() +
  geom_boxplot(data = diamonds,
             aes(x = color,
                 y = price,
                 fill = cut),
             outlier.shape = NA)+
  theme_classic()+
  theme(axis.text = element_text(size = 16),
        axis.title = element_text(size = 16),
        axis.title.y = element_text(angle = 0, vjust = 0.5))+
  scale_fill_brewer(palette = "Paired")


universal_design <-   theme(axis.text = element_text(size = 16),
        axis.title = element_text(size = 16),
        axis.title.y = element_text(angle = 0, vjust = 0.5))

#summaries
#needs connection
ggplot(ChickWeight,
       aes(x = Time,
           y = weight,
           shape = Diet,
           color = Diet)) +
  geom_point(stat='summary', 
            fun.y=mean,
            size = 4)+
  theme_classic()+
  universal_design+
  scale_color_brewer(palette = "Paired")


#better
ggplot(ChickWeight,
       aes(x = Time,
           y = weight,
           lty = Diet,
           color = Diet)) +
  geom_line(stat='summary', 
             fun.y=mean,
             size = 2)+
  theme_classic()+
  universal_design+
  scale_color_brewer(palette = "Paired")+
  theme(legend.key.width = unit(5, "line"))

#more information added with error bars (ie more summaries)
#before (no linear regression)
ggplot(mtcars,
       aes(y = mpg,
           x = hp)) +
  geom_point()+
  theme_classic()+
  universal_design+
  labs(x = "Miles per gallon",
       y = "Horsepower")

#after (with summary line)
ggplot(mtcars,
       aes(y = mpg,
           x = hp)) +
  geom_point()+
  stat_smooth(method="lm")+
  theme_classic()+
  universal_design+
  labs(x = "Miles per gallon",
       y = "Horsepower")


#Data to ink ratio and data density
#gray background
ggplot(ChickWeight,
       aes(x = Diet,
           y = weight)) +
  geom_point(stat='summary', 
             fun.y = mean,
             size = 6)+
  stat_summary(geom = "errorbar", 
               fun.y = mean,
               fun.ymax = function (x) {mean (x) + sd(x, na.rm = TRUE)},
               fun.ymin = function (x) {mean (x) - sd(x, na.rm = TRUE)})+
  universal_design+
  geom_jitter(stat='identity',
              size = 1,
              alpha = 0.2)

#remove gray background
ggplot(ChickWeight,
       aes(x = Diet,
           y = weight)) +
  geom_point(stat='summary', 
             fun.y = mean,
             size = 6)+
  stat_summary(geom = "errorbar", 
               fun.y = mean,
               fun.ymax = function (x) {mean (x) + sd(x, na.rm = TRUE)},
               fun.ymin = function (x) {mean (x) - sd(x, na.rm = TRUE)})+
  theme_classic()+
  universal_design+
  geom_jitter(stat='identity',
              size = 1,
              alpha = 0.2)


#Data density
ggplot(ChickWeight,
       aes(x = Diet,
           y = weight)) +
  geom_point(stat='summary', 
             fun.y = mean,
             size = 6)+
  stat_summary(geom = "errorbar",
               fun.y = mean,
               fun.ymax = function (x) {mean (x) + sd(x, na.rm = TRUE)},
               fun.ymin = function (x) {mean (x) - sd(x, na.rm = TRUE)})+
  theme_classic()+
  universal_design



#effectiveness activity plots
ggplot() +
  geom_point(data = diamonds, aes(x = carat, price, color = carat))


ggplot() +
  geom_point(data = diamonds, aes(x = carat, price, color = clarity))+
  theme_classic()+
  theme(axis.text = element_text(size = 16),
        axis.title = element_text(size = 16))



#Clarity of plots
#symbols proportional to numbers
#"Here we demonstrate four diets affect chicken weight divergently over time."
#symbol size according to diet which has no actual size
ggplot(ChickWeight,
       aes(x = Time,
           y = weight,
           color = Diet,
           size = Diet)) +
  
  theme_classic()+
  universal_design+
  scale_color_brewer(palette = "Paired")+
  geom_point()

ggplot(ChickWeight,
       aes(x = Time,
           y = weight,
           color = Diet,
           shape = Diet)) +
  
  theme_classic()+
  universal_design+
  scale_color_brewer(palette = "Paired")+
  geom_point()+
  theme(legend.key.width = unit(5, "line"))



#clear labels/symbology consistent in your document/presentation

#not matching
ggplot() +
  geom_boxplot(data = diamonds,
               aes(x = color,
                   y = price,
                   fill = cut),
               outlier.shape = NA)+
  theme_classic()+
  universal_design+
  scale_fill_brewer(palette = "Paired")

ggplot() +
  geom_boxplot(data = diamonds[diamonds$cut!="Fair",],
               aes(x = color,
                   y = price,
                   fill = cut),
               outlier.shape = NA)+
  theme_classic()+
  universal_design+
  scale_fill_brewer(palette = "Paired")

#matching
ggplot() +
  geom_boxplot(data = diamonds,
               aes(x = color,
                   y = price,
                   fill = cut),
               outlier.shape = NA)+
  theme_classic()+
  universal_design+
  scale_fill_manual(values = c("#A6CEE3",
                               "#1F78B4",
                               "#B2DF8A",
                               "#33A02C",
                               "#FB9A99"))

ggplot() +
  geom_boxplot(data = diamonds[diamonds$cut!="Fair",],
               aes(x = color,
                   y = price,
                   fill = cut),
               outlier.shape = NA)+
  theme_classic()+
  universal_design+
  scale_fill_manual(values = c(
                               "#1F78B4",
                               "#B2DF8A",
                               "#33A02C",
                               "#FB9A99"))



#reduce lack of context
ggplot(ChickWeight[ChickWeight$Diet==1|ChickWeight$Diet==4,],
       aes(x = Time,
           y = weight,
           color = Diet,
           lty = Diet)) +
  
  theme_classic()+
  universal_design+
  scale_color_brewer(palette = "Paired")+
  geom_line(stat='summary', 
            fun.y = mean,
            size = 2)+
  theme(legend.position = "none")

ggplot(ChickWeight,
       aes(x = Time,
           y = weight,
           color = Diet,
           lty = Diet)) +
  
  theme_classic()+
  universal_design+
  scale_color_brewer(palette = "Paired")+
  geom_line(stat='summary', 
            fun.y = mean,
            size = 2)+
  theme(legend.key.width = unit(5, "line"))



#don't change design
#misleading
ggplot(diamonds[diamonds$carat < 1 | diamonds$carat >2.5,],
       aes(y = price,
           x = as.factor(carat))) +
  
  theme_classic()+
  universal_design+
  geom_point()+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())+
  labs(x = "Diamond carats")

#correct and accurate!
ggplot(diamonds[diamonds$carat < 1 | diamonds$carat >2.5,],
       aes(y = price,
           x = carat)) +
  theme_classic()+
  universal_design+
  geom_point()+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())+
  labs(x = "Diamond carats")


#meet your goal
#"Here we demonstrate four diets affect chicken weight divergently over time."
ggplot(ChickWeight,
       aes(x = Time,
           y = weight,
           color = Diet,
           lty = Diet)) +

  theme_classic()+
  universal_design+
  scale_color_brewer(palette = "Paired")+
  geom_line(stat='summary', 
            fun.y = mean,
            size = 2)+
  theme(legend.key.width = unit(5, "line"))


#clarity activity plots
ggplot() +
  geom_point(data = diamonds, aes(x = carat, 
                                  price,
                                  size = substr(cut, 1, 1)))+
  theme_classic()+
  xlim(2,3)+
  ylim(5000, 10000)+
  guides(size=guide_legend(title="cut"))+
  theme(axis.text = element_text(size = 16),
        axis.title = element_text(size = 16))

ggplot() +
  geom_point(data = diamonds, aes(x = carat,
                                  price, 
                                  alpha = cut))+
  theme_classic()+
  ylab("price in USD")+
  theme(axis.text = element_text(size = 16),
        axis.title = element_text(size = 16))

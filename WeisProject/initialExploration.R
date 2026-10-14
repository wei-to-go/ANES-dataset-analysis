#loading in libraries
library(ggplot2)
library(dplyr)
library(gbm)
library(Metrics)

#loading in csv file
anes <- read.csv("anesplease.csv")
View(anes)

#male/female opinions on abortion
lightningTalk <- select(anes, V201336, V201600)
lightningTalk <- filter(lightningTalk, V201336 > 0, V201336 != 5, V201600 > 0)
ggplot(lightningTalk, aes(x = as.factor(V201336), fill = as.factor(V201600))) +
  geom_bar(position = position_dodge()) +
  labs(title = "Americans' opinions on abortion",
       x = "opinion on abortion",
       y = "count",
       fill = "sex") +
  scale_fill_manual(labels = c("male", "female"), values = c("light blue", "purple")) +
  scale_x_discrete(labels = c("1" = "never", "2" = "sometimes", "3" = "most of the time", "4" = "always")) +
  theme(axis.text.x = element_text(face="bold", color="black"))

#death penalty and abortion opinion overlap
dp <- select(anes, V201345x,V201336)
dp <- filter(dp, V201345x > 0, V201345x < 5, V201336 > 0, V201336 < 5)
ggplot(dp, aes(x = as.factor(V201345x), fill = as.factor(V201336), position = "dodge")) +
  geom_bar(position = position_dodge()) +  
  labs(title = "death penalty and abortion opinion overlap",
       x = "opinion on the death penalty",
       y = "count",
       fill = "opinion on abortion") +
  scale_fill_manual(labels = c("never", "sometimes", "most times","always"), values = c("magenta", "orange", "blue", "green")) +
  scale_x_discrete(labels = c("1" = "favor strongly", "2" = "favor not strongly", "3" = "oppose not strongly", "4" = "oppose strongly"), position = "bottom") +
  scale_y_continuous(breaks = seq(from = 0, to = 1200, by = 100)) +
  theme(axis.text.x = element_text(face="bold", color="black", angle = 20))

#liberal or conservative abortion opinions
lc <- select(anes, V201336, V201200)
lc <- filter(lc, V201336 > 0, V201336 != 5, V201200 > 0, V201200 != 99)
ggplot(lc, aes(x = as.factor(V201336), fill = as.factor(V201200))) +
  geom_bar(position = position_dodge(), color = "black") +
  labs(title = "Americans' opinions on abortion",
       x = "should abortions be allowed?",
       y = "count",
       fill = "liberal or conservative") +
  scale_fill_manual(labels = c("very lib", "liberal", "slightly lib", "middle ground", "slightly cons", "conservative", "very cons"), values = c('#ff0000', '#ff7b5a', '#ffbfaa', '#FFFFFF', '#cfb1ff', '#9265ff', '#0000ff')) +
  scale_x_discrete(labels = c("1" = "never", "2" = "sometimes", "3" = "most times", "4" = "always")) +
  theme(axis.text.x = element_text(face="bold", color="black"))

#religion and abortion opinions connections
religion <- select(anes, V201336, V201435)
religion <- filter(religion, V201336 > 0, V201336 != 5, V201435 > 0)
ggplot(religion, aes(x = as.factor(V201336), fill = as.factor(V201435))) +
  geom_bar(position = position_dodge(), color = "black") +
  labs(title = "Americans' opinions on abortion",
       x = "should abortions be allowed?",
       y = "count",
       fill = "religion") +
  scale_fill_manual(labels = c("protestant", "roman catholic", "orthodox christian", "latter-day saints", "jewish", "muslim", "buddhist", "hindu", "athiest", "agnostic", "something else", "nothing in particular"), values = c('red', 'tomato', 'orange', 'yellow', 'chartreuse', 'green4', 'turquoise', 'light blue', 'blue', 'purple', 'magenta', 'pink')) +
  scale_x_discrete(labels = c("1" = "never", "2" = "sometimes", "3" = "most times", "4" = "always")) +
  theme(axis.text.x = element_text(face="bold", color="black"))

#non-christian religions' abortion opinions (also excluding "something else" and "nothing in particular")
noChrist <- filter(religion, V201435 > 4, V201435 < 11)
ggplot(noChrist, aes(x = as.factor(V201336), fill = as.factor(V201435))) +
  geom_bar(position = position_dodge(), color = "black") +
  labs(title = "Non-Christian Americans' opinions on abortion",
       x = "should abortions be allowed?",
       y = "count",
       fill = 'religion (excludes "other" options)') +
  scale_fill_manual(labels = c("jewish", "muslim", "buddhist", "hindu", "athiest", "agnostic"), values = c('chartreuse', 'green4', 'turquoise', 'light blue', 'blue', 'purple')) +
  scale_x_discrete(labels = c("1" = "never", "2" = "sometimes", "3" = "most times", "4" = "always")) +
  theme(axis.text.x = element_text(face="bold", color="black"))

#latter day saints, jews, buddhists, muslims, hindus
jbmh <- filter(religion, V201435 < 9, V201435 > 3)
ggplot(jbmh, aes(x = as.factor(V201336), fill = as.factor(V201435))) +
  geom_bar(position = position_dodge(), color = "black") +
  labs(title = "Morman, Jewish, Muslim, Buddhist, and Hindu Americans' 
opinions on abortion",
       x = "should abortions be allowed?",
       y = "count",
       fill = 'religion') +
  scale_fill_manual(labels = c("latter-day saints","jewish", "muslim", "buddhist", "hindu"), values = c('yellow','chartreuse', 'green4', 'turquoise', 'light blue')) +
  scale_x_discrete(labels = c("1" = "never", "2" = "sometimes", "3" = "most times", "4" = "always")) +
  scale_y_continuous(breaks = seq(from = 0, to = 150, by = 10)) +
  theme(axis.text.x = element_text(face="bold", color="black"))

#christians only 
christians <- filter(religion, V201435 < 5)
ggplot(christians, aes(x = as.factor(V201336), fill = as.factor(V201435))) +
  geom_bar(position = position_dodge(), color = "black") +
  labs(title = "Christian Americans' opinions on abortion",
       x = "should abortions be allowed?",
       y = "count",
       fill = "religion") +
  scale_fill_manual(labels = c("protestant", "roman catholic", "orthodox christian", "latter-day saints"), values = c('red', 'tomato', 'orange', 'yellow')) +
  scale_x_discrete(labels = c("1" = "never", "2" = "sometimes", "3" = "most times", "4" = "always")) +
  theme(axis.text.x = element_text(face="bold", color="black"))

#abrahamic religions
abrahamic <- filter(religion, V201435 < 7)
ggplot(abrahamic, aes(x = as.factor(V201336), fill = as.factor(V201435))) +
  geom_bar(position = position_dodge(), color = "black") +
  labs(title = "Americans' opinions on abortion",
       x = "should abortions be allowed?",
       y = "count",
       fill = "religion (abrahamic only)") +
  scale_fill_manual(labels = c("protestant", "roman catholic", "orthodox christian", "latter-day saints", "jewish", "muslim"), values = c('red', 'tomato', 'orange', 'yellow', 'chartreuse', 'green4')) +
  scale_x_discrete(labels = c("1" = "never", "2" = "sometimes", "3" = "most times", "4" = "always")) +
  theme(axis.text.x = element_text(face="bold", color="black"))

#ages, the number 80 represents ages 80 and older
ages <- select(anes, V201336, V201507x)
ages <- filter(ages, V201336 > 0, V201336 < 5, V201507x > 0, V201507x < 80)
ggplot(ages, aes(x = as.factor(V201336), y = V201507x)) +
  geom_violin(aes(fill = as.factor(V201336))) +
  labs(title = "Americans' opinions on abortion and their ages
80 includes ages 80+",
       x = "should abortions be allowed?",
       y = "age") +
  scale_x_discrete(labels = c("1" = "never", "2" = "sometimes", "3" = "most times", "4" = "always")) +
  theme(axis.text.x = element_text(face="bold", color="black")) +
  scale_y_continuous(breaks = seq(from = 20, to = 80, by = 5)) +
  theme(legend.position="none") +
  geom_boxplot(width=0.1)

neverAge <- filter(ages, V201336 == 1)
ggplot(neverAge, aes(x = V201507x, y = ..count..)) +
  geom_histogram(binwidth = 1, color = "black", fill = "green") +
  labs(title = "ppl who think abortion should never be allowed",
       x = "age ranges") +
  scale_x_continuous(breaks = seq(from = 20, to = 80, by = 10)) +
  annotate("text", x = 37, y = 37, label = "ages 18-79")

sometimesAge <- filter(ages, V201336 == 2)
ggplot(sometimesAge, aes(x = V201507x, y = ..count..)) +
  geom_histogram(binwidth = 1, color = "black", fill = "green") +
  labs(title = "ppl who think abortion should sometimes be allowed",
       x = "age ranges") +
  scale_x_continuous(breaks = seq(from = 20, to = 80, by = 10)) +
  annotate("text", x = 37, y = 69, label = "ages 18-79")

mostTimesAge <- filter(ages, V201336 == 3)
ggplot(mostTimesAge, aes(x = V201507x, y = ..count..)) +
  geom_histogram(binwidth = 1, color = "black", fill = "green") +
  labs(title = "ppl who think abortion should be allowed most of the time",
       x = "age ranges") +
  scale_x_continuous(breaks = seq(from = 20, to = 80, by = 10)) +
  annotate("text", x = 37, y = 37, label = "ages 18-79")

alwaysAge <- filter(ages, V201336 == 4)
ggplot(alwaysAge, aes(x = V201507x, y = ..count..)) +
  geom_histogram(binwidth = 1, color = "black", fill = "green") +
  labs(title = "ppl who think abortion should always be allowed",
       x = "age ranges") +
  scale_x_continuous(breaks = seq(from = 20, to = 80, by = 10)) +
  annotate("text", x = 37, y = 105, label = "ages 18-79")

#education level
edu <- select(anes, V201336, V201510)
edu <- filter(edu, V201336 > 0, V201336 < 5, V201510 > 0)
ggplot(edu,aes(x = as.factor(V201336), fill = as.factor(V201510))) +
  geom_bar(position = "dodge") +
  scale_fill_manual(labels = c("less than highschool credential", "high school graduate", "some college but no degree", "associate degree in college - occupational/vocational", "associate degree in college - academic","bachelor's degree", "master's degree", "professional school degree/doctoral degree", "other"), values = c("red", "orange", "yellow", "chartreuse", "green3", "cyan", "blue", "purple", "magenta"))

#race
race <- select(anes, V201336, V201549x)
race <- filter(race, V201336 > 0, V201336 < 5, V201549x > 0)
ggplot(race,aes(x = as.factor(V201336), fill = as.factor(V201549x))) +
  geom_bar(position = "dodge") +
  scale_fill_manual(labels = c("white", "black", "hispanic", "AAPI", "native american, indigenous","mixed-raced"), values = c("red", "orange", "yellow", "green3", "blue", "purple", "magenta"))

#blank
blank <- select(anes, V201336)
blank <- filter(blank, V201336 > 0, V201336 < 5)
ggplot(blank, aes(x = as.factor(V201336))) +
  geom_bar(fill = "purple") +
  labs(title = "Americans' opinions on abortion in 2020",
          x = "should abortions be legal?") +
  scale_x_discrete(labels = c("1" = "never", "2" = "sometimes", "3" = "most times", "4" = "always")) +

  
  
#sexual orientation
gay <- select(anes, V201336, V201567)
gay <- filter(gay, V201336 > 0, V201336 < 5, V201567 > 0)
ggplot(gay, aes(x = as.factor(V201336), fill = as.factor(V201567))) +
  geom_bar(position = "dodge") +
  scale_fill_manual(labels = c("straight", "gay/lesbian", "bisexual", "smth else"), values = c("red", "orange", "yellow", "green3"))






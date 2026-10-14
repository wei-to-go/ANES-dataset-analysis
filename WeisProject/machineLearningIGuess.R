#loading stuff in
library(ggplot2)
library(dplyr)
library(gbm)
library(Metrics)

anes <- read.csv("anesplease.csv")
View(anes)


## machine learning (idk what i'm doing) ##

#splitting into training, testing, and validation sets
anes_len <- nrow(anes) 

anes$label <- c(rep("training", ceiling(.6*anes_len)),
                rep("test", ceiling(.2*anes_len)),
                rep("validation", ceiling(.2*anes_len))) %>%
  sample(anes_len, replace = F)

anes_train <- filter(anes, label == "training")
anes_test <- filter(anes, label == "test")
anes_valid <- filter(anes, label == "validation")

anes_lm <- lm(V201336 ~ V201345x + V201200 + V201507x, data = anes_train)
anes_lm
summary(anes_lm)
#opinion on death penalty most statistically significant 

anes_lm_predictions <- select(anes_test, V201345x, V201200, V201507x) %>%
  predict(object = anes_lm, type = "response") #object is the model that we just created

anes_test$lm_pred <- anes_lm_predictions #predictions ???

View(anes_test)

anes_train_glm <- anes_train %>% 
  mutate(anes_cat = as.factor(ifelse(V201336 > 1, "yes", "no")))
View(anes_train_glm)

anes_glm <- glm(anes_cat ~ V201345x + V201200 + V201507x,
                data = anes_train_glm,
                family = binomial(link = "logit"))

summary(anes_glm) #pval mod

anes_glm_preds <- anes_test %>%
  select(V201345x, V201200, V201507x) %>%
  predict(object = anes_glm)

anes_test$glm_pred <- anes_glm_preds

anes_test <- anes_test %>% 
  mutate(anes_cat = as.factor(ifelse(V201336 > 1, "yes", "no")))

anes_train_2abortion <- filter(anes_train, V201336 %in% c(1,4))

anes_glm <- glm(V201336 ~ V201345x + V201200 + V201507x, 
                data = anes_train_2abortion,
                family = binomial(link = "logit")) 

summary(anes_glm) #pval mod

#create test set with only 2
anes_test_2abortion <- anes_test %>% 
  filter(V201336 %in% c(1,4)) 

#make predictions based on model
anes_2abortion_preds <- anes_test_2abortion %>%
  select(-V201336) %>%
  predict(object = anes_glm)

#add predictions to test set
anes_test_2abortion$glm_2abort_pred <- anes_2abortion_preds


## GBM ##
anes_gbm <- gbm(V201336 ~ V201345x + V201200 + V201507x,
                data = anes_test, 
                n.trees = 500) 

summary(anes_gbm)

#select out only the x values we used from test and predict
anes_gbm_preds <- anes_test %>%
  select(V201345x, V201200, V201507x) %>%
  predict(object = anes_gbm)

#save predictions back into test set
anes_test$gbm_pred <- anes_gbm_preds

View(anes_test)

#calculate rmse between predictions and true values
rmse(anes_test$V201336, anes_test$lm_pred) 
rmse(anes_test$V201336, anes_test$gbm_pred) #wins! smaller error

#calculate mae between predictions and true values
mae(anes_test$V201336, anes_test$lm_pred) 
mae(anes_test$V201336, anes_test$gbm_pred) #wins! smaller error


#accuracy
anes_test <- anes_test %>%
  mutate(glm_abort_cat = ifelse(glm_pred > 2, "yes", "no"))

true_vals <-sum(anes_test$glm_abort_cat == anes_test$anes_cat)
total_vals <- nrow(anes_test)

accuracy <- true_vals/total_vals # 1! Great accuracy!
accuracy

#f1 score tells us about false positive & false negative rates
f1(anes_test$glm_abort_cat, anes_test$anes_cat)




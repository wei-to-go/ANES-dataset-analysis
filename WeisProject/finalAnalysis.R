#loading stuff ib
library(ggplot2)
library(dplyr)
library(gbm)
library(Metrics)

anes <- read.csv("anesplease.csv")
View(anes)

#setting up dataset
anesClean <- select(anes, V201336, V201345x, V201200, V201435, V201549x, V201601, V201600, V201507x)
anesClean <- rename(anesClean, abortion = V201336, deathPenalty = V201345x, libCons = V201200, religion = V201435, race = V201549x, sexuality = V201601, sex = V201600, age = V201507x)
anesClean <- filter(anesClean, abortion > 0, abortion < 5, deathPenalty > 0, libCons > 0, libCons < 99, religion > 0, race > 0, sexuality > 0, sex > 0, age > 0, age < 80)

#splitting into subsets
anes_Clean <- nrow(anesClean)

anesClean$label <- c(rep("training", ceiling(.6*anes_Clean)),
                rep("test", ceiling(.2*anes_Clean)),
                rep("validation", ceiling(.2*anes_Clean))) %>%
  sample(anes_Clean, replace = F)

anes_Ctrain <- filter(anesClean, label == "training")
anes_Ctest <- filter(anesClean, label == "test")
anes_Cvalid <- filter(anesClean, label == "validation")


## ALL VARIABLES

#relative influence and predictions
anes_Cgbm <- gbm(abortion ~ deathPenalty + libCons + religion + race + sexuality + sex + age, data = anes_Ctrain, n.trees = 500)
anes_Cgbm
summary(anes_Cgbm)

anes_gbm_Cpreds <- anes_Ctest %>%
  select(deathPenalty, libCons, religion, race, sexuality, sex, age) %>%
  predict(object = anes_Cgbm)

anes_Ctest$gbm_pred <- anes_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
allRMSE <- rmse(anes_Ctest$abortion, anes_Ctest$gbm_pred)
allMAE <- mae(anes_Ctest$abortion, anes_Ctest$gbm_pred)
allRMSE
allMAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(glm_pred_cat = ifelse(round(gbm_pred, digits = 0) == 1, "never", ifelse(round(gbm_pred, digits = 0) == 2, "sometimes", ifelse(round(gbm_pred, digits = 0) == 3, "most times", "always"))),
         true_abort_cat = ifelse(abortion == 1, "never", ifelse(abortion == 2, "sometimes", ifelse(abortion == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$glm_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

allAccuracy <- true_vals/total_vals # 0.46 accuracy
allAccuracy


## libCons ONLY

#rpredictions
lc_Cgbm <- gbm(abortion ~ libCons, data = anes_Ctrain, n.trees = 500)
lc_Cgbm

lc_gbm_Cpreds <- anes_Ctest %>%
  select(libCons) %>%
  predict(object = lc_Cgbm)

anes_Ctest$lc_pred <- lc_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
lcRMSE <- rmse(anes_Ctest$abortion, anes_Ctest$lc_pred)
lcMAE <- mae(anes_Ctest$abortion, anes_Ctest$lc_pred)
lcRMSE
lcMAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(lc_pred_cat = ifelse(round(lc_pred, digits = 0) == 1, "never", ifelse(round(lc_pred, digits = 0) == 2, "sometimes", ifelse(round(lc_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$lc_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

lcAccuracy <- true_vals/total_vals # 0.49 accuracy
lcAccuracy


## age ONLY

#rpredictions
age_Cgbm <- gbm(abortion ~ age, data = anes_Ctrain, n.trees = 500)
age_Cgbm

age_gbm_Cpreds <- anes_Ctest %>%
  select(age) %>%
  predict(object = age_Cgbm)

anes_Ctest$age_pred <- age_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
ageRMSE <- rmse(anes_Ctest$abortion, anes_Ctest$age_pred)
ageMAE <- mae(anes_Ctest$abortion, anes_Ctest$age_pred)
ageRMSE
ageMAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(age_pred_cat = ifelse(round(age_pred, digits = 0) == 1, "never", ifelse(round(age_pred, digits = 0) == 2, "sometimes", ifelse(round(age_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$age_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

ageAccuracy <- true_vals/total_vals # 0.15 accuracy
ageAccuracy



## religion ONLY 

#rpredictions
rel_Cgbm <- gbm(abortion ~ religion, data = anes_Ctrain, n.trees = 500)
rel_Cgbm

rel_gbm_Cpreds <- anes_Ctest %>%
  select(religion) %>%
  predict(object = rel_Cgbm)

anes_Ctest$rel_pred <- rel_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
relRMSE <- rmse(anes_Ctest$abortion, anes_Ctest$rel_pred)
relMAE <- mae(anes_Ctest$abortion, anes_Ctest$rel_pred)
relRMSE
relMAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(rel_pred_cat = ifelse(round(rel_pred, digits = 0) == 1, "never", ifelse(round(rel_pred, digits = 0) == 2, "sometimes", ifelse(round(rel_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$rel_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

relAccuracy <- true_vals/total_vals # 0.28 accuracy
relAccuracy


## race ONLY

#rpredictions
race_Cgbm <- gbm(abortion ~ race, data = anes_Ctrain, n.trees = 500)
race_Cgbm

race_gbm_Cpreds <- anes_Ctest %>%
  select(race) %>%
  predict(object = race_Cgbm)

anes_Ctest$race_pred <- race_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
raceRMSE <- rmse(anes_Ctest$abortion, anes_Ctest$race_pred)
raceMAE <- mae(anes_Ctest$abortion, anes_Ctest$race_pred)
raceRMSE
raceMAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(race_pred_cat = ifelse(round(race_pred, digits = 0) == 1, "never", ifelse(round(race_pred, digits = 0) == 2, "sometimes", ifelse(round(race_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$race_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

raceAccuracy <- true_vals/total_vals # 0.15 accuracy
raceAccuracy


## death penalty ONLY

#rpredictions
dp_Cgbm <- gbm(abortion ~ deathPenalty, data = anes_Ctrain, n.trees = 500)
dp_Cgbm

dp_gbm_Cpreds <- anes_Ctest %>%
  select(deathPenalty) %>%
  predict(object = dp_Cgbm)

anes_Ctest$dp_pred <- dp_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
dpRMSE <- rmse(anes_Ctest$abortion, anes_Ctest$dp_pred)
dpMAE <- mae(anes_Ctest$abortion, anes_Ctest$dp_pred)
dpRMSE
dpMAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(dp_pred_cat = ifelse(round(dp_pred, digits = 0) == 1, "never", ifelse(round(dp_pred, digits = 0) == 2, "sometimes", ifelse(round(dp_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$dp_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

dpAccuracy <- true_vals/total_vals # 0.15 accuracy
dpAccuracy


## sexuality ONLY

#rpredictions
so_Cgbm <- gbm(abortion ~ sexuality, data = anes_Ctrain, n.trees = 500)
so_Cgbm

so_gbm_Cpreds <- anes_Ctest %>%
  select(sexuality) %>%
  predict(object = so_Cgbm)

anes_Ctest$so_pred <- so_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
soRMSE <- rmse(anes_Ctest$abortion, anes_Ctest$so_pred)
soMAE <- mae(anes_Ctest$abortion, anes_Ctest$so_pred)
soRMSE
soMAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(so_pred_cat = ifelse(round(so_pred, digits = 0) == 1, "never", ifelse(round(so_pred, digits = 0) == 2, "sometimes", ifelse(round(so_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$so_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

soAccuracy <- true_vals/total_vals # 0.19 accuracy
soAccuracy


## sex ONLY

#rpredictions
sex_Cgbm <- gbm(abortion ~ sex, data = anes_Ctrain, n.trees = 500)
sex_Cgbm

sex_gbm_Cpreds <- anes_Ctest %>%
  select(sex) %>%
  predict(object = sex_Cgbm)

anes_Ctest$sex_pred <- sex_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
sexRMSE <- rmse(anes_Ctest$abortion, anes_Ctest$sex_pred)
sexMAE <- mae(anes_Ctest$abortion, anes_Ctest$sex_pred)
sexRMSE
sexMAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(sex_pred_cat = ifelse(round(sex_pred, digits = 0) == 1, "never", ifelse(round(sex_pred, digits = 0) == 2, "sometimes", ifelse(round(sex_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$sex_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

sexAccuracy <- true_vals/total_vals # 0.15 accuracy
sexAccuracy


## top 5

#relative influence and predictions
top5_Cgbm <- gbm(abortion ~ libCons + religion + race + deathPenalty + age, data = anes_Ctrain, n.trees = 500)
top5_Cgbm
summary(top5_Cgbm)

top5_gbm_Cpreds <- anes_Ctest %>%
  select(deathPenalty, libCons, religion, race, age) %>%
  predict(object = top5_Cgbm)

anes_Ctest$top5_pred <- top5_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
top5RMSE <- rmse(anes_Ctest$abortion, anes_Ctest$top5_pred)
top5MAE <- mae(anes_Ctest$abortion, anes_Ctest$top5_pred)
top5RMSE
top5MAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(top5_pred_cat = ifelse(round(top5_pred, digits = 0) == 1, "never", ifelse(round(top5_pred, digits = 0) == 2, "sometimes", ifelse(round(top5_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$top5_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

top5Accuracy <- true_vals/total_vals # 0.46 accuracy
top5Accuracy


## top 3

#relative influence and predictions
top3_Cgbm <- gbm(abortion ~ libCons + religion + age, data = anes_Ctrain, n.trees = 500)
top3_Cgbm
summary(top3_Cgbm)

top3_gbm_Cpreds <- anes_Ctest %>%
  select(libCons, religion, age) %>%
  predict(object = top3_Cgbm)

anes_Ctest$top3_pred <- top3_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
top3RMSE <- rmse(anes_Ctest$abortion, anes_Ctest$top3_pred)
top3MAE <- mae(anes_Ctest$abortion, anes_Ctest$top3_pred)
top3RMSE
top3MAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(top3_pred_cat = ifelse(round(top3_pred, digits = 0) == 1, "never", ifelse(round(top3_pred, digits = 0) == 2, "sometimes", ifelse(round(top3_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$top3_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

top3Accuracy <- true_vals/total_vals # 0.46 accuracy
top3Accuracy


## top 2

#relative influence and predictions
top2_Cgbm <- gbm(abortion ~ libCons + age, data = anes_Ctrain, n.trees = 500)
top2_Cgbm
summary(top2_Cgbm)

top2_gbm_Cpreds <- anes_Ctest %>%
  select(libCons, age) %>%
  predict(object = top2_Cgbm)

anes_Ctest$top2_pred <- top2_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
top2RMSE <- rmse(anes_Ctest$abortion, anes_Ctest$top2_pred)
top2MAE <- mae(anes_Ctest$abortion, anes_Ctest$top2_pred)
top2RMSE
top2MAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(top2_pred_cat = ifelse(round(top2_pred, digits = 0) == 1, "never", ifelse(round(top2_pred, digits = 0) == 2, "sometimes", ifelse(round(top2_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$top2_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

top2Accuracy <- true_vals/total_vals # 0.48 accuracy
top2Accuracy


## highest accuracy

#relative influence and predictions
hacc_Cgbm <- gbm(abortion ~ libCons + religion + sexuality, data = anes_Ctrain, n.trees = 500)
hacc_Cgbm
summary(hacc_Cgbm)

hacc_gbm_Cpreds <- anes_Ctest %>%
  select(libCons, religion, sexuality) %>%
  predict(object = hacc_Cgbm)

anes_Ctest$hacc_pred <- hacc_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
haccRMSE <- rmse(anes_Ctest$abortion, anes_Ctest$hacc_pred)
haccMAE <- mae(anes_Ctest$abortion, anes_Ctest$hacc_pred)
haccRMSE
haccMAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(hacc_pred_cat = ifelse(round(hacc_pred, digits = 0) == 1, "never", ifelse(round(hacc_pred, digits = 0) == 2, "sometimes", ifelse(round(hacc_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$hacc_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

haccAccuracy <- true_vals/total_vals # 0.45 accuracy
haccAccuracy


## lowest accuracy

#relative influence and predictions
lacc_Cgbm <- gbm(abortion ~ age + sex + deathPenalty + race, data = anes_Ctrain, n.trees = 500)
lacc_Cgbm
summary(lacc_Cgbm)

lacc_gbm_Cpreds <- anes_Ctest %>%
  select(age, race, sex, deathPenalty) %>%
  predict(object = lacc_Cgbm)

anes_Ctest$lacc_pred <- lacc_gbm_Cpreds
View(anes_Ctest)

#calculating errors 
laccRMSE <- rmse(anes_Ctest$abortion, anes_Ctest$lacc_pred)
laccMAE <- mae(anes_Ctest$abortion, anes_Ctest$lacc_pred)
laccRMSE
laccMAE

#calculating accuracy
anes_Ctest <- anes_Ctest %>%
  mutate(lacc_pred_cat = ifelse(round(lacc_pred, digits = 0) == 1, "never", ifelse(round(lacc_pred, digits = 0) == 2, "sometimes", ifelse(round(lacc_pred, digits = 0) == 3, "most times", "always"))))

true_vals <-sum(anes_Ctest$lacc_pred_cat == anes_Ctest$true_abort_cat)
total_vals <- nrow(anes_Ctest)

laccAccuracy <- true_vals/total_vals # 0.21 accuracy
laccAccuracy



## visualizing the results

#new dataframe
results <- data.frame(matrix(ncol = 4, nrow = 13))
colnames(results) <- c('model_name', 'accuracy', 'rmse', 'mae')
results$model_name <- c('all vars', 'lib-cons', 'religion', 'race', 'age', 'sex', 'death penalty', 'sexuality', 'top 5 rel inf', 'top 3 rel inf', 'top 2 rel inf', 'highest acc', 'lowest acc')
results$accuracy <- c(allAccuracy, lcAccuracy, relAccuracy, raceAccuracy, ageAccuracy, sexAccuracy, dpAccuracy, soAccuracy, top5Accuracy, top3Accuracy, top2Accuracy, haccAccuracy, laccAccuracy)
results$rmse <- c(allRMSE, lcRMSE, relRMSE, raceRMSE, ageRMSE, sexRMSE, dpRMSE, soRMSE, top5RMSE, top3RMSE, top2RMSE, haccRMSE, laccRMSE)
results$mae <- c(allMAE, lcMAE, relMAE, raceMAE, ageMAE, sexMAE, dpMAE, soMAE, top5MAE, top3MAE, top2MAE, haccMAE, laccMAE)
View(results)

arrange(results, mae)  
arrange(results, rmse)  
arrange(results, desc(accuracy)) 

ggplot(results, aes(x = model_name, y = accuracy, color = 'green3')) +
  geom_point() +
  geom_point(aes(y = rmse, color = 'red')) +
  geom_point(aes(y = mae, color = 'blue')) +
  labs(title = 'accuracy, mae, and rmse of gbm models',
       y = 'value',
       x = 'model',
       color = '') +
  scale_color_manual(labels = c('mae', 'accuracy','rmse'), values = c('blue','green3','red')) +
  scale_y_continuous(breaks = seq(from = 0, to = 1.1, by = 0.1)) +
  theme(axis.text.x = element_text(vjust = 0.2, hjust = 0.8, angle = 90, face = 'bold'))  

saveRDS(results, "results")

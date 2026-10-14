## Wei's Project

<<<<<<< HEAD
this is wei's project on the ANES dataset for the coding school summer research program 2022. My mentor is Gustavo. ANES stands for American National Election Studies, the data is gathered from surveys and polls for US eligible voters both pre- and post-election. My project focuses on the topic of opinions on abortion.
=======
<<<<<<< HEAD
this is Wei's project on the ANES dataset for the coding school summer research program 2022. ANES stands for American National Election Studies, the data is gathered from surveys and polls for both pre- and post-election.
=======
this is wei's project on the ANES dataset for the coding school summer research program 2022. ANES stands for American National Election Studies, the data is gathered from surveys and polls for US eligible voters both pre- and post-election.
>>>>>>> f4599772b5c458699f177366faa3081ba960c9b7
>>>>>>> ac9834884d46b2409b6e1e1513915167eb5a26f8

[dataset link](https://electionstudies.org/data-center/2020-time-series-study/)

[dataset guide link (non-survey variables)](https://electionstudies.org/wp-content/uploads/2021/07/anes_timeseries_2020_methodology_userguidecodebook_20210719.pdf) 

[dataset guide link (survey variables)](https://electionstudies.org/wp-content/uploads/2022/02/anes_timeseries_2020_userguidecodebook_20220210.pdf) 

### FINALIZED RESEARCH QUESTION AND HYPOTHESIS
***do people who don't support abortion also not support the death penalty due to the logic of "pro-life" ideals? Or is the disapproval of abortion more closely tied to another factor like religion or culture?*** 
<br>
**null**: a person's opinion on abortion and the death penalty are unrelated and have no correlation 
<br>
**alternate hypothesis**:a person's opinion on abortion and the death penalty are related and not independent of each other since both views are pro-life

### final variables, all pre-election
* abortion, V201336
  + refused (-9)
  + don't know (-8)
  + By law, abortion should never be permitted (1)
  + The law should permit abortion only in case of rape, incest, or when the woman’s life is in danger (2)
  + The law should permit abortion other than for rape/incest/danger to woman but only after need clearly established (3)
  +  By law, a woman should always be able to obtain an abortion as a matter of personal choice (4)
  + other (5)
* opinion on death penalty, V201345x 
  + DK/RF (-2)
  + favor strongly (1)
  + favor not strongly (2)
  + oppose not strongly (3)
  + oppose strongly (4)
* lib-cons self scale placement, V201200
  + refused (-9)
  + don't know (-8)
  + extremely liberal (1)
  + liberal (2)
  + slightly liberal (3)
  + moderate; middle of the road (4)
  + slightly conservative (5)
  + conservative (6)
  + extremely conservative (7)
  + haven't thought much about this (99)
* religion, V201435
  + refused (-9)
  + don't know (-8)
  + protestant (1)
  + roman catholic (2)
  + orthodox christian (3)
  + latter-day saints (4)
  + jewish (5)
  + muslim (6)
  + buddhist (7)
  + hindu (8)
  + athiest (9)
  + agnostic (10)
  + something else (11)
  + nothing in particular (12)
* sex, V201600
  + refused (-9)
  + male (1)
  + female (2)
* age (pre), V201507x
  + refused (-9)
  + numbers 1-79
  + 80 years old or older (80)
* education level (pre), V201510
  + refused (-9)
  + don't know (-8)
  + less than highschool credential (1)
  + high school graduate (2)
  + some college but no degree (3)
  + associate degree in college - occupational/vocational (4)
  + associate degree in college - academic (5)
  + bachelor's degree (6)
  + master's degree (7)
  + professional school degree/doctoral degree (8)
  + other (95)
* race and ethnicity (pre), V201549x
  + refused (-9)
  + don't know (-8)
  + white, non-hispanic (1)
  + black, non-hispanic (2)
  + hispanic (3)
  + asian or native hawaiian/other pacific islander, non-hispanic alone (4)
  + native american/alaska native or other race, non-hispanic (5) alone
  + multiple races, non-hispanic (6) 
* children (pre), V201567
  + refused (-9)
  + no children aged 0-17 (0)
  + one child (1)
  + two children (2)
  + three children (3)
  + four or more children (4)
* sexual orientation (pre), V201601
  + refused (-9)
  + interview breakoff (-5)
  + heterosexual/straight (1)
  + homosexual/gay/lesbian (2)
  + bisexual (3)
  + something else (4)

# research question brainstorm
* non-survey variables that interest me:
  + state/location, V203001
  + census region, V203003
  + time zone, V203004
  + number of adults, V203103
  + household, V203104
  + citizenship, V203107
  + sex, V203109
  + age (pre), V201507x
  + education level (pre), V201510
  + employment status (pre), V201529
  + ocupation status (pre), V201533x
  + spanish/hispanic/latino (pre), V201546
  + race and ethnicity (pre), V201549x
  + children (pre), V201567
  + where respondent grew up (pre), V201575
  + sexual orientation (pre), V201601
  + total family income, V201617x
  + number of owned guns, V201628
  + state of registration, V202054x
  + party of registration, V202065x
  
* pre-election survey variables that interest me:
  + attention to politics, V201005
  + which state they're registered to vote, V201008/V201013
  + party of registration, V201018
  + presidential primary candidate vote, V201021
  + presidential vote/intent/preference, V201075x
  + house vote/intent/preference, V201076x
  + senate vote/intent/preference, V201077x
  + governor vote/intent/preference, V201078x
  + likeliness to vote in upcoming election, V201100
  + voted for pres election in 2016?, V201101/V201102
  + 2016 vote choice, V201103
  + hopefulness for america, V201115
  + afraid of how things are going?, V201116
  + outraged?, V201117
  + happy?, V201119
  + worried?, V201120
  + proud?, V201121
  + approval of congress, V201126x
  + approval of president, V201129x
  + approval of president's handling of economy, V201132x
  + approval of president's handling of foreign relations, V201135x
  + approval of president's handling of health care, V201138x
  + approval of president's handling of immigration, V201141x
  + approval of president's handling of COVID-19, V201144x
  + approval of governor's handling of COVID-19, V201147x
  + approval of local government's handling of COVID-19, V201150x
  + approval of democratic party, V201156
  + approval of republican party, V201157
  + lib-cons self scale placement, V201200
  + liberal or conservative?, V201201
  + lib-cons biden scale placement, V201202
  + lib-cons trump scale placement, V201203
  + lib-cons democratic party scale placement, V201206
  + lib-cons republican party scale placement, V201207
  + who will be pres?, V201217
  + close win? big gap?, V201218
  + is voting a duty or choice?, V201225x
  + party id, V201231x
  + party importance, V201232
  + waste tax money?, V201235
  + how many are corrupt?, V201236
  + how often can ppl be trusted?, V201237
  + which party better handles national economy?, V201239
  + which party better handles health care?, V201240
  + which party better handles immigration?, V201241
  + which party better handles taxes?, V201242
  + which party better handles environmental issues?, V201243
  + which party better handles COVID-19?, V201244
  + abortion, V201336
  + importance of abortion, V201337
  + reaction if supreme court limited abortion rights, V201342x
  + opinion on death penalty, V201345x 
  + will votes be counted accurately, V201351
  + how trustworthy are election officials, V201352
  + favor/oppose vote by mail, V201356x
  + importance of serious consequences for misconduct of gov officials, V201368
  + trust in news media, V201377
  + has political corruption increased or decreased since trump, V201382x
  + difference in the income gap, V201400x
  + marriage services to same-sex couples, V201408x
  + trans friendly bathrooms?, V201411x
  + protection of queers in the workplace, V201414x
  + gay adoption?, V201415
  + gay marriage?, V201416
  + religion, V201435
  + concern about current financial situation, V201594
  + do women interpret innocent remarks as misogynistic?, V201639
  + women seek power by gaining control over men, V201640
  
* post-election survey variables that interest me:
  + engagement in political convos w/friends and family, V202023
  + gotten into a political argument this past 12 months, V202024
  + participated in a rally/march/protest this past 12 months, V202025
  + signed a petition this past 12 months, V202026
  + posted an online comment about politics this past 12 months, V202029
  + registered to vote, V202051/V202054a
  + party of registration, V202064
  + vote status, V202068x
  + opinions of those who did not vote, V202079x
  + voted for president, V202072
  + who did they vote for, V202073
  + how much time to make the decision, V202075y
  + presidential vote/preference, V202105x
  + house vote/preference, V202106x
  + senate vote/preference, V202107x
  + governor vote/preference, V202108x
  + when did they vote, V202116
  + how they voted, V202117
  + biden scale placement, V202143
  + trump scale placement, V202144
  + harris scale placement, V202156
  + pence scale placement, V202157
  + feminists scale placement, V202160
  + liberals scale placement, V202161
  + conservatives scale placement, V202164
  + gays scale placement, V202166
  + supreme court scale placement, V202165
  + congress scale placement, V202167
  + muslims scale placement, V202168
  + christians scale placement, V202169
  + jews scale placement, V202170
  + police scale placement, V202171
  + transfolk scale placement, V202172
  + BLM scale placement, V202174
  + socialists scale placement, V202179
  + capitalists scale placement, V202180
  + FBI scale placement, V202181
  + how often are votes counted fairly, V202219
  + hispanic representation in government, V202220
  + black representation in government, V202221
  + asian representation in government, V202222
  + queer representation in government, V202223
  + women in government, V202224
  + refugees in the US, V202236x
  + effect of illegal immigration on national crime rate, V202239x
  + enforce equal opportunity, V202260
  + better off not worrying about equality, V202261
  + fewer problems if things were more fair, V202263
  + children should be independent or respectful of elders?, V202266
  + curiosity or good manners, V202267
  + obedience or self reliance, V202268
  + considerate or well-behaved, V202269
  + is the US better or worse than most countries, V202273x
  + economic mobility, V202320x
  + police brutality, V202351
  + trans ppl in the military, V202390x
  + interest in politics, V202406
  + well informed?, V202407
  + politicians trustworthy?, V202411
  + politicians are a problem?, V202412
  + total family income, V202468x
  + asian america scale placement, V202477
  + asian scale placement, V202478
  + hispanic scale placement, V202479
  + black scale placement, V202480
  + illegal immigrant scale placement, V202481
  + white scale placement, V202482
  + stereotype scale (hardworking)
    + white ppl, V202515
    + black ppl, V202516
    + hispanic americans, V202517
    + hispanic ppl, V202518
    + asian americans, V202519
    + asian ppl, V202520
  + stereotype scale (violent)
    + white ppl, V202521
    + black ppl, V202522
    + hispanic americans, V202523
    + hispanic ppl, V202524
    + asian americans, V202525
    + asian ppl, V202526
  + discrimination scale
    + black ppl, V202527
    + hispanic ppl, V202528
    + asian ppl, V202529
    + white ppl, V202530
    + muslims, V202531
    + christians, V202532
    + gays, V202533
    + women, V202534
    + men, V202535
    + transfolk, V202536
  + discrimination faced because of race/ethnicity, V202537
  + discrimination faced because of gender, V202538
  
## a few questions to think about when writing a research question:
* Which variable do you want to try to **predict**?
* What categories do you most want to **distinguish between**?
* Which independent variables are you interested in investigating their **effects**?
* What are some ways you can **group the data** or some variables together?
* What **change** or **difference** are you most interested in?
  
  
## SAMPLE QUESTIONS
* do republicans and democrats disagree with each other more than they agree with each other or is it the other way around? On what subjects do they agree on, on what subjects do they disagree on, how do other factors like race and gender affect their opinions. For example, are white republicans more conservative than BIPOC republicans?
* which variables help predict whether someone is a republican or democrat?
* how does race and gender contribute to income?
* what demographic trusts the government the most and what demographic trusts the government the least? which variables contribute the greatest to this opinion?
* do people who dont support abortion also not support the death penalty due to the logic of "pro-life" ideas? Or is the disapproval of abortion tied to another factor like religion or culture?
* how does religion affect approval of the lgbtq+ community, are there other factors that are of stronger influence?
* according to each demographic, which race/ethnicity is the most hardworking and which is the most violent, how do the different opinions compare across demographics and within one demographic?

  
  
  

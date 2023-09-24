* Lab 4

* In this lab we will continue to explore the
* data from Muralidharan, Singh, and Ganimian (2019)
* as well as the data from the world bank on GDP and Life Expectancy

* Where you see XX, you need to delete XX and replace with the relevant code
* Also make sure to write in answers (as comments) to any questions in the do-file.

*********
* Part 1: Workflow 
*********

* 1. change working directory to location of data 
cd "C:\Users\schwa\Desktop\UCSD Undergrad\Spring '23\ECON 5\Labs\Lab4"

* 2. load mindspark_data
use mindspark_data.dta, clear
**********
* Part 2: Average Test Scores
**********

* 0. run the lines of code below to set scheme to plotplainblind
* This will change the overall look of your figures
ssc install blindschemes
set scheme plotplainblind

* 1. Create a bar graph that shows the average baseline 
* math score for treated and control students 
* make sure to have proper titles/labels
graph bar (mean) per_math1, over(treat) ///
title("Average Baseline Math Scores by Treatment Group") ///
ytitle("Mean Baseline Math Score") ///

* 2. Create a bar graph that shows the average endline 
* math score for treated and control students 
* make sure to have proper titles/labels
graph bar (mean) per_math2, over(treat) ///
title("Average Endline Math Scores by Treatment Group") ///
ytitle("Mean Endline Math Score") ///
	
*********
* Part 3: Regression 
*********

* 1. Estimate a regression in which the Y-variable (dependent variable/outcome)
* is math score at baseline while the X-variable (independent variable/explanatory) is ses_index
reg per_math1 ses_index

* 2. Report and Interpret the slope coefficient below
* A: Slope coefficient for ses_index is 0.0122396 with standard error of 0.0025951. The t-statistic for this coefficient is 4.72, which is significant at the 1% 	level. There is strong evidence to suggest that there is a positive relationship between ses_index and per_math1.

* 3. What is the predicted test score for an individual with ses index = 0.5
* A: baseline_math_score = 0.0122396(0.5) + 0.3177475 = 0.32389685

* 4. What is the difference in predicted test scores for an individual with 
* ses index =0.5 vs. ses index =-0.5?
* A: baseline math score2 = 0.0122396(-0.5) + 0.3177475 = 0.31159825
*  	 0.32389685 - 0.31159825 = 0.0122986

* 5. Construct a single figure that shows both (1) a scatter plot of the relationship between score at baseline and ses index and (2) the linear regression line of best fit
twoway scatter per_math1 ses_index || lfit per_math1 ses_index, lwidth(med) ///
xtitle("SES Index") ytitle("Baseline Math Score") title("Baseline Math Score vs. SES Index")



	
	
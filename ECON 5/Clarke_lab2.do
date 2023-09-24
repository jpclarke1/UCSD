* Lab 2

* In this lab we will continue to explore the College Mobility Data 
* from the Researchers at Opportunity Insights 

* Where you see XX, you need to delete XX and replace with the relevant code

*********
* Part 1: Workflow 
*********

* If you have not done so, download the college_mobility.dta and place
* it somewhere on your computer. I recommend creating a folder hierarchy 
* along the lines of:
* Documents > EP5 > 02_week 
* and inside the 02_week folder place everything related to week 2

* 1. change your working directory 
cd "C:\Users\schwa\Desktop\UCSD Undergrad\Spring '23\ECON 5\Labs\Lab2"

* 2. load in the data 
use college_mobility.dta, clear

********
* Part 2: Summary Statistics 
********

* 1. What does the variable par_median represent? Write your answer as a comment below
* A: median parental income

* 2. What is the average of par_median?
mean par_median
* A: 77742.79 

* 3. What school has the minimum par_median? 
egen min_par = min(par_median)
br name if par_median == min_par
* A: United Talmudical Seminary

* 4. What school has the maximum par_median?
egen max_par = max(par_median)
br name if par_median == max_par
* A: Washington And Lee University

********
* Part 3: Generating New Variables
********

* 1. Generate a binary indicator variable that is equal to one if 
* the average number of students in the school is less than or equal to 100
gen small_school = (count <= 100)

* 2. You can drop observations that meet certain restrictions. For example, 
* let's drop observations that have less than or equal to 100 students 
drop if small_school == 1

* 3. You can also drop variables that you no longer need 
* Drop the variable that you created in 1
drop small_school

*******
* Part 4: Histogram
*******

* 1. Create a histogram of par_median. Make sure your histogram has 
* (1) a title and (2) appropriate axes titles

histogram par_median, title("Histogram of Median Parental Income")
  
* 2. Write a sentence or two about the distribution of median parental income
* across colleges
* A: The distribution of par_median seems to be right skewed


*******
* Part 5: Bonus/Optional 
*******

* We covered the histogram command in lecture
* Another popular data visualization technique is a scatter plot 
* type "help scatter" and use the help file to 
* figure out how to construct a scatter plot with 
* par_median on the vertical (y-axis) and k_median on the horizontal (x-axis)

help scatter
scatter par_median k_median





 


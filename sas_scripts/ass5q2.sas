/* Luke Pritchard - Assignment 5 - Question 2 */

PROC IMPORT Datafile= '/folders/myshortcuts/3A03_-_Linear_Regression_with_SAS/Assignments/Assignment 5/Oil.txt'
	Out=Work.Oil
	DBMS=dlm;
	datarow=2;
	getnames=yes;
run;

Data Work.Oil;
	set work.oil;
	log_barrels = log(Barrels);
run;



PROC REG data=work.oil plots(only)=fitplot;
	Model Barrels = Year;
run;

PROC REG data=work.oil plots(only)=fitplot;
	Model log_barrels = Year;
run;

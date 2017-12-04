/* Luke Pritchard - Assignment 5 - Q4 */

* Question 4(a);

PROC IMPORT datafile='/folders/myshortcuts/3A03_-_Linear_Regression_with_SAS/Assignments/Assignment 5/Chromatography.txt'
	OUT=Work.Chromatography
	DBMS=dlm;
	getnames=yes;
	datarow=2;
run;
	
Data Work.Chromatography;
     Set Work.Chromatography;
     log_amount = log(Amount);
     log_output = log(Output);
run;

PROC REG Data=Work.Chromatography plots(only)=qqplot plots(only)=fitplot plots(only)=rstudentbypredicted;
    Model log_output = log_amount;
    Output Out = output_wool
         Predicted = predicted_values
         Student = student_residuals;
run;


* Question 4(b);
PROC MEANS Data=output_wool NWAY;
    CLASS Amount;
    VAR student_residuals;
    OUTPUT Out = temp
        Mean = Mean
        Var = Var;
run;

PROC PRINT Data=temp;
run;

Data temp;
    set temp;
    If (_N_ = 1) then call symput('var1', Var);
    If (_N_ = 2) then call symput('var2', Var);
    If (_N_ = 3) then call symput('var3', Var);
    If (_N_ = 4) then call symput('var4', Var);
run;

PROC MEANS Data=output_wool noprint;
     Var student_residuals;
     Output Out = temp
          Mean = Mean
	      Var = Var;
run;

Data temp;
    set temp;
    Call symput('vare', Var);
run;

Data output_wool;
    Set output_wool;
    If (Amount = 0.25) then var=&var1;
    If (Amount = 1) then var=&var2;
    If (Amount = 5) then var=&var3;
    If (Amount = 20) then var=&var4;
    w=&vare/var;
run;

* Question 4(c);
PROC REG Data=output_wool plots(only)=qqplot plots(only)=rstudentbypredicted;
    Model log_output = log_amount;
    Weight w;
run;

* Question 4(d);
Data output_wool;
    set output_wool;
    If Amount = 1 then Amt1 = 1;
    else Amt1 = 0;
    If Amount = 5 then Amt5 = 1;
    else Amt5 = 0;
    If Amount = 20 then Amt20 = 1;
    else Amt20 = 0;
run;


PROC REG Data=output_wool plots(only)=fitplot plots(only)=qqplot;
    Model log_output = Amt1 Amt5 Amt20;
run;

PROC REG Data=output_wool plots(only)=qqplot plots(only)=fitplot;
    Model log_output = Amt1 Amt5 Amt20;
    Weight w;
run;
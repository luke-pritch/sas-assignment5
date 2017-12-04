/*Luke Pritchard - Assignment 5 - Q1*/

PROC IMPORT DATAFILE='/folders/myshortcuts/3A03_-_Linear_Regression_with_SAS/Assignments/Assignment 5/Wool.txt'
	OUT=Work.Wool
	DBMS=DLM;
	getnames=yes;
	datarow=2;
run;

* Question 1(a);
PROC GLM Data=Work.Wool plots(only)=diagnostics plots(only)=residuals;
    Class Amp Len Load;
    Model Cycles = Amp Len Load;
run;

* Question 1(b);
PROC GLM Data=Work.Wool plots(only)=diagnostics plots(only)=residuals;
    Class Amp Len Load;
    Model Cycles = Amp Len Load Amp*Len Amp*Load Len*Load;
run;


* Question 1(c);
Data Work.Wool;
    Set Work.Wool;
	cycles_sqrt = sqrt(Cycles);
	cycles_squared = Cycles**2;
	cycles_log = log(Cycles);
run;

PROC GLM Data=Work.Wool plots=residuals;
    Class Amp Len Load;
    Model cycles_squared = Amp Len Load;
run;


PROC GLM Data=Work.Wool plots(only)=diagnostics plots(only)=residuals;
    Class Amp Len Load;
    Model cycles_sqrt = Amp Len Load;
run;

PROC GLM Data=Work.Wool plots(only)=diagnostics plots(only)=residuals;
    Class Amp Len Load;
    Model cycles_log = Amp Len Load;
run;


* Question 1(d);
PROC GLM Data=Work.Wool plots=none;
    Class Amp Len Load;
    Model cycles_log = Amp Len Load Amp*Len Amp*Load Len*Load;
run;
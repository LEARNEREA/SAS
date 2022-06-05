
/*BEFORE YOU START - Make sure to change the locations according to your system*/

LIBNAME LA "/home/u49504224/learnerea";
LIBNAME RPRTS "/home/u49504224/reports";

/*Producting list of all the styles in excel  */
ods excel file="/home/u49504224/excelFiles/styleLis.xlsx";
proc template;
	list styles;
run;
ods excel close;

/*Importing excel in sas  */
proc import datafile="/home/u49504224/excelFiles/styleLis.xlsx"
			out=la.style_list
			dbms=xlsx replace;
			datarow=5;
run;

/*Renaming variables and creating a separate variable for style names*/
data la.style_list2;
set la.style_list(keep=b c);
	STYLE_NAME = scan(b,2,".");
	
	rename	b=PATH
			C=TYPE;
	
	IF NOT MISSING(STYLE_NAME);
run;
	
/*Storing all the style names and count in the macro variables  */
PROC SQL NOPRINT;
	SELECT COUNT(distinct STYLE_NAME) INTO :STYLE_COUNT FROM LA.style_list2;
QUIT;

PROC SQL NOPRINT;
	SELECT DISTINCT(STYLE_NAME) INTO :STYLES1- FROM LA.style_list2;
QUIT;


/*Macro to get the list of scripts for all the scripts*/
%MACRO STYLE_SAMPLE;
%do	i = 1 %to &STYLE_COUNT.;
	
	%put &&styles&i.;
	
	PROC TEMPLATE;
		SOURCE STYLES.&&STYLES&i. /
			FILE="/home/u49504224/ods_style_scripts/&&STYLES&i...SAS";
	RUN;
%end;
%MEND;
%STYLE_SAMPLE;

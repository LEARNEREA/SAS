libname mylib "/home/u49504224/learnerea";

%macro automatedmerge(inlib=,inputds=,outputds=,byvar=);
	data &outputds.;
	merge %do i = 1 %to %sysfunc(countw(&inputds.));
			&inlib..%scan(&inputds., &i)
		  %end;;
%mend;

%automatedmerge(inlib=mylib, inputds=cars_msrp cars_engine cars_weight, outputds=combined, byvar=make model);




proc stdize data=mylib.cars_sample out=cars_sample missing=0 reponly;
	var length weight wheelbase;
run;

proc stdize data=mylib.cars_sample out=cars_sample_mean method=mean reponly;
	var length weight wheelbase;
run;
proc print data=cars_sample_mean; run;


proc stdize data=mylib.cars_sample out=cars_sample_mean method=median reponly;
	var length weight wheelbase;
run;
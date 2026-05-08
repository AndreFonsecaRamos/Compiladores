declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

@.str.int = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.double = private unnamed_addr constant [6 x i8] c"%.16e\00"
@.str.str = private unnamed_addr constant [3 x i8] c"%s\00"
@.str.true = private unnamed_addr constant [5 x i8] c"true\00"
@.str.false = private unnamed_addr constant [6 x i8] c"false\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"\0A\00"


define i32 @main(i32 %argc, i8** %argv) {
  %.args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %args = alloca i8**
  store i8** %.args_base, i8*** %args
  %.args_len_val = sub i32 %argc, 1
  %.args_length = alloca i32
  store i32 %.args_len_val, i32* %.args_length
  %i = alloca i32
  %j = alloca double
  %1 = add i32 0, 3
  store i32 %1, i32* %i
  %2 = add i32 0, 4
  %3 = sitofp i32 %2 to double
  store double %3, double* %j
  %4 = load i32, i32* %i
  %5 = load double, double* %j
  %6 = sitofp i32 %4 to double
  %7 = fadd double %6, %5
  store double %7, double* %j
  %8 = load i32, i32* %i
  %9 = load double, double* %j
  %10 = sitofp i32 %8 to double
  %11 = fdiv double %10, %9
  store double %11, double* %j
  %12 = load double, double* %j
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %12)
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  ret i32 0
}


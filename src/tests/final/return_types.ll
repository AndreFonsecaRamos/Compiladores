declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

@.str.int = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.double = private unnamed_addr constant [6 x i8] c"%.16e\00"
@.str.str = private unnamed_addr constant [3 x i8] c"%s\00"
@.str.true = private unnamed_addr constant [5 x i8] c"true\00"
@.str.false = private unnamed_addr constant [6 x i8] c"false\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.7 = private unnamed_addr constant [2 x i8] c"\0A\00"


define i32 @main(i32 %argc, i8** %argv) {
  %args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %uncommon_name = alloca i8**
  store i8** %args_base, i8*** %uncommon_name
  %args_len_val = sub i32 %argc, 1
  %uncommon_name_length = alloca i32
  store i32 %args_len_val, i32* %uncommon_name_length
  %d = alloca double
  %1 = call double @fun_double()
  store double %1, double* %d
  %2 = load double, double* %d
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %2)
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %5 = call i32 @fun_int()
  %6 = sitofp i32 %5 to double
  store double %6, double* %d
  %7 = load double, double* %d
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %7)
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %10 = call double @fun_double_from_int()
  store double %10, double* %d
  %11 = load double, double* %d
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %11)
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %14 = call double @fun_double_from_int_fun()
  store double %14, double* %d
  %15 = load double, double* %d
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %15)
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %18 = call double @fun_double_from_int_var()
  store double %18, double* %d
  %19 = load double, double* %d
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %19)
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %22 = load i8**, i8*** %uncommon_name
  %23 = load i32, i32* %uncommon_name_length
  %24 = call double @fun_double_from_args(i8** %22, i32 %23)
  store double %24, double* %d
  %25 = load double, double* %d
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %25)
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %28 = load i8**, i8*** %uncommon_name
  %29 = load i32, i32* %uncommon_name_length
  %30 = call double @fun_double_from_unary_plus(i8** %28, i32 %29)
  store double %30, double* %d
  %31 = load double, double* %d
  %32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %31)
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %34 = fadd double 0.0, 1.3
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %34)
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  ret i32 0
}

define double @fun_double() {
  %1 = fadd double 0.0, 1.1
  ret double %1
Ldead0:
  ret double 0.0
}

define i32 @fun_int() {
  %1 = add i32 0, 1
  ret i32 %1
Ldead1:
  ret i32 0
}

define double @fun_double_from_int() {
  %1 = add i32 0, 2
  %2 = sitofp i32 %1 to double
  ret double %2
Ldead2:
  ret double 0.0
}

define double @fun_double_from_int_fun() {
  %1 = call i32 @fun_int()
  %2 = sitofp i32 %1 to double
  ret double %2
Ldead3:
  ret double 0.0
}

define double @fun_double_from_int_var() {
  %d = alloca double
  %1 = add i32 0, 0
  %2 = sitofp i32 %1 to double
  store double %2, double* %d
  %3 = load double, double* %d
  %4 = call i32 @fun_int()
  %5 = sitofp i32 %4 to double
  %6 = fadd double %3, %5
  %7 = call double @fun_double()
  %8 = fadd double %6, %7
  ret double %8
Ldead4:
  ret double 0.0
}

define double @fun_double_from_args(i8** %arg_str_arr, i32 %arg_str_arr_len) {
  %str_arr = alloca i8**
  store i8** %arg_str_arr, i8*** %str_arr
  %str_arr_length = alloca i32
  store i32 %arg_str_arr_len, i32* %str_arr_length
  %1 = load i32, i32* %str_arr_length
  %2 = sitofp i32 %1 to double
  ret double %2
Ldead5:
  ret double 0.0
}

define double @fun_double_from_unary_plus(i8** %arg_str_arr, i32 %arg_str_arr_len) {
  %str_arr = alloca i8**
  store i8** %arg_str_arr, i8*** %str_arr
  %str_arr_length = alloca i32
  store i32 %arg_str_arr_len, i32* %str_arr_length
  %1 = add i32 0, 1
  %2 = sitofp i32 %1 to double
  ret double %2
Ldead6:
  ret double 0.0
}


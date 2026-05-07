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
@.str.3 = private unnamed_addr constant [22 x i8] c"Teste\09de \0Cstring\5C\22\0D%%\00"
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.7 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.8 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.10 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.11 = private unnamed_addr constant [2 x i8] c"\0A\00"

@a = global i32 0
@b = global i32 0
@c = global i32 0
@d = global i32 0

define i32 @main(i32 %argc, i8** %argv) {
  %args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %args = alloca i8**
  store i8** %args_base, i8*** %args
  %args_len_val = sub i32 %argc, 1
  %args_length = alloca i32
  store i32 %args_len_val, i32* %args_length
  %i = alloca i32
  %a = alloca i32
  %i1 = alloca i32
  %i2 = alloca i32
  %i3 = alloca i32
  %d = alloca double
  %1 = alloca i1
  %2 = alloca i1
  %3 = add i32 0, 2
  store i32 %3, i32* %a
  %4 = load i32, i32* %a
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %4)
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %7 = add i32 0, 0
  %8 = add i32 0, 3
  %9 = add i32 %7, %8
  store i32 %9, i32* %a
  %10 = sitofp i32 %9 to double
  store double %10, double* %d
  %11 = load i32, i32* %a
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %11)
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %14 = load double, double* %d
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %14)
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.3, i32 0, i32 0))
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %19 = load i32, i32* %a
  %20 = add i32 0, 1
  %21 = add i32 %19, %20
  store i32 %21, i32* %a
  %22 = add i32 0, 0
  %23 = icmp sgt i32 %21, %22
  br i1 %23, label %Lor_short_0, label %Lor_eval_0
Lor_eval_0:
  %24 = load i32, i32* %a
  %25 = add i32 0, 3
  %26 = add i32 %24, %25
  store i32 %26, i32* %a
  %27 = add i32 0, 0
  %28 = icmp sgt i32 %26, %27
  store i1 %28, i1* %1
  br label %Lor_end_0
Lor_short_0:
  store i1 1, i1* %1
  br label %Lor_end_0
Lor_end_0:
  %29 = load i1, i1* %1
  br i1 %29, label %L1, label %L2
L1:
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.true, i32 0, i32 0))
  br label %L3
L2:
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.false, i32 0, i32 0))
  br label %L3
L3:
  %32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %33 = load i32, i32* %a
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %33)
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %36 = load i32, i32* %a
  %37 = add i32 0, 1
  %38 = add i32 %36, %37
  store i32 %38, i32* %a
  %39 = add i32 0, 0
  %40 = icmp slt i32 %38, %39
  br i1 %40, label %Land_eval_4, label %Land_short_4
Land_eval_4:
  %41 = load i32, i32* %a
  %42 = add i32 0, 3
  %43 = add i32 %41, %42
  store i32 %43, i32* %a
  %44 = add i32 0, 0
  %45 = icmp slt i32 %43, %44
  store i1 %45, i1* %2
  br label %Land_end_4
Land_short_4:
  store i1 0, i1* %2
  br label %Land_end_4
Land_end_4:
  %46 = load i1, i1* %2
  br i1 %46, label %L5, label %L6
L5:
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.true, i32 0, i32 0))
  br label %L7
L6:
  %48 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.false, i32 0, i32 0))
  br label %L7
L7:
  %49 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %50 = load i32, i32* %a
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %50)
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %53 = fadd double 0.0, 123.0e-10
  store double %53, double* %d
  %54 = load double, double* %d
  %55 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %54)
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %57 = fadd double 0.0, 0.0e-10
  store double %57, double* %d
  %58 = load double, double* %d
  %59 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %58)
  %60 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %61 = fadd double 0.0, 1.e01
  store double %61, double* %d
  %62 = load double, double* %d
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %62)
  %64 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  ret i32 0
}


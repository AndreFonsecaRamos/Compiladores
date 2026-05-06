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

@b = global i1 0

define i32 @main(i32 %argc, i8** %argv) {
  %args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %args = alloca i8**
  store i8** %args_base, i8*** %args
  %args_len_val = sub i32 %argc, 1
  %args_length = alloca i32
  store i32 %args_len_val, i32* %args_length
  %1 = add i1 0, 1
  %2 = xor i1 %1, 1
  store i1 %2, i1* @b
  %3 = load i1, i1* @b
  %4 = xor i1 %3, 1
  %5 = xor i1 %4, 1
  %6 = xor i1 %5, 1
  %7 = xor i1 %6, 1
  %8 = xor i1 %7, 1
  %9 = xor i1 %8, 1
  %10 = xor i1 %9, 1
  br i1 %10, label %L0, label %L1
L0:
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.true, i32 0, i32 0))
  br label %L2
L1:
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.false, i32 0, i32 0))
  br label %L2
L2:
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %14 = fadd double 0.0, 420.0
  %15 = fmul double %14, -1.0
  %16 = fmul double %15, -1.0
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %16)
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %19 = add i32 0, 420
  %20 = mul i32 %19, -1
  %21 = mul i32 %20, -1
  %22 = mul i32 %21, -1
  %23 = mul i32 %22, -1
  %24 = mul i32 %23, -1
  %25 = add i32 0, 421
  %26 = mul i32 %25, -1
  %27 = icmp sgt i32 %24, %26
  %28 = xor i1 %27, 1
  br i1 %28, label %L3, label %L4
L3:
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.true, i32 0, i32 0))
  br label %L5
L4:
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.false, i32 0, i32 0))
  br label %L5
L5:
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %32 = add i1 0, 0
  %33 = call i1 @falseB()
  %34 = icmp eq i1 %32, %33
  %35 = xor i1 %34, 1
  br i1 %35, label %L6, label %L7
L6:
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.true, i32 0, i32 0))
  br label %L8
L7:
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.false, i32 0, i32 0))
  br label %L8
L8:
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %39 = add i32 0, 1
  %40 = add i32 0, 1
  %41 = sub i32 %39, %40
  %42 = add i32 0, 0
  %43 = add i32 %41, %42
  %44 = mul i32 %43, -1
  %45 = mul i32 %44, -1
  %46 = load i8**, i8*** %args
  %47 = getelementptr inbounds i8*, i8** %46, i32 %45
  %48 = load i8*, i8** %47
  %49 = call i32 @atoi(i8* %48)
  %50 = mul i32 %49, -1
  %51 = mul i32 %50, -1
  %52 = mul i32 %51, -1
  %53 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %52)
  %54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  ret i32 0
}

define i1 @falseB() {
  %1 = add i1 0, 1
  %2 = xor i1 %1, 1
  ret i1 %2
Ldead9:
  ret i1 0
}


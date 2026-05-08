declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

@.str.int = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.double = private unnamed_addr constant [6 x i8] c"%.16e\00"
@.str.str = private unnamed_addr constant [3 x i8] c"%s\00"
@.str.true = private unnamed_addr constant [5 x i8] c"true\00"
@.str.false = private unnamed_addr constant [6 x i8] c"false\00"
@.str.0 = private unnamed_addr constant [10 x i8] c"Is pair: \00"
@.str.1 = private unnamed_addr constant [3 x i8] c"|\0A\00"
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00"


define i32 @b(i32 %.arg_input) {
  %input = alloca i32
  store i32 %.arg_input, i32* %input
  %k = alloca i32
  %i = alloca i32
  %g = alloca i32
  %is_pair = alloca i32
  %1 = add i32 0, 0
  store i32 %1, i32* %k
  %2 = add i32 0, 0
  store i32 %2, i32* %i
  %3 = add i32 0, 0
  store i32 %3, i32* %g
  %4 = add i32 0, 0
  store i32 %4, i32* %is_pair
  br label %L0
L0:
  %5 = load i32, i32* %k
  %6 = add i32 0, 5
  %7 = icmp slt i32 %5, %6
  br i1 %7, label %L1, label %L2
L1:
  %8 = load i32, i32* %k
  %9 = add i32 0, 1
  %10 = icmp eq i32 %8, %9
  br i1 %10, label %L3, label %L4
L3:
  %11 = load i32, i32* %input
  %12 = add i32 0, 2
  %13 = sub i32 %11, %12
  store i32 %13, i32* %input
  %14 = add i32 0, 0
  store i32 %14, i32* %i
  %15 = add i32 0, 0
  store i32 %15, i32* %g
  br label %L6
L6:
  %16 = load i32, i32* %i
  %17 = add i32 0, 100
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %L7, label %L8
L7:
  br label %L9
L9:
  %19 = load i32, i32* %g
  %20 = add i32 0, 50
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %L10, label %L11
L10:
  %22 = load i32, i32* %input
  %23 = add i32 0, 2
  %24 = add i32 %22, %23
  store i32 %24, i32* %input
  %25 = load i32, i32* %g
  %26 = add i32 0, 2
  %27 = srem i32 %25, %26
  %28 = add i32 0, 0
  %29 = icmp eq i32 %27, %28
  br i1 %29, label %L12, label %L13
L12:
  %30 = load i32, i32* %is_pair
  %31 = add i32 0, 1
  %32 = add i32 %30, %31
  store i32 %32, i32* %is_pair
  br label %L14
L13:
  br label %L14
L14:
  %33 = load i32, i32* %g
  %34 = add i32 0, 1
  %35 = add i32 %33, %34
  store i32 %35, i32* %g
  br label %L9
L11:
  %36 = add i32 0, 0
  store i32 %36, i32* %g
  %37 = load i32, i32* %i
  %38 = add i32 0, 1
  %39 = add i32 %37, %38
  store i32 %39, i32* %i
  br label %L6
L8:
  br label %L5
L4:
  %40 = load i32, i32* %k
  %41 = add i32 0, 2
  %42 = icmp eq i32 %40, %41
  br i1 %42, label %L15, label %L16
L15:
  %43 = load i32, i32* %input
  %44 = add i32 0, 3
  %45 = mul i32 %43, %44
  store i32 %45, i32* %input
  br label %L17
L16:
  br label %L17
L17:
  br label %L5
L5:
  %46 = load i32, i32* %k
  %47 = add i32 0, 1
  %48 = add i32 %46, %47
  store i32 %48, i32* %k
  br label %L0
L2:
  %49 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.0, i32 0, i32 0))
  %50 = load i32, i32* %is_pair
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %50)
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i32 0, i32 0))
  %53 = load i32, i32* %input
  ret i32 %53
Ldead18:
  ret i32 0
}

define i32 @main(i32 %argc, i8** %argv) {
  %.args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %args = alloca i8**
  store i8** %.args_base, i8*** %args
  %.args_len_val = sub i32 %argc, 1
  %.args_length = alloca i32
  store i32 %.args_len_val, i32* %.args_length
  %aux1 = alloca i32
  %1 = add i32 0, 40
  store i32 %1, i32* %aux1
  %2 = load i32, i32* %aux1
  %3 = call i32 @b(i32 %2)
  store i32 %3, i32* %aux1
  %4 = add i32 0, 0
  %5 = load i8**, i8*** %args
  %6 = getelementptr inbounds i8*, i8** %5, i32 %4
  %7 = load i8*, i8** %6
  %8 = call i32 @atoi(i8* %7)
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %8)
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  ret i32 0
}


declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

@.str.int = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.double = private unnamed_addr constant [6 x i8] c"%.16e\00"
@.str.str = private unnamed_addr constant [3 x i8] c"%s\00"
@.str.true = private unnamed_addr constant [5 x i8] c"true\00"
@.str.false = private unnamed_addr constant [6 x i8] c"false\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00"


define i32 @a(i32 %.arg_input) {
  %input = alloca i32
  store i32 %.arg_input, i32* %input
  %i = alloca i32
  %1 = add i32 0, 0
  store i32 %1, i32* %i
  br label %L0
L0:
  %2 = load i32, i32* %i
  %3 = add i32 0, 10
  %4 = icmp slt i32 %2, %3
  br i1 %4, label %L1, label %L2
L1:
  %5 = load i32, i32* %input
  %6 = add i32 0, 2
  %7 = add i32 %5, %6
  store i32 %7, i32* %input
  %8 = load i32, i32* %i
  %9 = add i32 0, 1
  %10 = add i32 %8, %9
  store i32 %10, i32* %i
  br label %L0
L2:
  %11 = load i32, i32* %input
  ret i32 %11
Ldead3:
  ret i32 0
}

define i32 @b(i32 %.arg_input) {
  %input = alloca i32
  store i32 %.arg_input, i32* %input
  %k = alloca i32
  %1 = add i32 0, 0
  store i32 %1, i32* %k
  br label %L4
L4:
  %2 = load i32, i32* %k
  %3 = add i32 0, 5
  %4 = icmp slt i32 %2, %3
  br i1 %4, label %L5, label %L6
L5:
  %5 = load i32, i32* %k
  %6 = add i32 0, 1
  %7 = icmp eq i32 %5, %6
  br i1 %7, label %L7, label %L8
L7:
  %8 = load i32, i32* %input
  %9 = add i32 0, 2
  %10 = sub i32 %8, %9
  store i32 %10, i32* %input
  br label %L9
L8:
  %11 = load i32, i32* %k
  %12 = add i32 0, 2
  %13 = icmp eq i32 %11, %12
  br i1 %13, label %L10, label %L11
L10:
  %14 = load i32, i32* %input
  %15 = add i32 0, 3
  %16 = mul i32 %14, %15
  store i32 %16, i32* %input
  br label %L12
L11:
  br label %L12
L12:
  br label %L9
L9:
  %17 = load i32, i32* %k
  %18 = add i32 0, 1
  %19 = add i32 %17, %18
  store i32 %19, i32* %k
  br label %L4
L6:
  %20 = load i32, i32* %input
  ret i32 %20
Ldead13:
  ret i32 0
}

define i32 @main(i32 %argc, i8** %argv) {
  %.args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %args = alloca i8**
  store i8** %.args_base, i8*** %args
  %.args_len_val = sub i32 %argc, 1
  %.args_length = alloca i32
  store i32 %.args_len_val, i32* %.args_length
  %input = alloca i32
  %aux = alloca i32
  %aux1 = alloca i32
  %1 = add i32 0, 0
  store i32 %1, i32* %aux
  %2 = add i32 0, 0
  store i32 %2, i32* %aux1
  %3 = add i32 0, 0
  %4 = load i8**, i8*** %args
  %5 = getelementptr inbounds i8*, i8** %4, i32 %3
  %6 = load i8*, i8** %5
  %7 = call i32 @atoi(i8* %6)
  store i32 %7, i32* %input
  %8 = load i32, i32* %input
  %9 = add i32 0, 10
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %L14, label %L15
L14:
  %11 = load i32, i32* %input
  %12 = call i32 @a(i32 %11)
  store i32 %12, i32* %aux
  br label %L16
L15:
  %13 = load i32, i32* %input
  %14 = call i32 @b(i32 %13)
  store i32 %14, i32* %aux1
  br label %L16
L16:
  %15 = load i32, i32* %aux
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %15)
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %18 = load i32, i32* %aux1
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %18)
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  ret i32 0
}


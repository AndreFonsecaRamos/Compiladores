declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

@.str.int = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.double = private unnamed_addr constant [6 x i8] c"%.16e\00"
@.str.str = private unnamed_addr constant [3 x i8] c"%s\00"
@.str.true = private unnamed_addr constant [5 x i8] c"true\00"
@.str.false = private unnamed_addr constant [6 x i8] c"false\00"
@.str.0 = private unnamed_addr constant [7 x i8] c"\0D\5C\22\0C\09\0A\00"
@.str.1 = private unnamed_addr constant [22 x i8] c"Number of arguments:\09\00"
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.3 = private unnamed_addr constant [6 x i8] c"Arg (\00"
@.str.4 = private unnamed_addr constant [4 x i8] c"): \00"
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.6 = private unnamed_addr constant [16 x i8] c"No arguments :(\00"
@.str.7 = private unnamed_addr constant [2 x i8] c"\0A\00"

@i = global i32 0

define i32 @main(i32 %argc, i8** %argv) {
  %args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %args = alloca i8**
  store i8** %args_base, i8*** %args
  %args_len_val = sub i32 %argc, 1
  %args_length = alloca i32
  store i32 %args_len_val, i32* %args_length
  %a = alloca i32
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.0, i32 0, i32 0))
  %2 = load i32, i32* %args_length
  store i32 %2, i32* %a
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.1, i32 0, i32 0))
  %4 = load i32, i32* %a
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %4)
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %7 = load i32, i32* %a
  %8 = add i32 0, 0
  %9 = icmp sgt i32 %7, %8
  br i1 %9, label %L0, label %L1
L0:
  br label %L3
L3:
  %10 = load i32, i32* %a
  %11 = add i32 0, 1
  %12 = add i32 %10, %11
  %13 = load i32, i32* @i
  %14 = add i32 0, 1
  %15 = add i32 %13, %14
  store i32 %15, i32* @i
  %16 = icmp sgt i32 %12, %15
  br i1 %16, label %L4, label %L5
L4:
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i32 0, i32 0))
  %18 = load i32, i32* @i
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %18)
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i32 0, i32 0))
  %21 = load i32, i32* @i
  %22 = add i32 0, 1
  %23 = sub i32 %21, %22
  %24 = load i8**, i8*** %args
  %25 = getelementptr inbounds i8*, i8** %24, i32 %23
  %26 = load i8*, i8** %25
  %27 = call i32 @atoi(i8* %26)
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %27)
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  br label %L3
L5:
  br label %L2
L1:
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i32 0, i32 0))
  br label %L2
L2:
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  ret i32 0
}


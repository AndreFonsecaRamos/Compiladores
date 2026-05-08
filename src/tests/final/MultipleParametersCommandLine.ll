declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

@.str.int = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.double = private unnamed_addr constant [6 x i8] c"%.16e\00"
@.str.str = private unnamed_addr constant [3 x i8] c"%s\00"
@.str.true = private unnamed_addr constant [5 x i8] c"true\00"
@.str.false = private unnamed_addr constant [6 x i8] c"false\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00"


define i32 @main(i32 %argc, i8** %argv) {
  %.args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %args = alloca i8**
  store i8** %.args_base, i8*** %args
  %.args_len_val = sub i32 %argc, 1
  %.args_length = alloca i32
  store i32 %.args_len_val, i32* %.args_length
  %arg1 = alloca i32
  %arg2 = alloca i32
  %1 = add i32 0, 0
  %2 = load i8**, i8*** %args
  %3 = getelementptr inbounds i8*, i8** %2, i32 %1
  %4 = load i8*, i8** %3
  %5 = call i32 @atoi(i8* %4)
  store i32 %5, i32* %arg1
  %6 = add i32 0, 1
  %7 = load i8**, i8*** %args
  %8 = getelementptr inbounds i8*, i8** %7, i32 %6
  %9 = load i8*, i8** %8
  %10 = call i32 @atoi(i8* %9)
  store i32 %10, i32* %arg2
  %11 = load i32, i32* %arg1
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %11)
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  %14 = load i32, i32* %arg2
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %14)
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.0, i32 0, i32 0))
  ret i32 0
}


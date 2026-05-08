declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

@.str.int = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.double = private unnamed_addr constant [6 x i8] c"%.16e\00"
@.str.str = private unnamed_addr constant [3 x i8] c"%s\00"
@.str.true = private unnamed_addr constant [5 x i8] c"true\00"
@.str.false = private unnamed_addr constant [6 x i8] c"false\00"
@.str.0 = private unnamed_addr constant [19 x i8] c"I have a parameter\00"
@.str.1 = private unnamed_addr constant [25 x i8] c"I don't have a parameter\00"
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00"

@overload = global i32 0

define void @overload__i32(i32 %.arg_n) {
  %n = alloca i32
  store i32 %.arg_n, i32* %n
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.0, i32 0, i32 0))
  ret void
}

define void @overload__() {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.1, i32 0, i32 0))
  ret void
}

define i32 @main(i32 %argc, i8** %argv) {
  %.args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %args = alloca i8**
  store i8** %.args_base, i8*** %args
  %.args_len_val = sub i32 %argc, 1
  %.args_length = alloca i32
  store i32 %.args_len_val, i32* %.args_length
  %1 = load i32, i32* %.args_length
  %2 = add i32 0, 0
  %3 = icmp sgt i32 %1, %2
  br i1 %3, label %L0, label %L1
L0:
  %4 = add i32 0, 0
  %5 = load i8**, i8*** %args
  %6 = getelementptr inbounds i8*, i8** %5, i32 %4
  %7 = load i8*, i8** %6
  %8 = call i32 @atoi(i8* %7)
  call void @overload__i32(i32 %8)
  br label %L2
L1:
  call void @overload__()
  br label %L2
L2:
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  ret i32 0
}


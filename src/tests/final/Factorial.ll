declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

@.str.int = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.double = private unnamed_addr constant [6 x i8] c"%.16e\00"
@.str.str = private unnamed_addr constant [3 x i8] c"%s\00"
@.str.true = private unnamed_addr constant [5 x i8] c"true\00"
@.str.false = private unnamed_addr constant [6 x i8] c"false\00"


define i32 @factorial(i32 %.arg_n) {
  %n = alloca i32
  store i32 %.arg_n, i32* %n
  %1 = load i32, i32* %n
  %2 = add i32 0, 0
  %3 = icmp eq i32 %1, %2
  br i1 %3, label %L0, label %L1
L0:
  %4 = add i32 0, 1
  ret i32 %4
Ldead3:
  br label %L2
L1:
  br label %L2
L2:
  %5 = load i32, i32* %n
  %6 = load i32, i32* %n
  %7 = add i32 0, 1
  %8 = sub i32 %6, %7
  %9 = call i32 @factorial(i32 %8)
  %10 = mul i32 %5, %9
  ret i32 %10
Ldead4:
  ret i32 0
}

define i32 @main(i32 %argc, i8** %argv) {
  %.args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %args = alloca i8**
  store i8** %.args_base, i8*** %args
  %.args_len_val = sub i32 %argc, 1
  %.args_length = alloca i32
  store i32 %.args_len_val, i32* %.args_length
  %argument = alloca i32
  %1 = add i32 0, 7
  store i32 %1, i32* %argument
  %2 = load i32, i32* %argument
  %3 = call i32 @factorial(i32 %2)
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %3)
  ret i32 0
}


declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

@.str.int = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.double = private unnamed_addr constant [6 x i8] c"%.16e\00"
@.str.str = private unnamed_addr constant [3 x i8] c"%s\00"
@.str.true = private unnamed_addr constant [5 x i8] c"true\00"
@.str.false = private unnamed_addr constant [6 x i8] c"false\00"


define i32 @a(i32 %arg_input) {
  %input = alloca i32
  store i32 %arg_input, i32* %input
  %1 = load i32, i32* %input
  ret i32 %1
Ldead0:
  ret i32 0
}

define i32 @b(i32 %arg_input) {
  %input = alloca i32
  store i32 %arg_input, i32* %input
  %1 = load i32, i32* %input
  ret i32 %1
Ldead1:
  ret i32 0
}

define i32 @main(i32 %argc, i8** %argv) {
entry:
  ret i32 0
}

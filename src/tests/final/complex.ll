declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

@.str.int = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.double = private unnamed_addr constant [6 x i8] c"%.16e\00"
@.str.str = private unnamed_addr constant [3 x i8] c"%s\00"
@.str.true = private unnamed_addr constant [5 x i8] c"true\00"
@.str.false = private unnamed_addr constant [6 x i8] c"false\00"
@.str.0 = private unnamed_addr constant [20 x i8] c"I have two doubles\0A\00"
@.str.1 = private unnamed_addr constant [19 x i8] c"I have one double\0A\00"
@.str.2 = private unnamed_addr constant [16 x i8] c"I have one int\0A\00"
@.str.3 = private unnamed_addr constant [19 x i8] c"I'm the fake main\0A\00"
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.5 = private unnamed_addr constant [5 x i8] c"\0Aa:\0A\00"
@.str.6 = private unnamed_addr constant [11 x i8] c"Before if\0A\00"
@.str.7 = private unnamed_addr constant [11 x i8] c"After ifs\0A\00"
@.str.8 = private unnamed_addr constant [11 x i8] c"After ifs\0A\00"
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.10 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.11 = private unnamed_addr constant [14 x i8] c"Before while\0A\00"

@overload = global i32 0

define i1 @overload__i1(i1 %arg_n) {
  %n = alloca i1
  store i1 %arg_n, i1* %n
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.0, i32 0, i32 0))
  %2 = add i1 0, 0
  ret i1 %2
Ldead0:
  ret i1 0
}

define double @overload__double(double %arg_n) {
  %n = alloca double
  store double %arg_n, double* %n
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  %2 = fadd double 0.0, 2.2
  %3 = add i32 0, 2
  %4 = sitofp i32 %3 to double
  %5 = fmul double %2, %4
  %6 = add i32 0, 2
  %7 = call i32 @main__i32(i32 %6)
  %8 = add i32 0, 5
  %9 = sdiv i32 %7, %8
  %10 = add i32 0, 6
  %11 = mul i32 %9, %10
  %12 = sitofp i32 %11 to double
  %13 = fadd double %5, %12
  %14 = add i32 0, 2
  %15 = add i32 0, 3
  %16 = mul i32 %14, %15
  %17 = sitofp i32 %16 to double
  %18 = fadd double %13, %17
  %19 = add i32 0, 3
  %20 = add i32 0, 4
  %21 = mul i32 %19, %20
  %22 = sitofp i32 %21 to double
  %23 = fadd double %18, %22
  %24 = add i32 0, 2
  %25 = add i32 0, 8
  %26 = mul i32 %24, %25
  %27 = sitofp i32 %26 to double
  %28 = fadd double %23, %27
  %29 = add i32 0, 5
  %30 = add i32 0, 9
  %31 = mul i32 %29, %30
  %32 = sitofp i32 %31 to double
  %33 = fadd double %28, %32
  %34 = add i32 0, 2
  %35 = add i32 0, 2
  %36 = call i32 @overload__i32_i32(i32 %34, i32 %35)
  %37 = sitofp i32 %36 to double
  %38 = fadd double %33, %37
  ret double %38
Ldead1:
  ret double 0.0
}

define i32 @overload__double_double(double %arg_b, double %arg_b1) {
  %b = alloca double
  store double %arg_b, double* %b
  %b1 = alloca double
  store double %arg_b1, double* %b1
  %overload = alloca double
  %1 = add i32 0, 2
  %2 = load i32, i32* @overload
  %3 = add i32 %1, %2
  store i32 %3, i32* @overload
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i32 0, i32 0))
  %5 = add i32 0, 5
  ret i32 %5
Ldead2:
  ret i32 0
}

define i32 @overload__i32_i32(i32 %arg_b, i32 %arg_b1) {
  %b = alloca i32
  store i32 %arg_b, i32* %b
  %b1 = alloca i32
  store i32 %arg_b1, i32* %b1
  %1 = add i32 0, 5
  ret i32 %1
Ldead3:
  ret i32 0
}

define i32 @main__i32(i32 %arg_n) {
  %n = alloca i32
  store i32 %arg_n, i32* %n
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.3, i32 0, i32 0))
  %2 = add i32 0, 5
  ret i32 %2
Ldead4:
  ret i32 0
}

define i32 @main(i32 %argc, i8** %argv) {
  %args_base = getelementptr inbounds i8*, i8** %argv, i32 1
  %args = alloca i8**
  store i8** %args_base, i8*** %args
  %args_len_val = sub i32 %argc, 1
  %args_length = alloca i32
  store i32 %args_len_val, i32* %args_length
  %a = alloca i32
  %d = alloca double
  %b = alloca i32
  %b1 = alloca i1
  %d1 = alloca double
  %i = alloca i32
  %j = alloca i32
  %1 = load i32, i32* %args_length
  %2 = add i32 0, 0
  %3 = icmp sgt i32 %1, %2
  br i1 %3, label %L5, label %L6
L5:
  %4 = add i32 0, 0
  %5 = load i8**, i8*** %args
  %6 = getelementptr inbounds i8*, i8** %5, i32 %4
  %7 = load i8*, i8** %6
  %8 = call i32 @atoi(i8* %7)
  %9 = sitofp i32 %8 to double
  %10 = call double @overload__double(double %9)
  br label %L7
L6:
  %11 = add i32 0, 5
  %12 = sitofp i32 %11 to double
  %13 = call double @overload__double(double %12)
  br label %L7
L7:
  %14 = add i1 0, 0
  %15 = xor i1 %14, 1
  br i1 %15, label %L8, label %L9
L8:
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.true, i32 0, i32 0))
  br label %L10
L9:
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.false, i32 0, i32 0))
  br label %L10
L10:
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  %19 = add i32 0, 2222222
  store i32 %19, i32* %a
  %20 = fadd double 0.0, 23232332.0e1
  store double %20, double* %d
  %21 = add i32 0, 3
  store i32 %21, i32* %b
  %22 = load i32, i32* %a
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %22)
  %24 = add i1 0, 1
  store i1 %24, i1* %b1
  %25 = load i32, i32* %a
  %26 = load i32, i32* %a
  %27 = add i32 %25, %26
  %28 = load i32, i32* %a
  %29 = add i32 %27, %28
  %30 = add i32 0, 8
  %31 = add i32 0, 2
  %32 = srem i32 %30, %31
  %33 = add i32 %29, %32
  %34 = load double, double* %d
  %35 = add i32 0, 3
  %36 = sitofp i32 %35 to double
  %37 = fdiv double %34, %36
  %38 = sitofp i32 %33 to double
  %39 = fadd double %38, %37
  %40 = load i32, i32* %a
  %41 = load double, double* %d
  %42 = sitofp i32 %40 to double
  %43 = fmul double %42, %41
  %44 = fadd double %39, %43
  %45 = load double, double* %d
  %46 = fadd double %44, %45
  %47 = load i32, i32* %a
  %48 = sitofp i32 %47 to double
  %49 = fsub double %46, %48
  %50 = load i32, i32* %a
  %51 = load i32, i32* %b
  %52 = mul i32 %50, %51
  %53 = load double, double* %d
  %54 = sitofp i32 %52 to double
  %55 = fdiv double %54, %53
  %56 = load i32, i32* %a
  %57 = load i32, i32* %b
  %58 = mul i32 %56, %57
  %59 = load double, double* %d
  %60 = sitofp i32 %58 to double
  %61 = fdiv double %60, %59
  %62 = fmul double %55, %61
  %63 = fadd double %49, %62
  %64 = fadd double 0.0, 2.2
  %65 = call double @overload__double(double %64)
  %66 = fadd double %63, %65
  %67 = add i32 0, 1
  %68 = add i32 0, 1
  %69 = call i32 @overload__i32_i32(i32 %67, i32 %68)
  %70 = sitofp i32 %69 to double
  store double %70, double* %d
  %71 = fadd double %66, %70
  %72 = add i32 0, 5
  %73 = call i32 @main__i32(i32 %72)
  %74 = sitofp i32 %73 to double
  %75 = fadd double %71, %74
  %76 = load i32, i32* %args_length
  %77 = add i32 0, 1
  %78 = sub i32 %76, %77
  %79 = load i8**, i8*** %args
  %80 = getelementptr inbounds i8*, i8** %79, i32 %78
  %81 = load i8*, i8** %80
  %82 = call i32 @atoi(i8* %81)
  %83 = sitofp i32 %82 to double
  %84 = fadd double %75, %83
  %85 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %84)
  %86 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.5, i32 0, i32 0))
  %87 = load i32, i32* %a
  %88 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %87)
  %89 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.6, i32 0, i32 0))
  %90 = load i32, i32* %a
  %91 = add i32 0, 2
  %92 = add i32 0, 2
  %93 = mul i32 %91, %92
  %94 = add i32 0, 3
  %95 = add i32 0, 5
  %96 = sdiv i32 %94, %95
  %97 = add i32 %93, %96
  %98 = add i32 0, 5
  %99 = call i32 @main__i32(i32 %98)
  %100 = add i32 %97, %99
  %101 = icmp sge i32 %90, %100
  br i1 %101, label %L11, label %L12
L11:
  %102 = load i32, i32* %a
  %103 = add i32 0, 2
  %104 = icmp sle i32 %102, %103
  br i1 %104, label %L14, label %L15
L14:
  %105 = add i32 0, 2
  %106 = load i32, i32* %a
  %107 = icmp sge i32 %105, %106
  br i1 %107, label %L17, label %L18
L17:
  %108 = add i32 0, 2
  %109 = load i32, i32* %a
  %110 = icmp sle i32 %108, %109
  br i1 %110, label %L20, label %L21
L20:
  %111 = load i32, i32* %a
  %112 = add i32 0, 2
  %113 = icmp eq i32 %111, %112
  br i1 %113, label %L23, label %L24
L23:
  %114 = add i32 0, 2
  %115 = load i32, i32* %a
  %116 = icmp eq i32 %114, %115
  br i1 %116, label %L26, label %L27
L26:
  %117 = load i32, i32* %a
  %118 = add i32 0, 2
  %119 = icmp sgt i32 %117, %118
  br i1 %119, label %L29, label %L30
L29:
  %120 = load i32, i32* %a
  %121 = add i32 0, 2
  %122 = icmp slt i32 %120, %121
  br i1 %122, label %L32, label %L33
L32:
  %123 = add i32 0, 2
  %124 = load i32, i32* %a
  %125 = icmp sgt i32 %123, %124
  br i1 %125, label %L35, label %L36
L35:
  %126 = add i32 0, 2
  %127 = load i32, i32* %a
  %128 = icmp slt i32 %126, %127
  br i1 %128, label %L38, label %L39
L38:
  %129 = load i32, i32* %a
  %130 = add i32 0, 2
  %131 = icmp ne i32 %129, %130
  br i1 %131, label %L41, label %L42
L41:
  %132 = add i32 0, 2
  %133 = load i32, i32* %a
  %134 = icmp ne i32 %132, %133
  br i1 %134, label %L44, label %L45
L44:
  br label %L46
L45:
  br label %L46
L46:
  br label %L43
L42:
  br label %L43
L43:
  br label %L40
L39:
  br label %L40
L40:
  br label %L37
L36:
  br label %L37
L37:
  br label %L34
L33:
  br label %L34
L34:
  br label %L31
L30:
  br label %L31
L31:
  br label %L28
L27:
  br label %L28
L28:
  br label %L25
L24:
  br label %L25
L25:
  br label %L22
L21:
  br label %L22
L22:
  br label %L19
L18:
  br label %L19
L19:
  br label %L16
L15:
  br label %L16
L16:
  br label %L13
L12:
  br label %L13
L13:
  %135 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.7, i32 0, i32 0))
  %136 = load double, double* %d
  %137 = add i32 0, 2
  %138 = sitofp i32 %137 to double
  %139 = fcmp oge double %136, %138
  br i1 %139, label %L47, label %L48
L47:
  %140 = load double, double* %d
  %141 = add i32 0, 2
  %142 = sitofp i32 %141 to double
  %143 = fcmp ole double %140, %142
  br i1 %143, label %L50, label %L51
L50:
  %144 = add i32 0, 2
  %145 = load double, double* %d
  %146 = sitofp i32 %144 to double
  %147 = fcmp oge double %146, %145
  br i1 %147, label %L53, label %L54
L53:
  %148 = add i32 0, 2
  %149 = load double, double* %d
  %150 = sitofp i32 %148 to double
  %151 = fcmp ole double %150, %149
  br i1 %151, label %L56, label %L57
L56:
  %152 = load double, double* %d
  %153 = add i32 0, 2
  %154 = sitofp i32 %153 to double
  %155 = fcmp oeq double %152, %154
  br i1 %155, label %L59, label %L60
L59:
  %156 = add i32 0, 2
  %157 = load double, double* %d
  %158 = sitofp i32 %156 to double
  %159 = fcmp oeq double %158, %157
  br i1 %159, label %L62, label %L63
L62:
  %160 = load double, double* %d
  %161 = add i32 0, 2
  %162 = sitofp i32 %161 to double
  %163 = fcmp ogt double %160, %162
  br i1 %163, label %L65, label %L66
L65:
  %164 = load double, double* %d
  %165 = add i32 0, 2
  %166 = sitofp i32 %165 to double
  %167 = fcmp olt double %164, %166
  br i1 %167, label %L68, label %L69
L68:
  %168 = add i32 0, 2
  %169 = load double, double* %d
  %170 = sitofp i32 %168 to double
  %171 = fcmp ogt double %170, %169
  br i1 %171, label %L71, label %L72
L71:
  %172 = add i32 0, 2
  %173 = load double, double* %d
  %174 = sitofp i32 %172 to double
  %175 = fcmp olt double %174, %173
  br i1 %175, label %L74, label %L75
L74:
  %176 = load double, double* %d
  %177 = add i32 0, 2
  %178 = sitofp i32 %177 to double
  %179 = fcmp one double %176, %178
  br i1 %179, label %L77, label %L78
L77:
  %180 = add i32 0, 2
  %181 = load double, double* %d
  %182 = sitofp i32 %180 to double
  %183 = fcmp one double %182, %181
  br i1 %183, label %L80, label %L81
L80:
  br label %L82
L81:
  br label %L82
L82:
  br label %L79
L78:
  br label %L79
L79:
  br label %L76
L75:
  br label %L76
L76:
  br label %L73
L72:
  br label %L73
L73:
  br label %L70
L69:
  br label %L70
L70:
  br label %L67
L66:
  br label %L67
L67:
  br label %L64
L63:
  br label %L64
L64:
  br label %L61
L60:
  br label %L61
L61:
  br label %L58
L57:
  br label %L58
L58:
  br label %L55
L54:
  br label %L55
L55:
  br label %L52
L51:
  br label %L52
L52:
  br label %L49
L48:
  br label %L49
L49:
  %184 = load double, double* %d
  %185 = fadd double 0.0, 2.2
  %186 = fcmp oge double %184, %185
  br i1 %186, label %L83, label %L84
L83:
  %187 = load double, double* %d
  %188 = fadd double 0.0, 2.2
  %189 = fcmp ole double %187, %188
  br i1 %189, label %L86, label %L87
L86:
  %190 = fadd double 0.0, 2.2
  %191 = load double, double* %d
  %192 = fcmp oge double %190, %191
  br i1 %192, label %L89, label %L90
L89:
  %193 = fadd double 0.0, 2.2
  %194 = load double, double* %d
  %195 = fcmp ole double %193, %194
  br i1 %195, label %L92, label %L93
L92:
  %196 = load double, double* %d
  %197 = fadd double 0.0, 2.2
  %198 = fcmp oeq double %196, %197
  br i1 %198, label %L95, label %L96
L95:
  %199 = fadd double 0.0, 2.2
  %200 = load double, double* %d
  %201 = fcmp oeq double %199, %200
  br i1 %201, label %L98, label %L99
L98:
  %202 = load double, double* %d
  %203 = fadd double 0.0, 2.2
  %204 = fcmp ogt double %202, %203
  br i1 %204, label %L101, label %L102
L101:
  %205 = load double, double* %d
  %206 = fadd double 0.0, 2.2
  %207 = fcmp olt double %205, %206
  br i1 %207, label %L104, label %L105
L104:
  %208 = fadd double 0.0, 2.2
  %209 = load double, double* %d
  %210 = fcmp ogt double %208, %209
  br i1 %210, label %L107, label %L108
L107:
  %211 = fadd double 0.0, 2.2
  %212 = load double, double* %d
  %213 = fcmp olt double %211, %212
  br i1 %213, label %L110, label %L111
L110:
  %214 = load double, double* %d
  %215 = fadd double 0.0, 2.2
  %216 = fcmp one double %214, %215
  br i1 %216, label %L113, label %L114
L113:
  %217 = fadd double 0.0, 2.2
  %218 = load double, double* %d
  %219 = fcmp one double %217, %218
  br i1 %219, label %L116, label %L117
L116:
  br label %L118
L117:
  br label %L118
L118:
  br label %L115
L114:
  br label %L115
L115:
  br label %L112
L111:
  br label %L112
L112:
  br label %L109
L108:
  br label %L109
L109:
  br label %L106
L105:
  br label %L106
L106:
  br label %L103
L102:
  br label %L103
L103:
  br label %L100
L99:
  br label %L100
L100:
  br label %L97
L96:
  br label %L97
L97:
  br label %L94
L93:
  br label %L94
L94:
  br label %L91
L90:
  br label %L91
L91:
  br label %L88
L87:
  br label %L88
L88:
  br label %L85
L84:
  br label %L85
L85:
  %220 = alloca i1
  %221 = alloca i1
  %222 = alloca i1
  %223 = alloca i1
  %224 = load i1, i1* %b1
  %225 = add i1 0, 1
  %226 = icmp eq i1 %224, %225
  br i1 %226, label %Land_eval_122, label %Land_short_122
Land_eval_122:
  %227 = load double, double* %d
  %228 = fadd double 0.0, 2.2
  %229 = fcmp oge double %227, %228
  store i1 %229, i1* %223
  br label %Land_end_122
Land_short_122:
  store i1 0, i1* %223
  br label %Land_end_122
Land_end_122:
  %230 = load i1, i1* %223
  br i1 %230, label %Land_eval_121, label %Land_short_121
Land_eval_121:
  %231 = add i32 0, 2
  %232 = load double, double* %d
  %233 = sitofp i32 %231 to double
  %234 = fcmp oge double %233, %232
  store i1 %234, i1* %222
  br label %Land_end_121
Land_short_121:
  store i1 0, i1* %222
  br label %Land_end_121
Land_end_121:
  %235 = load i1, i1* %222
  br i1 %235, label %Land_eval_120, label %Land_short_120
Land_eval_120:
  %236 = fadd double 0.0, 2.2
  %237 = load double, double* %d
  %238 = fcmp ole double %236, %237
  store i1 %238, i1* %221
  br label %Land_end_120
Land_short_120:
  store i1 0, i1* %221
  br label %Land_end_120
Land_end_120:
  %239 = load i1, i1* %221
  br i1 %239, label %Lor_short_119, label %Lor_eval_119
Lor_eval_119:
  %240 = fadd double 0.0, 2.2
  %241 = load double, double* %d
  %242 = fadd double 0.0, 2.3
  %243 = add i32 0, 2
  store i32 %243, i32* %a
  %244 = sitofp i32 %243 to double
  %245 = fadd double %242, %244
  %246 = add i32 0, 2
  %247 = sitofp i32 %246 to double
  store double %247, double* %d
  %248 = fadd double %245, %247
  store double %248, double* %d
  %249 = fadd double %241, %248
  %250 = fcmp oeq double %240, %249
  store i1 %250, i1* %220
  br label %Lor_end_119
Lor_short_119:
  store i1 1, i1* %220
  br label %Lor_end_119
Lor_end_119:
  %251 = load i1, i1* %220
  br i1 %251, label %L123, label %L124
L123:
  %252 = add i1 0, 1
  %253 = load i1, i1* %b1
  %254 = icmp eq i1 %252, %253
  br i1 %254, label %L126, label %L127
L126:
  %255 = load i1, i1* %b1
  %256 = add i1 0, 1
  %257 = icmp ne i1 %255, %256
  br i1 %257, label %L129, label %L130
L129:
  %258 = add i1 0, 1
  %259 = load i1, i1* %b1
  %260 = icmp ne i1 %258, %259
  br i1 %260, label %L132, label %L133
L132:
  br label %L134
L133:
  br label %L134
L134:
  br label %L131
L130:
  br label %L131
L131:
  br label %L128
L127:
  br label %L128
L128:
  br label %L125
L124:
  br label %L125
L125:
  %261 = alloca i1
  %262 = alloca i1
  %263 = alloca i1
  %264 = load i1, i1* %b1
  br i1 %264, label %Land_eval_137, label %Land_short_137
Land_eval_137:
  %265 = add i1 0, 1
  store i1 %265, i1* %263
  br label %Land_end_137
Land_short_137:
  store i1 0, i1* %263
  br label %Land_end_137
Land_end_137:
  %266 = load i1, i1* %263
  br i1 %266, label %Lor_short_136, label %Lor_eval_136
Lor_eval_136:
  %267 = load i1, i1* %b1
  store i1 %267, i1* %262
  br label %Lor_end_136
Lor_short_136:
  store i1 1, i1* %262
  br label %Lor_end_136
Lor_end_136:
  %268 = load i1, i1* %262
  br i1 %268, label %Lor_short_135, label %Lor_eval_135
Lor_eval_135:
  %269 = alloca i1
  %270 = add i1 0, 1
  br i1 %270, label %Land_eval_138, label %Land_short_138
Land_eval_138:
  %271 = load i1, i1* %b1
  %272 = xor i1 %271, 1
  %273 = add i1 0, 0
  %274 = xor i1 %272, %273
  store i1 %274, i1* %269
  br label %Land_end_138
Land_short_138:
  store i1 0, i1* %269
  br label %Land_end_138
Land_end_138:
  %275 = load i1, i1* %269
  store i1 %275, i1* %261
  br label %Lor_end_135
Lor_short_135:
  store i1 1, i1* %261
  br label %Lor_end_135
Lor_end_135:
  %276 = load i1, i1* %261
  br i1 %276, label %L139, label %L140
L139:
  %277 = alloca i1
  %278 = alloca i1
  %279 = alloca i1
  %280 = add i1 0, 1
  br i1 %280, label %Land_eval_144, label %Land_short_144
Land_eval_144:
  %281 = load i1, i1* %b1
  store i1 %281, i1* %279
  br label %Land_end_144
Land_short_144:
  store i1 0, i1* %279
  br label %Land_end_144
Land_end_144:
  %282 = load i1, i1* %279
  br i1 %282, label %Lor_short_143, label %Lor_eval_143
Lor_eval_143:
  %283 = add i1 0, 1
  store i1 %283, i1* %278
  br label %Lor_end_143
Lor_short_143:
  store i1 1, i1* %278
  br label %Lor_end_143
Lor_end_143:
  %284 = load i1, i1* %278
  br i1 %284, label %Lor_short_142, label %Lor_eval_142
Lor_eval_142:
  %285 = alloca i1
  %286 = load i1, i1* %b1
  br i1 %286, label %Land_eval_145, label %Land_short_145
Land_eval_145:
  %287 = add i1 0, 0
  %288 = load i1, i1* %b1
  %289 = xor i1 %288, 1
  %290 = xor i1 %287, %289
  store i1 %290, i1* %285
  br label %Land_end_145
Land_short_145:
  store i1 0, i1* %285
  br label %Land_end_145
Land_end_145:
  %291 = load i1, i1* %285
  store i1 %291, i1* %277
  br label %Lor_end_142
Lor_short_142:
  store i1 1, i1* %277
  br label %Lor_end_142
Lor_end_142:
  %292 = load i1, i1* %277
  br i1 %292, label %L146, label %L147
L146:
  br label %L148
L147:
  br label %L148
L148:
  br label %L141
L140:
  br label %L141
L141:
  %293 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.7, i32 0, i32 0))
  %294 = load i32, i32* %a
  %295 = load double, double* %d
  %296 = fmul double %295, -1.0
  %297 = sitofp i32 %294 to double
  %298 = fmul double %297, %296
  %299 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %298)
  %300 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  %301 = add i1 0, 0
  %302 = load i1, i1* %b1
  %303 = xor i1 %302, 1
  %304 = xor i1 %301, %303
  br i1 %304, label %L149, label %L150
L149:
  %305 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.true, i32 0, i32 0))
  br label %L151
L150:
  %306 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.false, i32 0, i32 0))
  br label %L151
L151:
  %307 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  %308 = load i32, i32* %args_length
  %309 = fadd double 0.0, 1.1
  %310 = sitofp i32 %308 to double
  %311 = fadd double %310, %309
  %312 = add i32 0, 3
  %313 = sitofp i32 %312 to double
  %314 = call double @overload__double(double %313)
  %315 = fadd double %311, %314
  %316 = add i32 0, 3
  %317 = add i32 0, 3
  %318 = mul i32 %316, %317
  %319 = sitofp i32 %318 to double
  %320 = fadd double %315, %319
  %321 = add i32 0, 2
  %322 = sitofp i32 %321 to double
  %323 = fadd double %320, %322
  %324 = add i32 0, 2
  %325 = sitofp i32 %324 to double
  %326 = fadd double %323, %325
  %327 = add i32 0, 2
  %328 = mul i32 %327, -1
  %329 = sitofp i32 %328 to double
  %330 = fadd double %326, %329
  %331 = add i32 0, 3
  %332 = add i32 0, 3
  %333 = sdiv i32 %331, %332
  %334 = sitofp i32 %333 to double
  %335 = fadd double %330, %334
  store double %335, double* %d1
  %336 = add i32 0, 0
  store i32 %336, i32* %i
  %337 = add i32 0, 0
  store i32 %337, i32* %j
  %338 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.11, i32 0, i32 0))
  br label %L152
L152:
  %339 = load i32, i32* %i
  %340 = add i32 0, 10
  %341 = icmp slt i32 %339, %340
  br i1 %341, label %L153, label %L154
L153:
  br label %L155
L155:
  %342 = add i32 0, 10
  %343 = load i32, i32* %i
  %344 = icmp sgt i32 %342, %343
  br i1 %344, label %L156, label %L157
L156:
  br label %L158
L158:
  %345 = alloca i1
  %346 = add i32 0, 20
  %347 = load i32, i32* %j
  %348 = icmp sgt i32 %346, %347
  br i1 %348, label %Land_eval_161, label %Land_short_161
Land_eval_161:
  %349 = load i32, i32* %i
  %350 = add i32 0, 10
  %351 = icmp slt i32 %349, %350
  store i1 %351, i1* %345
  br label %Land_end_161
Land_short_161:
  store i1 0, i1* %345
  br label %Land_end_161
Land_end_161:
  %352 = load i1, i1* %345
  br i1 %352, label %L159, label %L160
L159:
  %353 = load i32, i32* %i
  %354 = add i32 0, 1
  %355 = add i32 %353, %354
  store i32 %355, i32* %i
  %356 = load i32, i32* %j
  %357 = add i32 0, 1
  %358 = add i32 %356, %357
  store i32 %358, i32* %j
  %359 = load i32, i32* %i
  %360 = add i32 0, 10
  %361 = icmp eq i32 %359, %360
  br i1 %361, label %L162, label %L163
L162:
  %362 = load i32, i32* %j
  %363 = add i32 0, 9
  %364 = icmp eq i32 %362, %363
  br i1 %364, label %L165, label %L166
L165:
  br label %L167
L166:
  br label %L167
L167:
  br label %L164
L163:
  br label %L164
L164:
  br label %L158
L160:
  br label %L155
L157:
  br label %L152
L154:
  ret i32 0
}


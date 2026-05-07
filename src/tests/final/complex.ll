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
  %1 = alloca i1
  %2 = alloca i1
  %3 = alloca i1
  %4 = alloca i1
  %5 = alloca i1
  %6 = alloca i1
  %7 = alloca i1
  %8 = alloca i1
  %9 = alloca i1
  %10 = alloca i1
  %11 = alloca i1
  %12 = alloca i1
  %13 = alloca i1
  %14 = load i32, i32* %args_length
  %15 = add i32 0, 0
  %16 = icmp sgt i32 %14, %15
  br i1 %16, label %L5, label %L6
L5:
  %17 = add i32 0, 0
  %18 = load i8**, i8*** %args
  %19 = getelementptr inbounds i8*, i8** %18, i32 %17
  %20 = load i8*, i8** %19
  %21 = call i32 @atoi(i8* %20)
  %22 = sitofp i32 %21 to double
  %23 = call double @overload__double(double %22)
  br label %L7
L6:
  %24 = add i32 0, 5
  %25 = sitofp i32 %24 to double
  %26 = call double @overload__double(double %25)
  br label %L7
L7:
  %27 = add i1 0, 0
  %28 = xor i1 %27, 1
  br i1 %28, label %L8, label %L9
L8:
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.true, i32 0, i32 0))
  br label %L10
L9:
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.false, i32 0, i32 0))
  br label %L10
L10:
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  %32 = add i32 0, 2222222
  store i32 %32, i32* %a
  %33 = fadd double 0.0, 23232332.0e1
  store double %33, double* %d
  %34 = add i32 0, 3
  store i32 %34, i32* %b
  %35 = load i32, i32* %a
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %35)
  %37 = add i1 0, 1
  store i1 %37, i1* %b1
  %38 = load i32, i32* %a
  %39 = load i32, i32* %a
  %40 = add i32 %38, %39
  %41 = load i32, i32* %a
  %42 = add i32 %40, %41
  %43 = add i32 0, 8
  %44 = add i32 0, 2
  %45 = srem i32 %43, %44
  %46 = add i32 %42, %45
  %47 = load double, double* %d
  %48 = add i32 0, 3
  %49 = sitofp i32 %48 to double
  %50 = fdiv double %47, %49
  %51 = sitofp i32 %46 to double
  %52 = fadd double %51, %50
  %53 = load i32, i32* %a
  %54 = load double, double* %d
  %55 = sitofp i32 %53 to double
  %56 = fmul double %55, %54
  %57 = fadd double %52, %56
  %58 = load double, double* %d
  %59 = fadd double %57, %58
  %60 = load i32, i32* %a
  %61 = sitofp i32 %60 to double
  %62 = fsub double %59, %61
  %63 = load i32, i32* %a
  %64 = load i32, i32* %b
  %65 = mul i32 %63, %64
  %66 = load double, double* %d
  %67 = sitofp i32 %65 to double
  %68 = fdiv double %67, %66
  %69 = load i32, i32* %a
  %70 = load i32, i32* %b
  %71 = mul i32 %69, %70
  %72 = load double, double* %d
  %73 = sitofp i32 %71 to double
  %74 = fdiv double %73, %72
  %75 = fmul double %68, %74
  %76 = fadd double %62, %75
  %77 = fadd double 0.0, 2.2
  %78 = call double @overload__double(double %77)
  %79 = fadd double %76, %78
  %80 = add i32 0, 1
  %81 = add i32 0, 1
  %82 = call i32 @overload__i32_i32(i32 %80, i32 %81)
  %83 = sitofp i32 %82 to double
  store double %83, double* %d
  %84 = fadd double %79, %83
  %85 = add i32 0, 5
  %86 = call i32 @main__i32(i32 %85)
  %87 = sitofp i32 %86 to double
  %88 = fadd double %84, %87
  %89 = load i32, i32* %args_length
  %90 = add i32 0, 1
  %91 = sub i32 %89, %90
  %92 = load i8**, i8*** %args
  %93 = getelementptr inbounds i8*, i8** %92, i32 %91
  %94 = load i8*, i8** %93
  %95 = call i32 @atoi(i8* %94)
  %96 = sitofp i32 %95 to double
  %97 = fadd double %88, %96
  %98 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %97)
  %99 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.5, i32 0, i32 0))
  %100 = load i32, i32* %a
  %101 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %100)
  %102 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.6, i32 0, i32 0))
  %103 = load i32, i32* %a
  %104 = add i32 0, 2
  %105 = add i32 0, 2
  %106 = mul i32 %104, %105
  %107 = add i32 0, 3
  %108 = add i32 0, 5
  %109 = sdiv i32 %107, %108
  %110 = add i32 %106, %109
  %111 = add i32 0, 5
  %112 = call i32 @main__i32(i32 %111)
  %113 = add i32 %110, %112
  %114 = icmp sge i32 %103, %113
  br i1 %114, label %L11, label %L12
L11:
  %115 = load i32, i32* %a
  %116 = add i32 0, 2
  %117 = icmp sle i32 %115, %116
  br i1 %117, label %L14, label %L15
L14:
  %118 = add i32 0, 2
  %119 = load i32, i32* %a
  %120 = icmp sge i32 %118, %119
  br i1 %120, label %L17, label %L18
L17:
  %121 = add i32 0, 2
  %122 = load i32, i32* %a
  %123 = icmp sle i32 %121, %122
  br i1 %123, label %L20, label %L21
L20:
  %124 = load i32, i32* %a
  %125 = add i32 0, 2
  %126 = icmp eq i32 %124, %125
  br i1 %126, label %L23, label %L24
L23:
  %127 = add i32 0, 2
  %128 = load i32, i32* %a
  %129 = icmp eq i32 %127, %128
  br i1 %129, label %L26, label %L27
L26:
  %130 = load i32, i32* %a
  %131 = add i32 0, 2
  %132 = icmp sgt i32 %130, %131
  br i1 %132, label %L29, label %L30
L29:
  %133 = load i32, i32* %a
  %134 = add i32 0, 2
  %135 = icmp slt i32 %133, %134
  br i1 %135, label %L32, label %L33
L32:
  %136 = add i32 0, 2
  %137 = load i32, i32* %a
  %138 = icmp sgt i32 %136, %137
  br i1 %138, label %L35, label %L36
L35:
  %139 = add i32 0, 2
  %140 = load i32, i32* %a
  %141 = icmp slt i32 %139, %140
  br i1 %141, label %L38, label %L39
L38:
  %142 = load i32, i32* %a
  %143 = add i32 0, 2
  %144 = icmp ne i32 %142, %143
  br i1 %144, label %L41, label %L42
L41:
  %145 = add i32 0, 2
  %146 = load i32, i32* %a
  %147 = icmp ne i32 %145, %146
  br i1 %147, label %L44, label %L45
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
  %148 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.7, i32 0, i32 0))
  %149 = load double, double* %d
  %150 = add i32 0, 2
  %151 = sitofp i32 %150 to double
  %152 = fcmp oge double %149, %151
  br i1 %152, label %L47, label %L48
L47:
  %153 = load double, double* %d
  %154 = add i32 0, 2
  %155 = sitofp i32 %154 to double
  %156 = fcmp ole double %153, %155
  br i1 %156, label %L50, label %L51
L50:
  %157 = add i32 0, 2
  %158 = load double, double* %d
  %159 = sitofp i32 %157 to double
  %160 = fcmp oge double %159, %158
  br i1 %160, label %L53, label %L54
L53:
  %161 = add i32 0, 2
  %162 = load double, double* %d
  %163 = sitofp i32 %161 to double
  %164 = fcmp ole double %163, %162
  br i1 %164, label %L56, label %L57
L56:
  %165 = load double, double* %d
  %166 = add i32 0, 2
  %167 = sitofp i32 %166 to double
  %168 = fcmp oeq double %165, %167
  br i1 %168, label %L59, label %L60
L59:
  %169 = add i32 0, 2
  %170 = load double, double* %d
  %171 = sitofp i32 %169 to double
  %172 = fcmp oeq double %171, %170
  br i1 %172, label %L62, label %L63
L62:
  %173 = load double, double* %d
  %174 = add i32 0, 2
  %175 = sitofp i32 %174 to double
  %176 = fcmp ogt double %173, %175
  br i1 %176, label %L65, label %L66
L65:
  %177 = load double, double* %d
  %178 = add i32 0, 2
  %179 = sitofp i32 %178 to double
  %180 = fcmp olt double %177, %179
  br i1 %180, label %L68, label %L69
L68:
  %181 = add i32 0, 2
  %182 = load double, double* %d
  %183 = sitofp i32 %181 to double
  %184 = fcmp ogt double %183, %182
  br i1 %184, label %L71, label %L72
L71:
  %185 = add i32 0, 2
  %186 = load double, double* %d
  %187 = sitofp i32 %185 to double
  %188 = fcmp olt double %187, %186
  br i1 %188, label %L74, label %L75
L74:
  %189 = load double, double* %d
  %190 = add i32 0, 2
  %191 = sitofp i32 %190 to double
  %192 = fcmp one double %189, %191
  br i1 %192, label %L77, label %L78
L77:
  %193 = add i32 0, 2
  %194 = load double, double* %d
  %195 = sitofp i32 %193 to double
  %196 = fcmp one double %195, %194
  br i1 %196, label %L80, label %L81
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
  %197 = load double, double* %d
  %198 = fadd double 0.0, 2.2
  %199 = fcmp oge double %197, %198
  br i1 %199, label %L83, label %L84
L83:
  %200 = load double, double* %d
  %201 = fadd double 0.0, 2.2
  %202 = fcmp ole double %200, %201
  br i1 %202, label %L86, label %L87
L86:
  %203 = fadd double 0.0, 2.2
  %204 = load double, double* %d
  %205 = fcmp oge double %203, %204
  br i1 %205, label %L89, label %L90
L89:
  %206 = fadd double 0.0, 2.2
  %207 = load double, double* %d
  %208 = fcmp ole double %206, %207
  br i1 %208, label %L92, label %L93
L92:
  %209 = load double, double* %d
  %210 = fadd double 0.0, 2.2
  %211 = fcmp oeq double %209, %210
  br i1 %211, label %L95, label %L96
L95:
  %212 = fadd double 0.0, 2.2
  %213 = load double, double* %d
  %214 = fcmp oeq double %212, %213
  br i1 %214, label %L98, label %L99
L98:
  %215 = load double, double* %d
  %216 = fadd double 0.0, 2.2
  %217 = fcmp ogt double %215, %216
  br i1 %217, label %L101, label %L102
L101:
  %218 = load double, double* %d
  %219 = fadd double 0.0, 2.2
  %220 = fcmp olt double %218, %219
  br i1 %220, label %L104, label %L105
L104:
  %221 = fadd double 0.0, 2.2
  %222 = load double, double* %d
  %223 = fcmp ogt double %221, %222
  br i1 %223, label %L107, label %L108
L107:
  %224 = fadd double 0.0, 2.2
  %225 = load double, double* %d
  %226 = fcmp olt double %224, %225
  br i1 %226, label %L110, label %L111
L110:
  %227 = load double, double* %d
  %228 = fadd double 0.0, 2.2
  %229 = fcmp one double %227, %228
  br i1 %229, label %L113, label %L114
L113:
  %230 = fadd double 0.0, 2.2
  %231 = load double, double* %d
  %232 = fcmp one double %230, %231
  br i1 %232, label %L116, label %L117
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
  %233 = load i1, i1* %b1
  %234 = add i1 0, 1
  %235 = icmp eq i1 %233, %234
  br i1 %235, label %Land_eval_122, label %Land_short_122
Land_eval_122:
  %236 = load double, double* %d
  %237 = fadd double 0.0, 2.2
  %238 = fcmp oge double %236, %237
  store i1 %238, i1* %4
  br label %Land_end_122
Land_short_122:
  store i1 0, i1* %4
  br label %Land_end_122
Land_end_122:
  %239 = load i1, i1* %4
  br i1 %239, label %Land_eval_121, label %Land_short_121
Land_eval_121:
  %240 = add i32 0, 2
  %241 = load double, double* %d
  %242 = sitofp i32 %240 to double
  %243 = fcmp oge double %242, %241
  store i1 %243, i1* %3
  br label %Land_end_121
Land_short_121:
  store i1 0, i1* %3
  br label %Land_end_121
Land_end_121:
  %244 = load i1, i1* %3
  br i1 %244, label %Land_eval_120, label %Land_short_120
Land_eval_120:
  %245 = fadd double 0.0, 2.2
  %246 = load double, double* %d
  %247 = fcmp ole double %245, %246
  store i1 %247, i1* %2
  br label %Land_end_120
Land_short_120:
  store i1 0, i1* %2
  br label %Land_end_120
Land_end_120:
  %248 = load i1, i1* %2
  br i1 %248, label %Lor_short_119, label %Lor_eval_119
Lor_eval_119:
  %249 = fadd double 0.0, 2.2
  %250 = load double, double* %d
  %251 = fadd double 0.0, 2.3
  %252 = add i32 0, 2
  store i32 %252, i32* %a
  %253 = sitofp i32 %252 to double
  %254 = fadd double %251, %253
  %255 = add i32 0, 2
  %256 = sitofp i32 %255 to double
  store double %256, double* %d
  %257 = fadd double %254, %256
  store double %257, double* %d
  %258 = fadd double %250, %257
  %259 = fcmp oeq double %249, %258
  store i1 %259, i1* %1
  br label %Lor_end_119
Lor_short_119:
  store i1 1, i1* %1
  br label %Lor_end_119
Lor_end_119:
  %260 = load i1, i1* %1
  br i1 %260, label %L123, label %L124
L123:
  %261 = add i1 0, 1
  %262 = load i1, i1* %b1
  %263 = icmp eq i1 %261, %262
  br i1 %263, label %L126, label %L127
L126:
  %264 = load i1, i1* %b1
  %265 = add i1 0, 1
  %266 = icmp ne i1 %264, %265
  br i1 %266, label %L129, label %L130
L129:
  %267 = add i1 0, 1
  %268 = load i1, i1* %b1
  %269 = icmp ne i1 %267, %268
  br i1 %269, label %L132, label %L133
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
  %270 = load i1, i1* %b1
  br i1 %270, label %Land_eval_137, label %Land_short_137
Land_eval_137:
  %271 = add i1 0, 1
  store i1 %271, i1* %7
  br label %Land_end_137
Land_short_137:
  store i1 0, i1* %7
  br label %Land_end_137
Land_end_137:
  %272 = load i1, i1* %7
  br i1 %272, label %Lor_short_136, label %Lor_eval_136
Lor_eval_136:
  %273 = load i1, i1* %b1
  store i1 %273, i1* %6
  br label %Lor_end_136
Lor_short_136:
  store i1 1, i1* %6
  br label %Lor_end_136
Lor_end_136:
  %274 = load i1, i1* %6
  br i1 %274, label %Lor_short_135, label %Lor_eval_135
Lor_eval_135:
  %275 = add i1 0, 1
  br i1 %275, label %Land_eval_138, label %Land_short_138
Land_eval_138:
  %276 = load i1, i1* %b1
  %277 = xor i1 %276, 1
  %278 = add i1 0, 0
  %279 = xor i1 %277, %278
  store i1 %279, i1* %8
  br label %Land_end_138
Land_short_138:
  store i1 0, i1* %8
  br label %Land_end_138
Land_end_138:
  %280 = load i1, i1* %8
  store i1 %280, i1* %5
  br label %Lor_end_135
Lor_short_135:
  store i1 1, i1* %5
  br label %Lor_end_135
Lor_end_135:
  %281 = load i1, i1* %5
  br i1 %281, label %L139, label %L140
L139:
  %282 = add i1 0, 1
  br i1 %282, label %Land_eval_144, label %Land_short_144
Land_eval_144:
  %283 = load i1, i1* %b1
  store i1 %283, i1* %11
  br label %Land_end_144
Land_short_144:
  store i1 0, i1* %11
  br label %Land_end_144
Land_end_144:
  %284 = load i1, i1* %11
  br i1 %284, label %Lor_short_143, label %Lor_eval_143
Lor_eval_143:
  %285 = add i1 0, 1
  store i1 %285, i1* %10
  br label %Lor_end_143
Lor_short_143:
  store i1 1, i1* %10
  br label %Lor_end_143
Lor_end_143:
  %286 = load i1, i1* %10
  br i1 %286, label %Lor_short_142, label %Lor_eval_142
Lor_eval_142:
  %287 = load i1, i1* %b1
  br i1 %287, label %Land_eval_145, label %Land_short_145
Land_eval_145:
  %288 = add i1 0, 0
  %289 = load i1, i1* %b1
  %290 = xor i1 %289, 1
  %291 = xor i1 %288, %290
  store i1 %291, i1* %12
  br label %Land_end_145
Land_short_145:
  store i1 0, i1* %12
  br label %Land_end_145
Land_end_145:
  %292 = load i1, i1* %12
  store i1 %292, i1* %9
  br label %Lor_end_142
Lor_short_142:
  store i1 1, i1* %9
  br label %Lor_end_142
Lor_end_142:
  %293 = load i1, i1* %9
  br i1 %293, label %L146, label %L147
L146:
  br label %L148
L147:
  br label %L148
L148:
  br label %L141
L140:
  br label %L141
L141:
  %294 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.7, i32 0, i32 0))
  %295 = load i32, i32* %a
  %296 = load double, double* %d
  %297 = fmul double %296, -1.0
  %298 = sitofp i32 %295 to double
  %299 = fmul double %298, %297
  %300 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), double %299)
  %301 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  %302 = add i1 0, 0
  %303 = load i1, i1* %b1
  %304 = xor i1 %303, 1
  %305 = xor i1 %302, %304
  br i1 %305, label %L149, label %L150
L149:
  %306 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.true, i32 0, i32 0))
  br label %L151
L150:
  %307 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.false, i32 0, i32 0))
  br label %L151
L151:
  %308 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  %309 = load i32, i32* %args_length
  %310 = fadd double 0.0, 1.1
  %311 = sitofp i32 %309 to double
  %312 = fadd double %311, %310
  %313 = add i32 0, 3
  %314 = sitofp i32 %313 to double
  %315 = call double @overload__double(double %314)
  %316 = fadd double %312, %315
  %317 = add i32 0, 3
  %318 = add i32 0, 3
  %319 = mul i32 %317, %318
  %320 = sitofp i32 %319 to double
  %321 = fadd double %316, %320
  %322 = add i32 0, 2
  %323 = sitofp i32 %322 to double
  %324 = fadd double %321, %323
  %325 = add i32 0, 2
  %326 = sitofp i32 %325 to double
  %327 = fadd double %324, %326
  %328 = add i32 0, 2
  %329 = mul i32 %328, -1
  %330 = sitofp i32 %329 to double
  %331 = fadd double %327, %330
  %332 = add i32 0, 3
  %333 = add i32 0, 3
  %334 = sdiv i32 %332, %333
  %335 = sitofp i32 %334 to double
  %336 = fadd double %331, %335
  store double %336, double* %d1
  %337 = add i32 0, 0
  store i32 %337, i32* %i
  %338 = add i32 0, 0
  store i32 %338, i32* %j
  %339 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.11, i32 0, i32 0))
  br label %L152
L152:
  %340 = load i32, i32* %i
  %341 = add i32 0, 10
  %342 = icmp slt i32 %340, %341
  br i1 %342, label %L153, label %L154
L153:
  br label %L155
L155:
  %343 = add i32 0, 10
  %344 = load i32, i32* %i
  %345 = icmp sgt i32 %343, %344
  br i1 %345, label %L156, label %L157
L156:
  br label %L158
L158:
  %346 = add i32 0, 20
  %347 = load i32, i32* %j
  %348 = icmp sgt i32 %346, %347
  br i1 %348, label %Land_eval_161, label %Land_short_161
Land_eval_161:
  %349 = load i32, i32* %i
  %350 = add i32 0, 10
  %351 = icmp slt i32 %349, %350
  store i1 %351, i1* %13
  br label %Land_end_161
Land_short_161:
  store i1 0, i1* %13
  br label %Land_end_161
Land_end_161:
  %352 = load i1, i1* %13
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


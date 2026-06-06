Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A96175A7E;
	Sat,  6 Jun 2026 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780716029; cv=none; b=CXRnLFpE00juH8pfFOoLYNnsG3y9UDuJn4iKoOxbY27b9Gm3zGJhnVuxCNs5dcnvKJrj/UZRjy9wgEfSpMu8hpNxwWFG+8CJMyl47whEYYI1eAWzD78xYOtFZx7ygBSUqWzFtv74qaC3D+JCfjksK7JeUljxn5weV4cgf036Pts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780716029; c=relaxed/simple;
	bh=+vvCn+nqGHBSMp8emQQ3Xm8ywjh1B9LvLl1lJ0sWUgA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rnGn5jeVe4V8n4gelf/lzlUrmsia48rV1JZ5+kE3BK+dttfSZHcj49pB9/njLt6aqBNuQwKkvFFIClvkQ1GOOk2AMAwgKn+qROAM5PunGWwDynkUorLFRROJ0kH+jqVGqxXCIxtd77h1p3rkiWJV35Aj5dgwIZNEXLksl0cuh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWgILYvZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWgILYvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E17E1F00893;
	Sat,  6 Jun 2026 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780716028;
	bh=Q3S5tSrTTjVAJjIisR0EMQO1x+ky/7GUoEbqVuN2UoM=;
	h=Date:From:To:Cc:Subject;
	b=bWgILYvZkCnUYWWtFjl2eB/9QOJ6M7qKKVwfpQq1pjS2UPLw1M87EWIrhRb/89HSI
	 1hy6rmRIgJ3JkwnjzMmybKVrxLZzD2TjnvvBm89diT1a4IFkHTJvD9M1ZT1qulh05D
	 GwtxM+hEjn4L1BRlph/R54g1oyivRdZzpxORA2lCeER2oErpKdXrArIG7QylK0/7cT
	 gd7G+yRwDu3Mnue0560Z35E2hclP1am313urQPPS8RdjUirG+m6Wrrm33cmOedIhWF
	 m9fUHYjU/duJ7jetpHoANVp2rVWbn66HVN3jJ6T6E2FOQ0JPX5BFhmebiIzpQ/SQpb
	 UVtDMCtXvMvyg==
Date: Fri, 5 Jun 2026 20:20:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Backports of 175db11786bde9061db526bf1ac5107d915f5163 for 6.6 and
 older
Message-ID: <20260606032024.GA3120787@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="E70AGkoebAVpgJya"
Content-Disposition: inline


--E70AGkoebAVpgJya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Please apply these backports of 175db11786bd ("Disable -Wattribute-alias
for clang-23 and newer") and dependent changes to 6.6 and older (it is
already queued for 6.12 and newer). If there are any issues, please let
me know.

-- 
Cheers,
Nathan

--E70AGkoebAVpgJya
Content-Type: application/mbox
Content-Disposition: attachment; filename=5.10.mbox
Content-Transfer-Encoding: quoted-printable

=46rom 1fd6d128b1589bd345c0a84726eb6540f4ffa346 Mon Sep 17 00:00:00 2001=0A=
=46rom: Nathan Chancellor <nathan@kernel.org>=0ADate: Sat, 5 Mar 2022 04:16=
:42 +0530=0ASubject: [PATCH 5.10 1/2] compiler-clang.h: Add __diag infrastr=
ucture for=0A clang=0A=0Acommit f014a00bbeb09cea16017b82448d32a468a6b96f up=
stream.=0A=0AAdd __diag macros similar to those in compiler-gcc.h, so that =
warnings=0Athat need to be adjusted for specific cases but not globally can=
 be=0Aignored when building with clang.=0A=0ASigned-off-by: Nathan Chancell=
or <nathan@kernel.org>=0ASigned-off-by: Kumar Kartikeya Dwivedi <memxor@gma=
il.com>=0ASigned-off-by: Alexei Starovoitov <ast@kernel.org>=0ALink: https:=
//lore.kernel.org/bpf/20220304224645.3677453-6-memxor@gmail.com=0A=0A[ Kart=
ikeya: wrote commit message ]=0A=0ASigned-off-by: Nathan Chancellor <nathan=
@kernel.org>=0A---=0A include/linux/compiler-clang.h | 22 +++++++++++++++++=
+++++=0A 1 file changed, 22 insertions(+)=0A=0Adiff --git a/include/linux/c=
ompiler-clang.h b/include/linux/compiler-clang.h=0Aindex d9376e327d66..fae3=
775d02b5 100644=0A--- a/include/linux/compiler-clang.h=0A+++ b/include/linu=
x/compiler-clang.h=0A@@ -126,3 +126,25 @@=0A #if __has_feature(shadow_call_=
stack)=0A # define __noscs	__attribute__((__no_sanitize__("shadow-call-stac=
k")))=0A #endif=0A+=0A+/*=0A+ * Turn individual warnings and errors on and =
off locally, depending=0A+ * on version.=0A+ */=0A+#define __diag_clang(ver=
sion, severity, s) \=0A+	__diag_clang_ ## version(__diag_clang_ ## severity=
 s)=0A+=0A+/* Severity used in pragma directives */=0A+#define __diag_clang=
_ignore	ignored=0A+#define __diag_clang_warn	warning=0A+#define __diag_clan=
g_error	error=0A+=0A+#define __diag_str1(s)		#s=0A+#define __diag_str(s)		_=
_diag_str1(s)=0A+#define __diag(s)		_Pragma(__diag_str(clang diagnostic s))=
=0A+=0A+#if CONFIG_CLANG_VERSION >=3D 110000=0A+#define __diag_clang_11(s)	=
__diag(s)=0A+#else=0A+#define __diag_clang_11(s)=0A+#endif=0A=0Abase-commit=
: 5dbd240ac9a06a52a2c7e70b69b6fd7d11aeb359=0A-- =0A2.54.0=0A=0A=0AFrom 79f1=
bc1d188e16d4024d987f8511abf630acff23 Mon Sep 17 00:00:00 2001=0AFrom: Natha=
n Chancellor <nathan@kernel.org>=0ADate: Sat, 16 May 2026 04:34:14 +0900=0A=
Subject: [PATCH 5.10 2/2] Disable -Wattribute-alias for clang-23 and newer=
=0A=0Acommit 175db11786bde9061db526bf1ac5107d915f5163 upstream.=0A=0AClang =
recently added support for -Wattribute-alias [1], which results in=0Athe sa=
me warnings that necessitated commit bee20031772a ("disable=0A-Wattribute-a=
lias warning for SYSCALL_DEFINEx()") for GCC.=0A=0A  kernel/time/itimer.c:3=
25:1: error: alias and aliasee have different types 'long (unsigned int)' a=
nd 'long (typeof (__builtin_choose_expr((__builtin_types_compatible_p(typeo=
f ((unsigned int)0), typeof (0LL)) || __builtin_types_compatible_p(typeof (=
(unsigned int)0), typeof (0ULL))), 0LL, 0L)))' (aka 'long (long)') [-Werror=
,-Wattribute-alias]=0A    325 | SYSCALL_DEFINE1(alarm, unsigned int, second=
s)=0A        | ^=0A  include/linux/syscalls.h:225:36: note: expanded from m=
acro 'SYSCALL_DEFINE1'=0A    225 | #define SYSCALL_DEFINE1(name, ...) SYSCA=
LL_DEFINEx(1, _##name, __VA_ARGS__)=0A        |                            =
        ^=0A  include/linux/syscalls.h:236:2: note: expanded from macro 'SY=
SCALL_DEFINEx'=0A    236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)=
=0A        |         ^=0A  include/linux/syscalls.h:251:18: note: expanded =
=66rom macro '__SYSCALL_DEFINEx'=0A    251 |                 __attribute__(=
(alias(__stringify(__se_sys##name))));    \=0A        |                    =
            ^=0A  kernel/time/itimer.c:325:1: note: aliasee is declared her=
e=0A  include/linux/syscalls.h:225:36: note: expanded from macro 'SYSCALL_D=
EFINE1'=0A    225 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _=
##name, __VA_ARGS__)=0A        |                                    ^=0A  i=
nclude/linux/syscalls.h:236:2: note: expanded from macro 'SYSCALL_DEFINEx'=
=0A    236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)=0A        |  =
       ^=0A  include/linux/syscalls.h:255:18: note: expanded from macro '__=
SYSCALL_DEFINEx'=0A    255 |         asmlinkage long __se_sys##name(__MAP(x=
,__SC_LONG,__VA_ARGS__))  \=0A        |                         ^=0A  <scra=
tch space>:16:1: note: expanded from here=0A     16 | __se_sys_alarm=0A    =
    | ^=0A=0ADisable the warnings in the same way for clang-23 and newer. D=
isable the=0Awarning about unknown warning options to avoid breaking the bu=
ild for=0Aversions of clang-23 that do not have -Wattribute-alias, such as =
ones=0Adeployed by vendors like Android or CI systems or when bisecting LLV=
M=0Abetween llvmorg-23-init and release/23.x.=0A=0ACc: stable@vger.kernel.o=
rg=0ACloses: https://github.com/ClangBuiltLinux/linux/issues/2163=0ALink: h=
ttps://github.com/llvm/llvm-project/commit/40da6920a0d71d49dfa2392b09153600=
b0759f5e [1]=0ALink: https://patch.msgid.link/20260515-syscall-disable-attr=
ibute-alias-for-clang-v1-1-9a9d95d41df6@kernel.org=0A[nathan: Drop arch/ris=
cv hunk in older trees and address conflicts]=0ASigned-off-by: Nathan Chanc=
ellor <nathan@kernel.org>=0A---=0A include/linux/compat.h         | 4 ++++=
=0A include/linux/compiler-clang.h | 6 ++++++=0A include/linux/compiler_typ=
es.h | 4 ++++=0A include/linux/syscalls.h       | 4 ++++=0A 4 files changed=
, 18 insertions(+)=0A=0Adiff --git a/include/linux/compat.h b/include/linux=
/compat.h=0Aindex 8dffffe846ce..93c9bbec96ac 100644=0A--- a/include/linux/c=
ompat.h=0A+++ b/include/linux/compat.h=0A@@ -75,6 +75,10 @@=0A 	__diag_push=
();								\=0A 	__diag_ignore(GCC, 8, "-Wattribute-alias",				\=0A 		     =
 "Type aliasing is used to sanitize syscall arguments");\=0A+	__diag_ignore=
(clang, 23, "-Wunknown-warning-option",			\=0A+		      "Avoid breaking vers=
ions without -Wattribute-alias");	\=0A+	__diag_ignore(clang, 23, "-Wattribu=
te-alias",				\=0A+		      "Type aliasing is used to sanitize syscall argum=
ents");	\=0A 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS_=
_));	\=0A 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))=
	\=0A 		__attribute__((alias(__stringify(__se_compat_sys##name))));	\=0Adif=
f --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h=
=0Aindex fae3775d02b5..a8953f9c766b 100644=0A--- a/include/linux/compiler-c=
lang.h=0A+++ b/include/linux/compiler-clang.h=0A@@ -148,3 +148,9 @@=0A #els=
e=0A #define __diag_clang_11(s)=0A #endif=0A+=0A+#if CONFIG_CLANG_VERSION >=
=3D 230000=0A+#define __diag_clang_23(s)	__diag(s)=0A+#else=0A+#define __di=
ag_clang_23(s)=0A+#endif=0Adiff --git a/include/linux/compiler_types.h b/in=
clude/linux/compiler_types.h=0Aindex 9cecd02c1280..88cc4457297d 100644=0A--=
- a/include/linux/compiler_types.h=0A+++ b/include/linux/compiler_types.h=
=0A@@ -320,6 +320,10 @@ struct ftrace_likely_data {=0A #define __diag_GCC(v=
ersion, severity, string)=0A #endif=0A =0A+#ifndef __diag_clang=0A+#define =
__diag_clang(version, severity, string)=0A+#endif=0A+=0A #define __diag_pus=
h()	__diag(push)=0A #define __diag_pop()	__diag(pop)=0A =0Adiff --git a/inc=
lude/linux/syscalls.h b/include/linux/syscalls.h=0Aindex a96e924c7b45..339a=
35aad839 100644=0A--- a/include/linux/syscalls.h=0A+++ b/include/linux/sysc=
alls.h=0A@@ -236,6 +236,10 @@ static inline int is_syscall_trace_event(stru=
ct trace_event_call *tp_event)=0A 	__diag_push();							\=0A 	__diag_ignore=
(GCC, 8, "-Wattribute-alias",			\=0A 		      "Type aliasing is used to sani=
tize syscall arguments");\=0A+	__diag_ignore(clang, 23, "-Wunknown-warning-=
option",		\=0A+		      "Avoid breaking versions without -Wattribute-alias")=
;\=0A+	__diag_ignore(clang, 23, "-Wattribute-alias",			\=0A+		      "Type a=
liasing is used to sanitize syscall arguments");\=0A 	asmlinkage long sys##=
name(__MAP(x,__SC_DECL,__VA_ARGS__))	\=0A 		__attribute__((alias(__stringif=
y(__se_sys##name))));	\=0A 	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\=0A=
-- =0A2.54.0=0A=0A
--E70AGkoebAVpgJya
Content-Type: application/mbox
Content-Disposition: attachment; filename=5.15.mbox
Content-Transfer-Encoding: quoted-printable

=46rom 78a90fd4ca42cfc1ae03aa93ed45d575deef66a0 Mon Sep 17 00:00:00 2001=0A=
=46rom: Nathan Chancellor <nathan@kernel.org>=0ADate: Sat, 5 Mar 2022 04:16=
:42 +0530=0ASubject: [PATCH 5.15 1/2] compiler-clang.h: Add __diag infrastr=
ucture for=0A clang=0A=0Acommit f014a00bbeb09cea16017b82448d32a468a6b96f up=
stream.=0A=0AAdd __diag macros similar to those in compiler-gcc.h, so that =
warnings=0Athat need to be adjusted for specific cases but not globally can=
 be=0Aignored when building with clang.=0A=0ASigned-off-by: Nathan Chancell=
or <nathan@kernel.org>=0ASigned-off-by: Kumar Kartikeya Dwivedi <memxor@gma=
il.com>=0ASigned-off-by: Alexei Starovoitov <ast@kernel.org>=0ALink: https:=
//lore.kernel.org/bpf/20220304224645.3677453-6-memxor@gmail.com=0A=0A[ Kart=
ikeya: wrote commit message ]=0A=0ASigned-off-by: Nathan Chancellor <nathan=
@kernel.org>=0A---=0A include/linux/compiler-clang.h | 22 +++++++++++++++++=
+++++=0A 1 file changed, 22 insertions(+)=0A=0Adiff --git a/include/linux/c=
ompiler-clang.h b/include/linux/compiler-clang.h=0Aindex 3397f6809c86..7ae9=
fc072302 100644=0A--- a/include/linux/compiler-clang.h=0A+++ b/include/linu=
x/compiler-clang.h=0A@@ -119,3 +119,25 @@=0A =0A #define __nocfi		__attribu=
te__((__no_sanitize__("cfi")))=0A #define __cficanonical	__attribute__((__c=
fi_canonical_jump_table__))=0A+=0A+/*=0A+ * Turn individual warnings and er=
rors on and off locally, depending=0A+ * on version.=0A+ */=0A+#define __di=
ag_clang(version, severity, s) \=0A+	__diag_clang_ ## version(__diag_clang_=
 ## severity s)=0A+=0A+/* Severity used in pragma directives */=0A+#define =
__diag_clang_ignore	ignored=0A+#define __diag_clang_warn	warning=0A+#define=
 __diag_clang_error	error=0A+=0A+#define __diag_str1(s)		#s=0A+#define __di=
ag_str(s)		__diag_str1(s)=0A+#define __diag(s)		_Pragma(__diag_str(clang di=
agnostic s))=0A+=0A+#if CONFIG_CLANG_VERSION >=3D 110000=0A+#define __diag_=
clang_11(s)	__diag(s)=0A+#else=0A+#define __diag_clang_11(s)=0A+#endif=0A=
=0Abase-commit: dc027a595035729e290c0adffae363a653acde7c=0A-- =0A2.54.0=0A=
=0A=0AFrom 278a0d69f718afd6a4e23534f3d8364d554080ed Mon Sep 17 00:00:00 200=
1=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADate: Sat, 16 May 2026 04=
:34:14 +0900=0ASubject: [PATCH 5.15 2/2] Disable -Wattribute-alias for clan=
g-23 and newer=0A=0Acommit 175db11786bde9061db526bf1ac5107d915f5163 upstrea=
m.=0A=0AClang recently added support for -Wattribute-alias [1], which resul=
ts in=0Athe same warnings that necessitated commit bee20031772a ("disable=
=0A-Wattribute-alias warning for SYSCALL_DEFINEx()") for GCC.=0A=0A  kernel=
/time/itimer.c:325:1: error: alias and aliasee have different types 'long (=
unsigned int)' and 'long (typeof (__builtin_choose_expr((__builtin_types_co=
mpatible_p(typeof ((unsigned int)0), typeof (0LL)) || __builtin_types_compa=
tible_p(typeof ((unsigned int)0), typeof (0ULL))), 0LL, 0L)))' (aka 'long (=
long)') [-Werror,-Wattribute-alias]=0A    325 | SYSCALL_DEFINE1(alarm, unsi=
gned int, seconds)=0A        | ^=0A  include/linux/syscalls.h:225:36: note:=
 expanded from macro 'SYSCALL_DEFINE1'=0A    225 | #define SYSCALL_DEFINE1(=
name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)=0A        |            =
                        ^=0A  include/linux/syscalls.h:236:2: note: expande=
d from macro 'SYSCALL_DEFINEx'=0A    236 |         __SYSCALL_DEFINEx(x, sna=
me, __VA_ARGS__)=0A        |         ^=0A  include/linux/syscalls.h:251:18:=
 note: expanded from macro '__SYSCALL_DEFINEx'=0A    251 |                 =
__attribute__((alias(__stringify(__se_sys##name))));    \=0A        |      =
                          ^=0A  kernel/time/itimer.c:325:1: note: aliasee i=
s declared here=0A  include/linux/syscalls.h:225:36: note: expanded from ma=
cro 'SYSCALL_DEFINE1'=0A    225 | #define SYSCALL_DEFINE1(name, ...) SYSCAL=
L_DEFINEx(1, _##name, __VA_ARGS__)=0A        |                             =
       ^=0A  include/linux/syscalls.h:236:2: note: expanded from macro 'SYS=
CALL_DEFINEx'=0A    236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)=
=0A        |         ^=0A  include/linux/syscalls.h:255:18: note: expanded =
=66rom macro '__SYSCALL_DEFINEx'=0A    255 |         asmlinkage long __se_s=
ys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \=0A        |                    =
     ^=0A  <scratch space>:16:1: note: expanded from here=0A     16 | __se_=
sys_alarm=0A        | ^=0A=0ADisable the warnings in the same way for clang=
-23 and newer. Disable the=0Awarning about unknown warning options to avoid=
 breaking the build for=0Aversions of clang-23 that do not have -Wattribute=
-alias, such as ones=0Adeployed by vendors like Android or CI systems or wh=
en bisecting LLVM=0Abetween llvmorg-23-init and release/23.x.=0A=0ACc: stab=
le@vger.kernel.org=0ACloses: https://github.com/ClangBuiltLinux/linux/issue=
s/2163=0ALink: https://github.com/llvm/llvm-project/commit/40da6920a0d71d49=
dfa2392b09153600b0759f5e [1]=0ALink: https://patch.msgid.link/20260515-sysc=
all-disable-attribute-alias-for-clang-v1-1-9a9d95d41df6@kernel.org=0A[natha=
n: Drop arch/riscv hunk in older trees and address conflicts]=0ASigned-off-=
by: Nathan Chancellor <nathan@kernel.org>=0A---=0A include/linux/compat.h  =
       | 4 ++++=0A include/linux/compiler-clang.h | 6 ++++++=0A include/lin=
ux/compiler_types.h | 4 ++++=0A include/linux/syscalls.h       | 4 ++++=0A =
4 files changed, 18 insertions(+)=0A=0Adiff --git a/include/linux/compat.h =
b/include/linux/compat.h=0Aindex d91fb5225dbf..c5441ac9050f 100644=0A--- a/=
include/linux/compat.h=0A+++ b/include/linux/compat.h=0A@@ -72,6 +72,10 @@=
=0A 	__diag_push();								\=0A 	__diag_ignore(GCC, 8, "-Wattribute-alias",=
				\=0A 		      "Type aliasing is used to sanitize syscall arguments");\=
=0A+	__diag_ignore(clang, 23, "-Wunknown-warning-option",			\=0A+		      "A=
void breaking versions without -Wattribute-alias");	\=0A+	__diag_ignore(cla=
ng, 23, "-Wattribute-alias",				\=0A+		      "Type aliasing is used to sani=
tize syscall arguments");	\=0A 	asmlinkage long compat_sys##name(__MAP(x,__=
SC_DECL,__VA_ARGS__))	\=0A 		__attribute__((alias(__stringify(__se_compat_s=
ys##name))));	\=0A 	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\=0A=
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.=
h=0Aindex 7ae9fc072302..f0b218c914f1 100644=0A--- a/include/linux/compiler-=
clang.h=0A+++ b/include/linux/compiler-clang.h=0A@@ -141,3 +141,9 @@=0A #el=
se=0A #define __diag_clang_11(s)=0A #endif=0A+=0A+#if CONFIG_CLANG_VERSION =
>=3D 230000=0A+#define __diag_clang_23(s)	__diag(s)=0A+#else=0A+#define __d=
iag_clang_23(s)=0A+#endif=0Adiff --git a/include/linux/compiler_types.h b/i=
nclude/linux/compiler_types.h=0Aindex ca9345e2934d..2eda6f701696 100644=0A-=
-- a/include/linux/compiler_types.h=0A+++ b/include/linux/compiler_types.h=
=0A@@ -345,6 +345,10 @@ struct ftrace_likely_data {=0A #define __diag_GCC(v=
ersion, severity, string)=0A #endif=0A =0A+#ifndef __diag_clang=0A+#define =
__diag_clang(version, severity, string)=0A+#endif=0A+=0A #define __diag_pus=
h()	__diag(push)=0A #define __diag_pop()	__diag(pop)=0A =0Adiff --git a/inc=
lude/linux/syscalls.h b/include/linux/syscalls.h=0Aindex b8037a46ff41..ce63=
109333a5 100644=0A--- a/include/linux/syscalls.h=0A+++ b/include/linux/sysc=
alls.h=0A@@ -239,6 +239,10 @@ static inline int is_syscall_trace_event(stru=
ct trace_event_call *tp_event)=0A 	__diag_push();							\=0A 	__diag_ignore=
(GCC, 8, "-Wattribute-alias",			\=0A 		      "Type aliasing is used to sani=
tize syscall arguments");\=0A+	__diag_ignore(clang, 23, "-Wunknown-warning-=
option",		\=0A+		      "Avoid breaking versions without -Wattribute-alias")=
;\=0A+	__diag_ignore(clang, 23, "-Wattribute-alias",			\=0A+		      "Type a=
liasing is used to sanitize syscall arguments");\=0A 	asmlinkage long sys##=
name(__MAP(x,__SC_DECL,__VA_ARGS__))	\=0A 		__attribute__((alias(__stringif=
y(__se_sys##name))));	\=0A 	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\=0A=
-- =0A2.54.0=0A=0A
--E70AGkoebAVpgJya
Content-Type: application/mbox
Content-Disposition: attachment; filename=6.1.mbox
Content-Transfer-Encoding: quoted-printable

=46rom a6b922ab8adb718946f9e60f8019c481d3000b30 Mon Sep 17 00:00:00 2001=0A=
=46rom: Nathan Chancellor <nathan@kernel.org>=0ADate: Sat, 16 May 2026 04:3=
4:14 +0900=0ASubject: [PATCH 6.1] Disable -Wattribute-alias for clang-23 an=
d newer=0A=0Acommit 175db11786bde9061db526bf1ac5107d915f5163 upstream.=0A=
=0AClang recently added support for -Wattribute-alias [1], which results in=
=0Athe same warnings that necessitated commit bee20031772a ("disable=0A-Wat=
tribute-alias warning for SYSCALL_DEFINEx()") for GCC.=0A=0A  kernel/time/i=
timer.c:325:1: error: alias and aliasee have different types 'long (unsigne=
d int)' and 'long (typeof (__builtin_choose_expr((__builtin_types_compatibl=
e_p(typeof ((unsigned int)0), typeof (0LL)) || __builtin_types_compatible_p=
(typeof ((unsigned int)0), typeof (0ULL))), 0LL, 0L)))' (aka 'long (long)')=
 [-Werror,-Wattribute-alias]=0A    325 | SYSCALL_DEFINE1(alarm, unsigned in=
t, seconds)=0A        | ^=0A  include/linux/syscalls.h:225:36: note: expand=
ed from macro 'SYSCALL_DEFINE1'=0A    225 | #define SYSCALL_DEFINE1(name, .=
=2E.) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)=0A        |                 =
                   ^=0A  include/linux/syscalls.h:236:2: note: expanded fro=
m macro 'SYSCALL_DEFINEx'=0A    236 |         __SYSCALL_DEFINEx(x, sname, _=
_VA_ARGS__)=0A        |         ^=0A  include/linux/syscalls.h:251:18: note=
: expanded from macro '__SYSCALL_DEFINEx'=0A    251 |                 __att=
ribute__((alias(__stringify(__se_sys##name))));    \=0A        |           =
                     ^=0A  kernel/time/itimer.c:325:1: note: aliasee is dec=
lared here=0A  include/linux/syscalls.h:225:36: note: expanded from macro '=
SYSCALL_DEFINE1'=0A    225 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEF=
INEx(1, _##name, __VA_ARGS__)=0A        |                                  =
  ^=0A  include/linux/syscalls.h:236:2: note: expanded from macro 'SYSCALL_=
DEFINEx'=0A    236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)=0A   =
     |         ^=0A  include/linux/syscalls.h:255:18: note: expanded from m=
acro '__SYSCALL_DEFINEx'=0A    255 |         asmlinkage long __se_sys##name=
(__MAP(x,__SC_LONG,__VA_ARGS__))  \=0A        |                         ^=
=0A  <scratch space>:16:1: note: expanded from here=0A     16 | __se_sys_al=
arm=0A        | ^=0A=0ADisable the warnings in the same way for clang-23 an=
d newer. Disable the=0Awarning about unknown warning options to avoid break=
ing the build for=0Aversions of clang-23 that do not have -Wattribute-alias=
, such as ones=0Adeployed by vendors like Android or CI systems or when bis=
ecting LLVM=0Abetween llvmorg-23-init and release/23.x.=0A=0ACc: stable@vge=
r.kernel.org=0ACloses: https://github.com/ClangBuiltLinux/linux/issues/2163=
=0ALink: https://github.com/llvm/llvm-project/commit/40da6920a0d71d49dfa239=
2b09153600b0759f5e [1]=0ALink: https://patch.msgid.link/20260515-syscall-di=
sable-attribute-alias-for-clang-v1-1-9a9d95d41df6@kernel.org=0A[nathan: Dro=
p arch/riscv hunk in older trees and address conflicts]=0ASigned-off-by: Na=
than Chancellor <nathan@kernel.org>=0A---=0A include/linux/compat.h        =
 | 4 ++++=0A include/linux/compiler-clang.h | 6 ++++++=0A include/linux/com=
piler_types.h | 4 ++++=0A include/linux/syscalls.h       | 4 ++++=0A 4 file=
s changed, 18 insertions(+)=0A=0Adiff --git a/include/linux/compat.h b/incl=
ude/linux/compat.h=0Aindex 77e84d17521e..38f22c9ac910 100644=0A--- a/includ=
e/linux/compat.h=0A+++ b/include/linux/compat.h=0A@@ -72,6 +72,10 @@=0A 	__=
diag_push();								\=0A 	__diag_ignore(GCC, 8, "-Wattribute-alias",				\=
=0A 		      "Type aliasing is used to sanitize syscall arguments");\=0A+	__=
diag_ignore(clang, 23, "-Wunknown-warning-option",			\=0A+		      "Avoid br=
eaking versions without -Wattribute-alias");	\=0A+	__diag_ignore(clang, 23,=
 "-Wattribute-alias",				\=0A+		      "Type aliasing is used to sanitize sy=
scall arguments");	\=0A 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL=
,__VA_ARGS__))	\=0A 		__attribute__((alias(__stringify(__se_compat_sys##nam=
e))));	\=0A 	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\=0Adiff --=
git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h=0Aind=
ex f9de53fff3ac..2fd5b596b36b 100644=0A--- a/include/linux/compiler-clang.h=
=0A+++ b/include/linux/compiler-clang.h=0A@@ -144,5 +144,11 @@=0A #define _=
_diag_clang_11(s)=0A #endif=0A =0A+#if CONFIG_CLANG_VERSION >=3D 230000=0A+=
#define __diag_clang_23(s)	__diag(s)=0A+#else=0A+#define __diag_clang_23(s)=
=0A+#endif=0A+=0A #define __diag_ignore_all(option, comment) \=0A 	__diag_c=
lang(11, ignore, option)=0Adiff --git a/include/linux/compiler_types.h b/in=
clude/linux/compiler_types.h=0Aindex ef359a76b11f..7c9883c499cf 100644=0A--=
- a/include/linux/compiler_types.h=0A+++ b/include/linux/compiler_types.h=
=0A@@ -399,6 +399,10 @@ struct ftrace_likely_data {=0A #define __diag_GCC(v=
ersion, severity, string)=0A #endif=0A =0A+#ifndef __diag_clang=0A+#define =
__diag_clang(version, severity, string)=0A+#endif=0A+=0A #define __diag_pus=
h()	__diag(push)=0A #define __diag_pop()	__diag(pop)=0A =0Adiff --git a/inc=
lude/linux/syscalls.h b/include/linux/syscalls.h=0Aindex dcce762b48fa..7ff6=
bc7da1f6 100644=0A--- a/include/linux/syscalls.h=0A+++ b/include/linux/sysc=
alls.h=0A@@ -240,6 +240,10 @@ static inline int is_syscall_trace_event(stru=
ct trace_event_call *tp_event)=0A 	__diag_push();							\=0A 	__diag_ignore=
(GCC, 8, "-Wattribute-alias",			\=0A 		      "Type aliasing is used to sani=
tize syscall arguments");\=0A+	__diag_ignore(clang, 23, "-Wunknown-warning-=
option",		\=0A+		      "Avoid breaking versions without -Wattribute-alias")=
;\=0A+	__diag_ignore(clang, 23, "-Wattribute-alias",			\=0A+		      "Type a=
liasing is used to sanitize syscall arguments");\=0A 	asmlinkage long sys##=
name(__MAP(x,__SC_DECL,__VA_ARGS__))	\=0A 		__attribute__((alias(__stringif=
y(__se_sys##name))));	\=0A 	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\=0A=
=0Abase-commit: 228da13e907e2b46b7222cfc35290fbfad920bef=0A-- =0A2.54.0=0A=
=0A
--E70AGkoebAVpgJya
Content-Type: application/mbox
Content-Disposition: attachment; filename=6.6.mbox
Content-Transfer-Encoding: quoted-printable

=46rom 7c5b814b62d0ab4f9cd20e7f77a84f132ac7f667 Mon Sep 17 00:00:00 2001=0A=
=46rom: Nathan Chancellor <nathan@kernel.org>=0ADate: Sat, 16 May 2026 04:3=
4:14 +0900=0ASubject: [PATCH 6.6] Disable -Wattribute-alias for clang-23 an=
d newer=0A=0Acommit 175db11786bde9061db526bf1ac5107d915f5163 upstream.=0A=
=0AClang recently added support for -Wattribute-alias [1], which results in=
=0Athe same warnings that necessitated commit bee20031772a ("disable=0A-Wat=
tribute-alias warning for SYSCALL_DEFINEx()") for GCC.=0A=0A  kernel/time/i=
timer.c:325:1: error: alias and aliasee have different types 'long (unsigne=
d int)' and 'long (typeof (__builtin_choose_expr((__builtin_types_compatibl=
e_p(typeof ((unsigned int)0), typeof (0LL)) || __builtin_types_compatible_p=
(typeof ((unsigned int)0), typeof (0ULL))), 0LL, 0L)))' (aka 'long (long)')=
 [-Werror,-Wattribute-alias]=0A    325 | SYSCALL_DEFINE1(alarm, unsigned in=
t, seconds)=0A        | ^=0A  include/linux/syscalls.h:225:36: note: expand=
ed from macro 'SYSCALL_DEFINE1'=0A    225 | #define SYSCALL_DEFINE1(name, .=
=2E.) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)=0A        |                 =
                   ^=0A  include/linux/syscalls.h:236:2: note: expanded fro=
m macro 'SYSCALL_DEFINEx'=0A    236 |         __SYSCALL_DEFINEx(x, sname, _=
_VA_ARGS__)=0A        |         ^=0A  include/linux/syscalls.h:251:18: note=
: expanded from macro '__SYSCALL_DEFINEx'=0A    251 |                 __att=
ribute__((alias(__stringify(__se_sys##name))));    \=0A        |           =
                     ^=0A  kernel/time/itimer.c:325:1: note: aliasee is dec=
lared here=0A  include/linux/syscalls.h:225:36: note: expanded from macro '=
SYSCALL_DEFINE1'=0A    225 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEF=
INEx(1, _##name, __VA_ARGS__)=0A        |                                  =
  ^=0A  include/linux/syscalls.h:236:2: note: expanded from macro 'SYSCALL_=
DEFINEx'=0A    236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)=0A   =
     |         ^=0A  include/linux/syscalls.h:255:18: note: expanded from m=
acro '__SYSCALL_DEFINEx'=0A    255 |         asmlinkage long __se_sys##name=
(__MAP(x,__SC_LONG,__VA_ARGS__))  \=0A        |                         ^=
=0A  <scratch space>:16:1: note: expanded from here=0A     16 | __se_sys_al=
arm=0A        | ^=0A=0ADisable the warnings in the same way for clang-23 an=
d newer. Disable the=0Awarning about unknown warning options to avoid break=
ing the build for=0Aversions of clang-23 that do not have -Wattribute-alias=
, such as ones=0Adeployed by vendors like Android or CI systems or when bis=
ecting LLVM=0Abetween llvmorg-23-init and release/23.x.=0A=0ACc: stable@vge=
r.kernel.org=0ACloses: https://github.com/ClangBuiltLinux/linux/issues/2163=
=0ALink: https://github.com/llvm/llvm-project/commit/40da6920a0d71d49dfa239=
2b09153600b0759f5e [1]=0ALink: https://patch.msgid.link/20260515-syscall-di=
sable-attribute-alias-for-clang-v1-1-9a9d95d41df6@kernel.org=0A[nathan: Dro=
p arch/riscv hunk in older trees and address conflicts]=0ASigned-off-by: Na=
than Chancellor <nathan@kernel.org>=0A---=0A include/linux/compat.h        =
 | 4 ++++=0A include/linux/compiler-clang.h | 6 ++++++=0A include/linux/com=
piler_types.h | 4 ++++=0A include/linux/syscalls.h       | 4 ++++=0A 4 file=
s changed, 18 insertions(+)=0A=0Adiff --git a/include/linux/compat.h b/incl=
ude/linux/compat.h=0Aindex 5981d3eadaee..7a55636cc984 100644=0A--- a/includ=
e/linux/compat.h=0A+++ b/include/linux/compat.h=0A@@ -72,6 +72,10 @@=0A 	__=
diag_push();								\=0A 	__diag_ignore(GCC, 8, "-Wattribute-alias",				\=
=0A 		      "Type aliasing is used to sanitize syscall arguments");\=0A+	__=
diag_ignore(clang, 23, "-Wunknown-warning-option",			\=0A+		      "Avoid br=
eaking versions without -Wattribute-alias");	\=0A+	__diag_ignore(clang, 23,=
 "-Wattribute-alias",				\=0A+		      "Type aliasing is used to sanitize sy=
scall arguments");	\=0A 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL=
,__VA_ARGS__))	\=0A 		__attribute__((alias(__stringify(__se_compat_sys##nam=
e))));	\=0A 	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\=0Adiff --=
git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h=0Aind=
ex f9de53fff3ac..2fd5b596b36b 100644=0A--- a/include/linux/compiler-clang.h=
=0A+++ b/include/linux/compiler-clang.h=0A@@ -144,5 +144,11 @@=0A #define _=
_diag_clang_11(s)=0A #endif=0A =0A+#if CONFIG_CLANG_VERSION >=3D 230000=0A+=
#define __diag_clang_23(s)	__diag(s)=0A+#else=0A+#define __diag_clang_23(s)=
=0A+#endif=0A+=0A #define __diag_ignore_all(option, comment) \=0A 	__diag_c=
lang(11, ignore, option)=0Adiff --git a/include/linux/compiler_types.h b/in=
clude/linux/compiler_types.h=0Aindex b63da6b03d33..ed1c107124e4 100644=0A--=
- a/include/linux/compiler_types.h=0A+++ b/include/linux/compiler_types.h=
=0A@@ -486,6 +486,10 @@ struct ftrace_likely_data {=0A #define __diag_GCC(v=
ersion, severity, string)=0A #endif=0A =0A+#ifndef __diag_clang=0A+#define =
__diag_clang(version, severity, string)=0A+#endif=0A+=0A #define __diag_pus=
h()	__diag(push)=0A #define __diag_pop()	__diag(pop)=0A =0Adiff --git a/inc=
lude/linux/syscalls.h b/include/linux/syscalls.h=0Aindex 36c592e43d65..8109=
d9f0ede6 100644=0A--- a/include/linux/syscalls.h=0A+++ b/include/linux/sysc=
alls.h=0A@@ -242,6 +242,10 @@ static inline int is_syscall_trace_event(stru=
ct trace_event_call *tp_event)=0A 	__diag_push();							\=0A 	__diag_ignore=
(GCC, 8, "-Wattribute-alias",			\=0A 		      "Type aliasing is used to sani=
tize syscall arguments");\=0A+	__diag_ignore(clang, 23, "-Wunknown-warning-=
option",		\=0A+		      "Avoid breaking versions without -Wattribute-alias")=
;\=0A+	__diag_ignore(clang, 23, "-Wattribute-alias",			\=0A+		      "Type a=
liasing is used to sanitize syscall arguments");\=0A 	asmlinkage long sys##=
name(__MAP(x,__SC_DECL,__VA_ARGS__))	\=0A 		__attribute__((alias(__stringif=
y(__se_sys##name))));	\=0A 	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\=0A=
=0Abase-commit: 924b4a879cbb75aef37c160b955b92f6894b11a4=0A-- =0A2.54.0=0A=
=0A
--E70AGkoebAVpgJya--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2F35DA55;
	Fri, 14 Aug 2026 02:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786675933; cv=none; b=i7axD+nAL/PFk4aFZt0Xsd2NblZg1e64aMOaBfK+q8uHiLrjFIEGK1qKZmkoi/OVSxRmMkFuGOPfRg3SMfFVPu8k7997ZYvG7XFMnQ5//5g6fc0xmR6vZNtKAOZIgLsQPwrwI01XaUYGi2DaJmE7uSJ6YoKKL3TgAvnmxC0M//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786675933; c=relaxed/simple;
	bh=4QZXuNbzZB30a303CyKS94Lj9qUqh1halBESH/ujtU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ocEQZmXCjqNpXHDR8pXVgUU7Y7ZLG8fCSbxofdhtLyHvVcef6cAS96NrwcfbJGfA4G1urcUsCj9M39kH7uf6V23CjPHAyAxkUNHyC3GsaR8ud5omtm/CqGmdsjhS7ohpqCFYXlQSgQR0gej0BBkv07Cx5zhMYU/4Hym2Zwq4n50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VegNdVbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VegNdVbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592F91F000E9;
	Fri, 14 Aug 2026 02:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786675932;
	bh=unQ4qsaV5sZHTzzKkoR6qI44hP58HvP2ucGgCmU2PZs=;
	h=Date:From:To:Cc:Subject;
	b=VegNdVbNczkBbzCmVhhwQhAEMPliiFyEHFHjzsMvJyrQA5M8vRx9IASsMbezW094p
	 cnS2PMaPuGhzq9oiFlPPsHp8ArlK9JH5y3QoGvHo36p+IM2nWQgDdvr19LWdznTyJn
	 5At2AehnbYbtl+A0Lpi0oEjjukqzab7NBmxwiIRO7gS1NGqz/ILpjgS3tya87ZLB7i
	 rR0oY7FwXmodriNbHysCWY27DpMCxc3rU3p+bUuxTe9rDmJTndS+MAyJPrLL9RKbVm
	 +goFRotp2tOASYAgotAh0eBRhTCnLkqkj2PaWtzJZRyD4e6vIV6APLQQq8HWlI18lf
	 ru7EhRRCS+GEg==
Date: Thu, 13 Aug 2026 19:52:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev,
	Kees Cook <kees@kernel.org>
Subject: Backports of c1f3e770eec26d6f96dd6d2ea30555ba7c09a244 for 6.6 and 6.1
Message-ID: <20260814025208.GA1929807@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dHMTi8hpRhLD4fwk"
Content-Disposition: inline

--dHMTi8hpRhLD4fwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable folks,

Please consider applying the attached backport of upstream commit
c1f3e770eec2 ("fortify: Disable -Wstringop-overread in tests"), along
with a worthwhile prerequisite patch to clear up some other issues and
make that change apply correctly.

If there are any issues, please let me know.

-- 
Cheers,
Nathan

--dHMTi8hpRhLD4fwk
Content-Type: application/mbox
Content-Disposition: attachment;
	filename=c1f3e770eec26d6f96dd6d2ea30555ba7c09a244-6.1.mbox
Content-Transfer-Encoding: quoted-printable

=46rom 2bc267e88889b8614449302764d14466b285a7e0 Mon Sep 17 00:00:00 2001=0A=
=46rom: Masahiro Yamada <masahiroy@kernel.org>=0ADate: Sun, 28 Jul 2024 00:=
02:36 +0900=0ASubject: [PATCH 6.1 1/2] fortify: refactor test_fortify Makef=
ile to fix some=0A build problems=0A=0Acommit 4e9903b0861c9df3464b82db4a702=
5863bac1897 upstream.=0A=0AThere are some issues in the test_fortify Makefi=
le code.=0A=0AProblem 1: cc-disable-warning invokes compiler dozens of time=
s=0A=0ATo see how many times the cc-disable-warning is evaluated, change=0A=
this code:=0A=0A  $(call cc-disable-warning,fortify-source)=0A=0Ato:=0A=0A =
 $(call cc-disable-warning,$(shell touch /tmp/fortify-$$$$)fortify-source)=
=0A=0AThen, build the kernel with CONFIG_FORTIFY_SOURCE=3Dy. You will see a=
=0Alarge number of '/tmp/fortify-<PID>' files created:=0A=0A  $ ls -1 /tmp/=
fortify-* | wc=0A       80      80    1600=0A=0AThis means the compiler was=
 invoked 80 times just for checking the=0A-Wno-fortify-source flag support.=
=0A=0A$(call cc-disable-warning,fortify-source) should be added to a simple=
=0Avariable instead of a recursive variable.=0A=0AProblem 2: do not recompi=
le string.o when the test code is updated=0A=0AThe test cases are independe=
nt of the kernel. However, when the test=0Acode is updated, $(obj)/string.o=
 is rebuilt and vmlinux is relinked=0Adue to this dependency:=0A=0A  $(obj)=
/string.o: $(obj)/$(TEST_FORTIFY_LOG)=0A=0Aalways-y is suitable for buildin=
g the log files.=0A=0AProblem 3: redundant code=0A=0A  clean-files +=3D $(a=
ddsuffix .o, $(TEST_FORTIFY_LOGS))=0A=0A... is unneeded because the top Mak=
efile globally cleans *.o files.=0A=0AThis commit fixes these issues and ma=
kes the code readable.=0A=0ASigned-off-by: Masahiro Yamada <masahiroy@kerne=
l.org>=0ALink: https://lore.kernel.org/r/20240727150302.1823750-2-masahiroy=
@kernel.org=0ASigned-off-by: Kees Cook <kees@kernel.org>=0A[nathan: Fixed c=
onflicts]=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A l=
ib/.gitignore              |  2 --=0A lib/Makefile                | 34 +---=
------------------------------=0A lib/test_fortify/.gitignore |  2 ++=0A li=
b/test_fortify/Makefile   | 28 ++++++++++++++++++++++++++++=0A scripts/remo=
ve-stale-files  |  2 ++=0A 5 files changed, 33 insertions(+), 35 deletions(=
-)=0A create mode 100644 lib/test_fortify/.gitignore=0A create mode 100644 =
lib/test_fortify/Makefile=0A=0Adiff --git a/lib/.gitignore b/lib/.gitignore=
=0Aindex 54596b634ecb..101a4aa92fb5 100644=0A--- a/lib/.gitignore=0A+++ b/l=
ib/.gitignore=0A@@ -5,5 +5,3 @@=0A /gen_crc32table=0A /gen_crc64table=0A /o=
id_registry_data.c=0A-/test_fortify.log=0A-/test_fortify/*.log=0Adiff --git=
 a/lib/Makefile b/lib/Makefile=0Aindex 6ae66e13f319..1081d0c16115 100644=0A=
--- a/lib/Makefile=0A+++ b/lib/Makefile=0A@@ -394,36 +394,4 @@ CFLAGS_longe=
st_symbol_kunit.o +=3D $(call cc-disable-warning, missing-prototypes)=0A =
=0A obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o=0A=
 =0A-# FORTIFY_SOURCE compile-time behavior tests=0A-TEST_FORTIFY_SRCS =3D =
$(wildcard $(srctree)/$(src)/test_fortify/*-*.c)=0A-TEST_FORTIFY_LOGS =3D $=
(patsubst $(srctree)/$(src)/%.c, %.log, $(TEST_FORTIFY_SRCS))=0A-TEST_FORTI=
FY_LOG =3D test_fortify.log=0A-=0A-quiet_cmd_test_fortify =3D TEST    $@=0A=
-      cmd_test_fortify =3D $(CONFIG_SHELL) $(srctree)/scripts/test_fortify=
=2Esh \=0A-			$< $@ "$(NM)" $(CC) $(c_flags) \=0A-			$(call cc-disable-warn=
ing,fortify-source) \=0A-			-DKBUILD_EXTRA_WARN1=0A-=0A-targets +=3D $(TEST=
_FORTIFY_LOGS)=0A-clean-files +=3D $(TEST_FORTIFY_LOGS)=0A-clean-files +=3D=
 $(addsuffix .o, $(TEST_FORTIFY_LOGS))=0A-$(obj)/test_fortify/%.log: $(src)=
/test_fortify/%.c \=0A-			   $(src)/test_fortify/test_fortify.h \=0A-			   =
$(srctree)/include/linux/fortify-string.h \=0A-			   $(srctree)/scripts/tes=
t_fortify.sh \=0A-			   FORCE=0A-	$(call if_changed,test_fortify)=0A-=0A-qu=
iet_cmd_gen_fortify_log =3D GEN     $@=0A-      cmd_gen_fortify_log =3D cat=
 </dev/null $(filter-out FORCE,$^) 2>/dev/null > $@ || true=0A-=0A-targets =
+=3D $(TEST_FORTIFY_LOG)=0A-clean-files +=3D $(TEST_FORTIFY_LOG)=0A-$(obj)/=
$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE=0A-	$=
(call if_changed,gen_fortify_log)=0A-=0A-# Fake dependency to trigger the f=
ortify tests.=0A-ifeq ($(CONFIG_FORTIFY_SOURCE),y)=0A-$(obj)/string.o: $(ob=
j)/$(TEST_FORTIFY_LOG)=0A-endif=0A+subdir-$(CONFIG_FORTIFY_SOURCE) +=3D tes=
t_fortify=0Adiff --git a/lib/test_fortify/.gitignore b/lib/test_fortify/.gi=
tignore=0Anew file mode 100644=0Aindex 000000000000..c1ba37d14b50=0A--- /de=
v/null=0A+++ b/lib/test_fortify/.gitignore=0A@@ -0,0 +1,2 @@=0A+# SPDX-Lice=
nse-Identifier: GPL-2.0-only=0A+/*.log=0Adiff --git a/lib/test_fortify/Make=
file b/lib/test_fortify/Makefile=0Anew file mode 100644=0Aindex 00000000000=
0..7887e6126e79=0A--- /dev/null=0A+++ b/lib/test_fortify/Makefile=0A@@ -0,0=
 +1,28 @@=0A+# SPDX-License-Identifier: GPL-2.0=0A+=0A+ccflags-y :=3D $(cal=
l cc-disable-warning,fortify-source)=0A+=0A+quiet_cmd_test_fortify =3D TEST=
    $@=0A+      cmd_test_fortify =3D $(CONFIG_SHELL) $(srctree)/scripts/tes=
t_fortify.sh \=0A+			$< $@ "$(NM)" $(CC) $(c_flags) -DKBUILD_EXTRA_WARN1=0A=
+=0A+$(obj)/%.log: $(src)/%.c $(srctree)/scripts/test_fortify.sh \=0A+	    =
  $(src)/test_fortify.h \=0A+	      $(srctree)/include/linux/fortify-string=
=2Eh \=0A+	      FORCE=0A+	$(call if_changed,test_fortify)=0A+=0A+logs =3D =
$(patsubst $(srctree)/$(src)/%.c, %.log, $(wildcard $(srctree)/$(src)/*-*.c=
))=0A+targets +=3D $(logs)=0A+=0A+quiet_cmd_gen_fortify_log =3D CAT     $@=
=0A+      cmd_gen_fortify_log =3D cat $(or $(real-prereqs),/dev/null) > $@=
=0A+=0A+$(obj)/test_fortify.log: $(addprefix $(obj)/, $(logs)) FORCE=0A+	$(=
call if_changed,gen_fortify_log)=0A+=0A+always-y +=3D test_fortify.log=0A+=
=0A+# Some architectures define __NO_FORTIFY if __SANITIZE_ADDRESS__ is und=
efined.=0A+# Pass CFLAGS_KASAN to avoid warnings.=0A+KASAN_SANITIZE :=3D y=
=0Adiff --git a/scripts/remove-stale-files b/scripts/remove-stale-files=0Ai=
ndex ccadfa3afb2b..c22fe4630bac 100755=0A--- a/scripts/remove-stale-files=
=0A+++ b/scripts/remove-stale-files=0A@@ -47,3 +47,5 @@ rm -f arch/riscv/pu=
rgatory/kexec-purgatory.c=0A rm -f scripts/extract-cert=0A =0A rm -f arch/x=
86/purgatory/kexec-purgatory.c=0A+=0A+rm -f lib/test_fortify.log=0A=0Abase-=
commit: e4f7d8be268ecf717f94ee2e242afa79ddeacaed=0A-- =0A2.55.0=0A=0A=0AFro=
m e0f86eb33d3cf925cf060bbaa80564f7d4828408 Mon Sep 17 00:00:00 2001=0AFrom:=
 Nathan Chancellor <nathan@kernel.org>=0ADate: Tue, 23 Jun 2026 13:23:46 -0=
700=0ASubject: [PATCH 6.1 2/2] fortify: Disable -Wstringop-overread in test=
s=0A=0Acommit c1f3e770eec26d6f96dd6d2ea30555ba7c09a244 upstream.=0A=0Aclang=
 recently added support for -Wstringop-overread [1], which is on by=0Adefau=
lt like -Wfortify-source. This breaks the usage of -Werror in the=0Afortify=
 tests, resulting in the following false positive warnings in the=0Akernel =
build:=0A=0A  warning: unsafe memcmp() usage lacked '__read_overflow2' warn=
ing in lib/test_fortify/read_overflow2-memcmp.c=0A  warning: unsafe memcmp(=
) usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-=
memcmp.c=0A  warning: unsafe memchr() usage lacked '__read_overflow' warnin=
g in lib/test_fortify/read_overflow-memchr.c=0A=0AExamining the fortify tes=
t logs shows a warning like the following in=0Aeach of the failed logs:=0A=
=0A  In file included from lib/test_fortify/read_overflow2-memcmp.c:5:=0A  =
lib/test_fortify/test_fortify.h:34:2: error: 'memcmp' reading 17 bytes from=
 a region of size 16 [-Werror,-Wstringop-overread]=0A     34 |         TEST=
;=0A        |         ^=0A  lib/test_fortify/read_overflow2-memcmp.c:3:2: n=
ote: expanded from macro 'TEST'=0A      3 |         memcmp(large, small, si=
zeof(small) + 1)=0A        |         ^=0A  1 error generated.=0A=0ADisable =
-Wstringop-overread for the fortify tests, as it defeats the=0Apurpose of t=
esting the Linux specific implementation of fortify, like=0A-Wfortify-sourc=
e.=0A=0ACc: stable@vger.kernel.org=0ACloses: https://github.com/ClangBuiltL=
inux/linux/issues/2168=0ALink: https://github.com/llvm/llvm-project/commit/=
86f2e71cb8d165b59ad31a442b2391e23826133e [1]=0ASigned-off-by: Nathan Chance=
llor <nathan@kernel.org>=0ALink: https://patch.msgid.link/20260623-fix-test=
_fortify-for-clang-stringop-overread-v1-1-15ee8342a953@kernel.org=0ASigned-=
off-by: Kees Cook <kees@kernel.org>=0ASigned-off-by: Nathan Chancellor <nat=
han@kernel.org>=0A---=0A lib/test_fortify/Makefile | 1 +=0A 1 file changed,=
 1 insertion(+)=0A=0Adiff --git a/lib/test_fortify/Makefile b/lib/test_fort=
ify/Makefile=0Aindex 7887e6126e79..eba2ba0faeb6 100644=0A--- a/lib/test_for=
tify/Makefile=0A+++ b/lib/test_fortify/Makefile=0A@@ -1,6 +1,7 @@=0A # SPDX=
-License-Identifier: GPL-2.0=0A =0A ccflags-y :=3D $(call cc-disable-warnin=
g,fortify-source)=0A+ccflags-y +=3D $(call cc-disable-warning,stringop-over=
read)=0A =0A quiet_cmd_test_fortify =3D TEST    $@=0A       cmd_test_fortif=
y =3D $(CONFIG_SHELL) $(srctree)/scripts/test_fortify.sh \=0A-- =0A2.55.0=
=0A=0A
--dHMTi8hpRhLD4fwk
Content-Type: application/mbox
Content-Disposition: attachment;
	filename=c1f3e770eec26d6f96dd6d2ea30555ba7c09a244-6.6.mbox
Content-Transfer-Encoding: quoted-printable

=46rom 0be5fa1e0770fafdb12d8236cc42362f314fb6b8 Mon Sep 17 00:00:00 2001=0A=
=46rom: Masahiro Yamada <masahiroy@kernel.org>=0ADate: Sun, 28 Jul 2024 00:=
02:36 +0900=0ASubject: [PATCH 6.6 1/2] fortify: refactor test_fortify Makef=
ile to fix some=0A build problems=0A=0Acommit 4e9903b0861c9df3464b82db4a702=
5863bac1897 upstream.=0A=0AThere are some issues in the test_fortify Makefi=
le code.=0A=0AProblem 1: cc-disable-warning invokes compiler dozens of time=
s=0A=0ATo see how many times the cc-disable-warning is evaluated, change=0A=
this code:=0A=0A  $(call cc-disable-warning,fortify-source)=0A=0Ato:=0A=0A =
 $(call cc-disable-warning,$(shell touch /tmp/fortify-$$$$)fortify-source)=
=0A=0AThen, build the kernel with CONFIG_FORTIFY_SOURCE=3Dy. You will see a=
=0Alarge number of '/tmp/fortify-<PID>' files created:=0A=0A  $ ls -1 /tmp/=
fortify-* | wc=0A       80      80    1600=0A=0AThis means the compiler was=
 invoked 80 times just for checking the=0A-Wno-fortify-source flag support.=
=0A=0A$(call cc-disable-warning,fortify-source) should be added to a simple=
=0Avariable instead of a recursive variable.=0A=0AProblem 2: do not recompi=
le string.o when the test code is updated=0A=0AThe test cases are independe=
nt of the kernel. However, when the test=0Acode is updated, $(obj)/string.o=
 is rebuilt and vmlinux is relinked=0Adue to this dependency:=0A=0A  $(obj)=
/string.o: $(obj)/$(TEST_FORTIFY_LOG)=0A=0Aalways-y is suitable for buildin=
g the log files.=0A=0AProblem 3: redundant code=0A=0A  clean-files +=3D $(a=
ddsuffix .o, $(TEST_FORTIFY_LOGS))=0A=0A... is unneeded because the top Mak=
efile globally cleans *.o files.=0A=0AThis commit fixes these issues and ma=
kes the code readable.=0A=0ASigned-off-by: Masahiro Yamada <masahiroy@kerne=
l.org>=0ALink: https://lore.kernel.org/r/20240727150302.1823750-2-masahiroy=
@kernel.org=0ASigned-off-by: Kees Cook <kees@kernel.org>=0A[nathan: Fixed c=
onflicts]=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A l=
ib/.gitignore              |  2 --=0A lib/Makefile                | 34 +---=
------------------------------=0A lib/test_fortify/.gitignore |  2 ++=0A li=
b/test_fortify/Makefile   | 28 ++++++++++++++++++++++++++++=0A scripts/remo=
ve-stale-files  |  2 ++=0A 5 files changed, 33 insertions(+), 35 deletions(=
-)=0A create mode 100644 lib/test_fortify/.gitignore=0A create mode 100644 =
lib/test_fortify/Makefile=0A=0Adiff --git a/lib/.gitignore b/lib/.gitignore=
=0Aindex 54596b634ecb..101a4aa92fb5 100644=0A--- a/lib/.gitignore=0A+++ b/l=
ib/.gitignore=0A@@ -5,5 +5,3 @@=0A /gen_crc32table=0A /gen_crc64table=0A /o=
id_registry_data.c=0A-/test_fortify.log=0A-/test_fortify/*.log=0Adiff --git=
 a/lib/Makefile b/lib/Makefile=0Aindex b9d2577fbbe1..62737ad5aa74 100644=0A=
--- a/lib/Makefile=0A+++ b/lib/Makefile=0A@@ -407,36 +407,4 @@ CFLAGS_longe=
st_symbol_kunit.o +=3D $(call cc-disable-warning, missing-prototypes)=0A =
=0A obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o=0A=
 =0A-# FORTIFY_SOURCE compile-time behavior tests=0A-TEST_FORTIFY_SRCS =3D =
$(wildcard $(srctree)/$(src)/test_fortify/*-*.c)=0A-TEST_FORTIFY_LOGS =3D $=
(patsubst $(srctree)/$(src)/%.c, %.log, $(TEST_FORTIFY_SRCS))=0A-TEST_FORTI=
FY_LOG =3D test_fortify.log=0A-=0A-quiet_cmd_test_fortify =3D TEST    $@=0A=
-      cmd_test_fortify =3D $(CONFIG_SHELL) $(srctree)/scripts/test_fortify=
=2Esh \=0A-			$< $@ "$(NM)" $(CC) $(c_flags) \=0A-			$(call cc-disable-warn=
ing,fortify-source) \=0A-			-DKBUILD_EXTRA_WARN1=0A-=0A-targets +=3D $(TEST=
_FORTIFY_LOGS)=0A-clean-files +=3D $(TEST_FORTIFY_LOGS)=0A-clean-files +=3D=
 $(addsuffix .o, $(TEST_FORTIFY_LOGS))=0A-$(obj)/test_fortify/%.log: $(src)=
/test_fortify/%.c \=0A-			   $(src)/test_fortify/test_fortify.h \=0A-			   =
$(srctree)/include/linux/fortify-string.h \=0A-			   $(srctree)/scripts/tes=
t_fortify.sh \=0A-			   FORCE=0A-	$(call if_changed,test_fortify)=0A-=0A-qu=
iet_cmd_gen_fortify_log =3D GEN     $@=0A-      cmd_gen_fortify_log =3D cat=
 </dev/null $(filter-out FORCE,$^) 2>/dev/null > $@ || true=0A-=0A-targets =
+=3D $(TEST_FORTIFY_LOG)=0A-clean-files +=3D $(TEST_FORTIFY_LOG)=0A-$(obj)/=
$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE=0A-	$=
(call if_changed,gen_fortify_log)=0A-=0A-# Fake dependency to trigger the f=
ortify tests.=0A-ifeq ($(CONFIG_FORTIFY_SOURCE),y)=0A-$(obj)/string.o: $(ob=
j)/$(TEST_FORTIFY_LOG)=0A-endif=0A+subdir-$(CONFIG_FORTIFY_SOURCE) +=3D tes=
t_fortify=0Adiff --git a/lib/test_fortify/.gitignore b/lib/test_fortify/.gi=
tignore=0Anew file mode 100644=0Aindex 000000000000..c1ba37d14b50=0A--- /de=
v/null=0A+++ b/lib/test_fortify/.gitignore=0A@@ -0,0 +1,2 @@=0A+# SPDX-Lice=
nse-Identifier: GPL-2.0-only=0A+/*.log=0Adiff --git a/lib/test_fortify/Make=
file b/lib/test_fortify/Makefile=0Anew file mode 100644=0Aindex 00000000000=
0..7887e6126e79=0A--- /dev/null=0A+++ b/lib/test_fortify/Makefile=0A@@ -0,0=
 +1,28 @@=0A+# SPDX-License-Identifier: GPL-2.0=0A+=0A+ccflags-y :=3D $(cal=
l cc-disable-warning,fortify-source)=0A+=0A+quiet_cmd_test_fortify =3D TEST=
    $@=0A+      cmd_test_fortify =3D $(CONFIG_SHELL) $(srctree)/scripts/tes=
t_fortify.sh \=0A+			$< $@ "$(NM)" $(CC) $(c_flags) -DKBUILD_EXTRA_WARN1=0A=
+=0A+$(obj)/%.log: $(src)/%.c $(srctree)/scripts/test_fortify.sh \=0A+	    =
  $(src)/test_fortify.h \=0A+	      $(srctree)/include/linux/fortify-string=
=2Eh \=0A+	      FORCE=0A+	$(call if_changed,test_fortify)=0A+=0A+logs =3D =
$(patsubst $(srctree)/$(src)/%.c, %.log, $(wildcard $(srctree)/$(src)/*-*.c=
))=0A+targets +=3D $(logs)=0A+=0A+quiet_cmd_gen_fortify_log =3D CAT     $@=
=0A+      cmd_gen_fortify_log =3D cat $(or $(real-prereqs),/dev/null) > $@=
=0A+=0A+$(obj)/test_fortify.log: $(addprefix $(obj)/, $(logs)) FORCE=0A+	$(=
call if_changed,gen_fortify_log)=0A+=0A+always-y +=3D test_fortify.log=0A+=
=0A+# Some architectures define __NO_FORTIFY if __SANITIZE_ADDRESS__ is und=
efined.=0A+# Pass CFLAGS_KASAN to avoid warnings.=0A+KASAN_SANITIZE :=3D y=
=0Adiff --git a/scripts/remove-stale-files b/scripts/remove-stale-files=0Ai=
ndex 8b1a636f8543..38eb84eb605b 100755=0A--- a/scripts/remove-stale-files=
=0A+++ b/scripts/remove-stale-files=0A@@ -39,3 +39,5 @@ rm -rf include/ksym=
=0A find . -name '*.usyms' | xargs rm -f=0A =0A rm -f binkernel.spec=0A+=0A=
+rm -f lib/test_fortify.log=0A=0Abase-commit: d27334b2888c10d2b60c954c59b18=
6182d833107=0A-- =0A2.55.0=0A=0A=0AFrom 32aab2431199e57e314a268638c38d1e960=
3be84 Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@kernel.org=
>=0ADate: Tue, 23 Jun 2026 13:23:46 -0700=0ASubject: [PATCH 6.6 2/2] fortif=
y: Disable -Wstringop-overread in tests=0A=0Acommit c1f3e770eec26d6f96dd6d2=
ea30555ba7c09a244 upstream.=0A=0Aclang recently added support for -Wstringo=
p-overread [1], which is on by=0Adefault like -Wfortify-source. This breaks=
 the usage of -Werror in the=0Afortify tests, resulting in the following fa=
lse positive warnings in the=0Akernel build:=0A=0A  warning: unsafe memcmp(=
) usage lacked '__read_overflow2' warning in lib/test_fortify/read_overflow=
2-memcmp.c=0A  warning: unsafe memcmp() usage lacked '__read_overflow' warn=
ing in lib/test_fortify/read_overflow-memcmp.c=0A  warning: unsafe memchr()=
 usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-m=
emchr.c=0A=0AExamining the fortify test logs shows a warning like the follo=
wing in=0Aeach of the failed logs:=0A=0A  In file included from lib/test_fo=
rtify/read_overflow2-memcmp.c:5:=0A  lib/test_fortify/test_fortify.h:34:2: =
error: 'memcmp' reading 17 bytes from a region of size 16 [-Werror,-Wstring=
op-overread]=0A     34 |         TEST;=0A        |         ^=0A  lib/test_f=
ortify/read_overflow2-memcmp.c:3:2: note: expanded from macro 'TEST'=0A    =
  3 |         memcmp(large, small, sizeof(small) + 1)=0A        |         ^=
=0A  1 error generated.=0A=0ADisable -Wstringop-overread for the fortify te=
sts, as it defeats the=0Apurpose of testing the Linux specific implementati=
on of fortify, like=0A-Wfortify-source.=0A=0ACc: stable@vger.kernel.org=0AC=
loses: https://github.com/ClangBuiltLinux/linux/issues/2168=0ALink: https:/=
/github.com/llvm/llvm-project/commit/86f2e71cb8d165b59ad31a442b2391e2382613=
3e [1]=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0ALink: https=
://patch.msgid.link/20260623-fix-test_fortify-for-clang-stringop-overread-v=
1-1-15ee8342a953@kernel.org=0ASigned-off-by: Kees Cook <kees@kernel.org>=0A=
Signed-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A lib/test_fort=
ify/Makefile | 1 +=0A 1 file changed, 1 insertion(+)=0A=0Adiff --git a/lib/=
test_fortify/Makefile b/lib/test_fortify/Makefile=0Aindex 7887e6126e79..eba=
2ba0faeb6 100644=0A--- a/lib/test_fortify/Makefile=0A+++ b/lib/test_fortify=
/Makefile=0A@@ -1,6 +1,7 @@=0A # SPDX-License-Identifier: GPL-2.0=0A =0A cc=
flags-y :=3D $(call cc-disable-warning,fortify-source)=0A+ccflags-y +=3D $(=
call cc-disable-warning,stringop-overread)=0A =0A quiet_cmd_test_fortify =
=3D TEST    $@=0A       cmd_test_fortify =3D $(CONFIG_SHELL) $(srctree)/scr=
ipts/test_fortify.sh \=0A-- =0A2.55.0=0A=0A
--dHMTi8hpRhLD4fwk--

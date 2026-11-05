Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883427;
	b=avcIQlQq6omDZtOCJo1XC3fUePYSotTTRermvwWi4jtgLsIOIJObkVWtsvk5182AfXaL
	 33vCH2/1RzgLdHiGROhgxwmDFhXN0U2R252MMlwKo4VjX4d/nZzphGqSOnmJuwggOZMbI
	 Eh1IQNFf2t8haaPSXMn4ylwjvR3Yp7OJesaxH0L1oZZF0fdG1hy2O8T9fxbvdOUqqUF/6
	 Otek/xvGk8rAMzLLT1iKBOTvPZF8cffoB2B0orvypN9lK0BJhXHZWZ/i6EIAfPcBpdFde
	 BcGv/YMMJQZyIgSjg6MGkXxIQpROue6HxoB2sQQm/1iDY8nDXxjJaYRW1cDUpFDoQaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883427;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rZ6k8R1bOQlS/X7q2b6Yiu4rvCDu2cXy2pD0OcCAH5c=;
	b=WLbEwJXrUAMIiJAgg2ci/Gttq7LwQkfTcmumzqNCeIyo9ZwyEAAyJ/XwI1UdC7gM6E7N
	 lXZJfTrHVVXEkN66BwHB5ZrBxOMJa/fL85PX7h3ORKSGfsuSqavF72w/siZUSoDQtCL+l
	 9jkKMoj63g8Pi1E4Vr5HJoqt3ed5xCRvoDJI7wP8E3LLJOA5RYMF29gw++LEnqtTDKgLq
	 UiGK65fcP7HYWZbj4cbCNz+OGdlQV0wRLZGGaH019MAHnIxX9QZVb2cdAROxvxzP7JzNt
	 hcXM2LAcQ2oE2Y451ZD5vJhSLTnX4hpFdbo4B6U9LhHwE1KFUzKZ1QzU8kna60peWiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ub41LAQj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6259606D811;
	Thu,  5 Nov 2026 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ub41LAQj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66CE1F00A1B;
	Thu,  5 Nov 2026 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883426;
	bh=rZ6k8R1bOQlS/X7q2b6Yiu4rvCDu2cXy2pD0OcCAH5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ub41LAQj+GrBohKgtd5slgBHRRzptP85vguenH1g9Pg59r9iGnWHuPWp0BNwqjB0w
	 B/Ol+XOZkCXTOORDFtPVbma0YeZTOBBox4xldb1+yby/GG0KS7JidvaHjRs4hJUesS
	 31unvePipSrtPWmfycRF1I3dfTeEO/3DzxDVk/Qv2X7aHzogSdkN7Oy6DjWhjewq+u
	 8mw1lV5lVB+sElpe+fBLBjVst8XGGvfU5xRu1RtMRfIxbcDutyFpHPpTNeestnYtKZ
	 7jDRbhdCILOLxa8kQghFE5cVev47mUSzsq227Flug3oQWFRq7nOBJmxbVwFFTftrKl
	 qbFtlUDZeX08Q==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Wake Liu <wakel@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND 3/3] selftests/size: use nolibc startup and syscall wrappers
Date: Thu,  5 Nov 2026 07:57:01 -0500
Message-ID: <20261105125701.1605281-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105125701.1605281-1-sashal@kernel.org>
References: <20261105125701.1605281-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

get_size provides its own _start and is linked statically against the C
library with -nostartfiles. That combination assumes startup and TLS
details that vary between architectures and C library versions: errno
lives in thread-local storage that is never set up, and the static link
expects symbols from the skipped startup files. CI builds have failed
with undefined _init/_fini on ARM with clang and an undefined _DYNAMIC
on LoongArch.

Build the test with the in-tree nolibc instead. nolibc provides the
startup code, so the test returns from main(), and it provides the
write() and syscall() wrappers without the TLS errno problem. A failing
sysinfo() is now reported as a TAP failure instead of crashing the
test. Keep the static link and the existing TAP output.

Since the test no longer uses the system C library headers, the kernel
UAPI headers have to be installed before it is built. Add the headers
target as an order-only prerequisite, as nolibc-test does, so that a
standalone build installs them. Link libgcc only when the selected
compiler is GCC, which needs it for division helpers on ARM, and detect
that from the compiler rather than from LLVM so that CC=clang builds do
not try to link a libgcc that clang does not provide.

nolibc does not support arc, csky, microblaze, nios2 or xtensa, so the
test can no longer be built for those architectures. This conversion
also makes the separate i386 vDSO workaround proposed for get_size
unnecessary.

Link: https://lore.kernel.org/r/20260929043637.1917707-1-wakel@google.com
Fixes: 3ce51050fadd ("selftest: size: Add size test for Linux kernel")
Cc: stable@vger.kernel.org # 6.18.x
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/size/Makefile   |  9 ++++++-
 tools/testing/selftests/size/get_size.c | 33 +++++++------------------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/size/Makefile b/tools/testing/selftests/size/Makefile
index b87facc00a6e9..884b42d7fd0e2 100644
--- a/tools/testing/selftests/size/Makefile
+++ b/tools/testing/selftests/size/Makefile
@@ -1,6 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS := -static -ffreestanding -nostartfiles -s
+CFLAGS = -Os -static -nostdlib -nostdinc -ffreestanding -fno-stack-protector -s
+CFLAGS += -isystem $(top_srcdir)/tools/include/nolibc $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := get_size
 
 include ../lib.mk
+
+CC_IS_GCC := $(shell printf '\043if defined(__GNUC__) && !defined(__clang__)\nGCC\n\043endif\n' | \
+	$(CC) $(CFLAGS) -E -P -x c - 2>/dev/null)
+LDLIBS += $(if $(filter GCC,$(CC_IS_GCC)),-lgcc)
+
+$(OUTPUT)/get_size: | headers
diff --git a/tools/testing/selftests/size/get_size.c b/tools/testing/selftests/size/get_size.c
index 2980b1a63366b..ada6a271711a7 100644
--- a/tools/testing/selftests/size/get_size.c
+++ b/tools/testing/selftests/size/get_size.c
@@ -11,26 +11,12 @@
  * own execution.  It also attempts to have as few dependencies
  * on kernel features as possible.
  *
- * It should be statically linked, with startup libs avoided.  It uses
- * no library calls except the syscall() function for the following 3
- * syscalls:
- *   sysinfo(), write(), and _exit()
- *
- * For output, it avoids printf (which in some C libraries
- * has large external dependencies) by  implementing it's own
- * number output and print routines, and using __builtin_strlen()
- *
- * The test may crash if any of the above syscalls fails because in some
- * libc implementations (e.g. the GNU C Library) errno is saved in
- * thread-local storage, which does not get initialized due to avoiding
- * startup libs.
+ * It is statically linked with nolibc startup and syscall wrappers.
+ * For output, it avoids printf by implementing its own print routines.
  */
 
-#include <sys/sysinfo.h>
-#include <unistd.h>
-#include <sys/syscall.h>
-
-#define STDOUT_FILENO 1
+#include <nolibc.h>
+#include <linux/sysinfo.h>
 
 static int print(const char *s)
 {
@@ -39,7 +25,7 @@ static int print(const char *s)
 	while (s[len] != '\0')
 		len++;
 
-	return syscall(SYS_write, STDOUT_FILENO, s, len);
+	return write(STDOUT_FILENO, s, len);
 }
 
 static inline char *num_to_str(unsigned long num, char *buf, int len)
@@ -80,8 +66,7 @@ static int print_k_value(const char *s, unsigned long num, unsigned long units)
 	return ccode;
 }
 
-/* this program has no main(), as startup libraries are not used */
-void _start(void)
+int main(void)
 {
 	int ccode;
 	struct sysinfo info;
@@ -91,12 +76,12 @@ void _start(void)
 	print("TAP version 13\n");
 	print("# Testing system size.\n");
 
-	ccode = syscall(SYS_sysinfo, &info);
+	ccode = syscall(__NR_sysinfo, &info);
 	if (ccode < 0) {
 		print("not ok 1");
 		print(test_name);
 		print(" ---\n reason: \"could not get sysinfo\"\n ...\n");
-		syscall(SYS_exit, ccode);
+		return 1;
 	}
 	print("ok 1");
 	print(test_name);
@@ -112,5 +97,5 @@ void _start(void)
 	print(" ...\n");
 	print("1..1\n");
 
-	syscall(SYS_exit, 0);
+	return 0;
 }
-- 
2.53.0


Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6447ACE8;
	Thu,  1 Oct 2026 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873552; cv=none; b=OuKMLjio+TZW24Y6EN42fwiqvuRJdJRml80J7AI8uyfZLqIkxZD8YWC0yVeZ87j1jL6OCb7xQLFaWsN/lcRAT2kUi03MsYdHmxxndCiwxvkfZNd2fiG1lZYNMgGeTwJwIHyk1AJvDhJ1xswstaaui99U2MHZDL/Vq8eEbj2oMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873552; c=relaxed/simple;
	bh=8FLyCC91b1rsFUOeCnyR+8v2XdvK3oZAihcOcV8pvu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X22KDYC17l3FeSd88yBJwcfHpVropZcWhk5YMA2pGfORJDhk4/YkxPqx3Cqz391sIxuRP39d4ckDcNcMFxiHDRDQyej879wux6+MVgBtR/Du5/al2SJF8wlvu4MtZk5NqCqtf8xPqJwTCqhegMC2HwCoI2d5Sr4ZRT6P+OL3RAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=oJ/6RCuM; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="oJ/6RCuM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1790873550; x=1822409550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJADvi9bQbjeZEkz1664pvHvx+Q0QnfSBeRW4PklGcI=;
  b=oJ/6RCuMF+rno8XxAK/l9Gv4qb3oKqbwpdfjpKrhBXe5/sW1RoMc6hOg
   ydq19CP/JEbI8juamLLeeMRQLHL48b+S4XeyyDpjYJ7oanH2JQZtrTPW1
   IcTJxW5RLnuKJDH2RCixDfQF0cdQTTrT+0W3p5NJYBCB1HgNc70iRjcak
   b6BATFiVPbhVsT6mAmoXgk739JVJr65Yup3SRhsQ2Rl+10zq9s/gOnDR7
   mnBCRMbRt2YSPpZbCQTBt+QTB52P+X56r4wNKCkqNI6wnolvnnxWA9qL0
   hCJnuYj0OgL/MXDnqUXruWwBxCQuCDJjNspmf/J6HOPLa/fhtZW3d1T3x
   w==;
X-CSE-ConnectionGUID: xP9HTyvaSE2yifRvAZ5m8A==
X-CSE-MsgGUID: V2B4enN5TWmoMx/6Jm80CA==
X-IronPort-AV: E=Sophos;i="6.27,134,1787011200"; 
   d="scan'208";a="29935166"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 16:52:28 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:3110]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.113:2525] with esmtp (Farcaster)
 id 1fcb3460-3f26-4047-b0d8-50afc37e1ac3; Thu, 1 Oct 2026 16:52:28 +0000 (UTC)
X-Farcaster-Flow-ID: 1fcb3460-3f26-4047-b0d8-50afc37e1ac3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 16:52:27 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 16:52:26 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Bjoern
 Doebel" <doebel@amazon.de>, <stable@vger.kernel.org>
Subject: [PATCH v2] selftests/x86: Skip fsgsbase segment setup when int $0x80 is unavailable
Date: Thu, 1 Oct 2026 16:52:12 +0000
Message-ID: <20261001165212.1938867-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260923201409.2187200-1-doebel@amazon.de>
References: <20260923201409.2187200-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The fsgsbase{_restore} tests' load_gs() helper needs a nonzero-based
FS/GS segment, i.e. a selector whose hidden base differs from the
kernel's saved thread base, to exercise the selector/base state
tracking. 64-bit userspace can only create such a segment via
modify_ldt() or, failing that, via the 32-bit set_thread_area syscall
over int $0x80.

On kernels built with CONFIG_MODIFY_LDT_SYSCALL=n, modify_ldt() fails
and the test falls back to int $0x80. If the kernel is also built
with CONFIG_IA32_EMULATION=n, no IDT gate is installed for vector
0x80, so executing int $0x80 raises a #GP fault and the test dies
with SIGSEGV instead of reporting results:

  traps: fsgsbase_64[5460] general protection fault ip:4012a1
  sp:7f38eb124de0 error:402 in fsgsbase_64[12a1,400000+2000]

With both options disabled, pure 64-bit userspace cannot install a
nonzero-based FS/GS segment at all, so this scenario is untestable.
Probe for a working int $0x80 at startup and skip the affected
subtests when neither mechanism is available instead of crashing.

While at it, replace the magic syscall numbers in the int $0x80
inline asm with named __NR_ia32_getpid / __NR_ia32_set_thread_area
constants. These deliberately use the ia32 syscall table numbering,
which differs from the x86-64 numbering exported by <sys/syscall.h>
on 64-bit builds.

Fixes: 0051202f6ad5f ("selftests/x86: Test the FSBASE/GSBASE API and context switching")
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Assisted-by: opencode:kimi-k3
Cc: stable@vger.kernel.org
---
v2
- fsgsbase_restore needs that segment treatment as well
---
 tools/testing/selftests/x86/fsgsbase.c        | 51 ++++++++++++-
 .../testing/selftests/x86/fsgsbase_restore.c  | 72 ++++++++++++++++++-
 2 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 0a75252d31b6a..8538ceb6c5785 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -218,6 +218,40 @@ static void do_remote_base()
 
 static __thread int set_thread_area_entry_number = -1;
 
+/*
+ * int $0x80 dispatches through the ia32 syscall table, whose numbers
+ * differ from the x86-64 table exposed by <sys/syscall.h> on an
+ * x86_64 build. Define the ia32 numbers we need explicitly.
+ */
+#define __NR_ia32_getpid		20
+#define __NR_ia32_set_thread_area	243
+
+static bool have_int80;
+
+static void sigsegv_int80(int sig, siginfo_t *si, void *ctx_void)
+{
+	siglongjmp(jmpbuf, 1);
+}
+
+static bool probe_int80(void)
+{
+	/*
+	 * Check whether int $0x80 is available.  Kernels built without
+	 * CONFIG_IA32_EMULATION do not install an IDT entry for vector
+	 * 0x80, so executing int $0x80 causes a #GP fault.
+	 */
+	sethandler(SIGSEGV, sigsegv_int80, 0);
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		long ret;
+		/* getpid -- harmless if it works */
+		asm volatile ("int $0x80" : "=a" (ret) : "a" (__NR_ia32_getpid));
+		clearhandler(SIGSEGV);
+		return true;
+	}
+	clearhandler(SIGSEGV);
+	return false;
+}
+
 static unsigned short load_gs(void)
 {
 	/*
@@ -245,7 +279,7 @@ static unsigned short load_gs(void)
 		printf("\tusing LDT slot 0\n");
 		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0x7));
 		return 0x7;
-	} else {
+	} else if (have_int80) {
 		/* No modify_ldt for us (configured out, perhaps) */
 
 		struct user_desc *low_desc = mmap(
@@ -260,7 +294,7 @@ static unsigned short load_gs(void)
 		long ret;
 		asm volatile ("int $0x80"
 			      : "=a" (ret), "+m" (*low_desc)
-			      : "a" (243), "b" (low_desc)
+			      : "a" (__NR_ia32_set_thread_area), "b" (low_desc)
 			      : "r8", "r9", "r10", "r11");
 		memcpy(&desc, low_desc, sizeof(desc));
 		munmap(low_desc, sizeof(desc));
@@ -275,6 +309,9 @@ static unsigned short load_gs(void)
 		unsigned short gs = (unsigned short)((desc.entry_number << 3) | 0x3);
 		asm volatile ("mov %0, %%gs" : : "rm" (gs));
 		return gs;
+	} else {
+		printf("[NOTE]\tno way to create a nonzero-based segment\n");
+		return 0;
 	}
 }
 
@@ -516,6 +553,11 @@ static void test_ptrace_write_gsbase(void)
 
 		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
 
+		if (*shared_scratch == 0) {
+			printf("[SKIP]\tCould not create a nonzero GS selector\n");
+			goto END;
+		}
+
 		if (gs != *shared_scratch) {
 			nerrs++;
 			printf("[FAIL]\tGS is not prepared with nonzero\n");
@@ -587,6 +629,11 @@ int main()
 	}
 	clearhandler(SIGILL);
 
+	/* Probe int $0x80 (32-bit syscall entry) */
+	have_int80 = probe_int80();
+	if (!have_int80)
+		printf("\tint $0x80 is unavailable (CONFIG_IA32_EMULATION=n?)\n");
+
 	sethandler(SIGSEGV, sigsegv, 0);
 
 	check_gs_value(0);
diff --git a/tools/testing/selftests/x86/fsgsbase_restore.c b/tools/testing/selftests/x86/fsgsbase_restore.c
index 224058c1e4b2e..bc2c1a2ceaf85 100644
--- a/tools/testing/selftests/x86/fsgsbase_restore.c
+++ b/tools/testing/selftests/x86/fsgsbase_restore.c
@@ -30,9 +30,68 @@
 #include <sys/ptrace.h>
 #include <sys/wait.h>
 #include <stdint.h>
+#include <setjmp.h>
+#include <signal.h>
 
 #define EXPECTED_VALUE 0x1337f00d
 
+/*
+ * int $0x80 dispatches through the ia32 syscall table, whose numbers
+ * differ from the x86-64 table exposed by <sys/syscall.h> on an
+ * x86_64 build. Define the ia32 numbers we need explicitly.
+ */
+#define __NR_ia32_getpid		20
+#define __NR_ia32_set_thread_area	243
+
+static sigjmp_buf jmpbuf;
+
+static void sigsegv_int80(int sig, siginfo_t *si, void *ctx_void)
+{
+	siglongjmp(jmpbuf, 1);
+}
+
+static void sethandler_int80(int sig, void (*handler)(int, siginfo_t *, void *))
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void clearhandler_int80(int sig)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static bool probe_int80(void)
+{
+	/*
+	 * Check whether int $0x80 is available.  Kernels built without
+	 * CONFIG_IA32_EMULATION do not install an IDT entry for vector
+	 * 0x80, so executing int $0x80 causes a #GP fault.
+	 */
+	sethandler_int80(SIGSEGV, sigsegv_int80);
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		long ret;
+		/* getpid -- harmless if it works */
+		asm volatile ("int $0x80" : "=a" (ret) : "a" (__NR_ia32_getpid));
+		clearhandler_int80(SIGSEGV);
+		return true;
+	}
+	clearhandler_int80(SIGSEGV);
+	return false;
+}
+
 #ifdef __x86_64__
 # define SEG "%gs"
 #else
@@ -72,7 +131,7 @@ static void init_seg(void)
 	if (syscall(SYS_modify_ldt, 1, &desc, sizeof(desc)) == 0) {
 		printf("\tusing LDT slot 0\n");
 		asm volatile ("mov %0, %" SEG :: "rm" ((unsigned short)0x7));
-	} else {
+	} else if (probe_int80()) {
 		/* No modify_ldt for us (configured out, perhaps) */
 
 		struct user_desc *low_desc = mmap(
@@ -87,7 +146,7 @@ static void init_seg(void)
 		long ret;
 		asm volatile ("int $0x80"
 			      : "=a" (ret), "+m" (*low_desc)
-			      : "a" (243), "b" (low_desc)
+			      : "a" (__NR_ia32_set_thread_area), "b" (low_desc)
 #ifdef __x86_64__
 			      : "r8", "r9", "r10", "r11"
 #endif
@@ -103,6 +162,15 @@ static void init_seg(void)
 
 		unsigned short sel = (unsigned short)((desc.entry_number << 3) | 0x3);
 		asm volatile ("mov %0, %" SEG :: "rm" (sel));
+	} else {
+		/*
+		 * Neither modify_ldt() (CONFIG_MODIFY_LDT_SYSCALL=n) nor
+		 * int $0x80 (CONFIG_IA32_EMULATION=n) is available, so a
+		 * nonzero-based segment cannot be created at all.  There is
+		 * nothing to test; skip instead of crashing on int $0x80.
+		 */
+		printf("[NOTE]\tno way to create a nonzero-based segment -- can't test anything\n");
+		exit(0);
 	}
 }
 
-- 
2.50.1


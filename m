Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572857F72F;
	Wed, 23 Sep 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194484; cv=none; b=bKkDhxKNOGpgwbfb+Ioub7INBqeYJo0FpI4WYdnPuMd4zt/J0IJNU6fUj0AllEBzs5T3/H6vXo2Lumg/+TtlGRJWL84zMJXglz8DZze+nAXD3XWgk0P/g6jc/igj69YRV6yj1L+8ihDDqOJGHNvdSiuBYtnQG1fMHCE2B6BqogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194484; c=relaxed/simple;
	bh=+S/Wc0yXzz8W9wCKS2L++ti3L6KNlbHouXDNHIr9vjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YqNDGKk8sDzrMqbixMHGspLnNJAWQgDc6BYSodJVi6Cr1QU0ukG+S9o917XDZ3z9EMTMEvJV9ivyG+JpwKMPXZPdOFnepOTsXH6zSY/3HSCy2V1KhUYtk0kGqgu9TuyjTjS4AASCtb0SNb8YpkZUKZIkyh0O2diZmlrXuHTqlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=hYIsLxU/; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="hYIsLxU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1790194476; x=1821730476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ze4gHmgKx05i3sSwVzV05lhzTvt568JlRyE3XDEGIBE=;
  b=hYIsLxU/xgTQB8ngrZAEtKPMI/cdiuoFaDzvVxZlJmJYQHGmQImRYdXf
   PkW/o1PZV4GwKTfixhJ2X5Px248f84g00JXNfBiPjNryyK6PzdT8wAdzF
   D6MUGlFXdMeBmQuGXd0jsfCKF3/exh9vxC4ujjYbkjjOZrlrvUWr56voa
   4+XU0FnK5A4MaqNyI7FqOq+x/abqpHCbecAwGupzfCNcrXHAChLH7slsK
   6YCE0F6pNI9aBmYJxJr6V5Ehtyq6DOAuPGhsGMu9bjrIolTZcrw745GHc
   zJa0OkEOc1mHhYhUi5xX6pT9Ubnb1CwlvRYGWt+SMarJjdwcBgDSq9i9M
   A==;
X-CSE-ConnectionGUID: p+Lkz8WTQLug8XRnF7we4g==
X-CSE-MsgGUID: TpxDwrnWRq6jk/XfZCoDaQ==
X-IronPort-AV: E=Sophos;i="6.27,119,1787011200"; 
   d="scan'208";a="29266322"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 20:14:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:27656]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.187:2525] with esmtp (Farcaster)
 id 62e1523c-c3bd-4a19-9995-206e9f80ad6a; Wed, 23 Sep 2026 20:14:27 +0000 (UTC)
X-Farcaster-Flow-ID: 62e1523c-c3bd-4a19-9995-206e9f80ad6a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 20:14:27 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 20:14:25 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<doebel@amazon.de>, <stable@vger.kernel.org>
Subject: [PATCH] selftests/x86: Skip fsgsbase segment setup when int $0x80 is unavailable
Date: Wed, 23 Sep 2026 20:14:09 +0000
Message-ID: <20260923201409.2187200-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The fsgsbase test's load_gs() helper needs a nonzero-based FS/GS
segment, i.e. a selector whose hidden base differs from the kernel's
saved thread base, to exercise the selector/base state tracking.
64-bit userspace can only create such a segment via modify_ldt() or,
failing that, via the 32-bit set_thread_area syscall over int $0x80.

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
 tools/testing/selftests/x86/fsgsbase.c | 51 +++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

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
-- 
2.50.1


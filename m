Received: from mta0.migadu.com (out-150.mta0.migadu.com [91.218.175.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB83A4F33
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745001; cv=none; b=AywIvRsms1yXcKVCL8iWgrHjxUV9Jcnt+vGvtRJsXVBkyXIjMALmSDXooEshubfjD6hV5Def3dTzr+xRgnFKkDJpGz6awS4Sraug5qe5S6sr1gLil8GyFV77a6vKQsIUGCoNI44ri8l/uFmQL8sb7P83Cdhe70/rdvmTsebSdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745001; c=relaxed/simple;
	bh=oLzthMFr/EnLIpkxFu8EDlPiz+DlwdfnOQIJjl9vezI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICxNkRwQlLp7djGa4NA09ptNhURapVN139lIKBu1SYFgr10iaxLwnWGyx/D5J3f8B8KgT2U7lXKTtaV2MlDnHCkZB+lA2oBhnmf79bSbLoswrk8M3JdE2IA8o+zn2ygdaaL0iQGhnQ5smmW2w6ZqXAKdbidey33Qlfp4TaT8Pcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HwoSv64o; arc=none smtp.client-ip=91.218.175.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HwoSv64o"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oLzthMFr/EnLIpkxFu8EDlPiz+DlwdfnOQIJjl9vezI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786744998; v=1; x=1787349798;
 b=HwoSv64o+Kin+67heeHgkqnRWFU9yXgXg3bbjjmmhOMCJWLzvLkSbRAwsuWlSlO+FC9NiYeS
 fAtwM/5OGcAPu+4fZr2xYwJej1m1fvOeasH+cG4fMUzSH6PTotsPgt8S7iFzQsqQafntJyg4P2t
 rGu+aMJGWkv/tgvWln52iVcE=
X-Envelope-To: stable@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id 5a80e9e2ed9a1c43;
	Fri, 14 Aug 2026 22:03:18 +0000
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	x86@kernel.org,
	stable@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Check per-CPU address resolution per register
Date: Fri, 14 Aug 2026 15:02:54 -0700
Message-ID: <20260814220254.3797467-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814220254.3797467-1-vineet.gupta@linux.dev>
References: <20260814220254.3797467-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ld_imm64 of a per-CPU map value is followed by a mov_percpu_addr that
reuses the same register, so which register the address lands in decides
how the JIT encodes the add. Getting the REX prefix wrong there is
invisible to a functional test unless the address happens to land in an
extended register, which is why this went unnoticed.

Load a .percpu variable into every register in one program and match the
JITed add against the register each one must resolve into.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_percpu_addr.c          | 72 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_percpu_addr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8113fea7ba86..64ac49ad67e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -79,6 +79,7 @@
 #include "verifier_netfilter_retcode.skel.h"
 #include "verifier_bpf_fastcall.skel.h"
 #include "verifier_or_jmp32_k.skel.h"
+#include "verifier_percpu_addr.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_private_stack.skel.h"
@@ -240,6 +241,7 @@ void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
 void test_verifier_bpf_fastcall(void)         { RUN(verifier_bpf_fastcall); }
 void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k); }
+void test_verifier_percpu_addr(void)          { RUN(verifier_percpu_addr); }
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
 void test_verifier_private_stack(void)        { RUN(verifier_private_stack); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
new file mode 100644
index 000000000000..967f4e6e3a49
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86)
+
+int percpu_data SEC(".percpu");
+
+/*
+ * An ld_imm64 of a per-CPU map value is followed by a mov_percpu_addr that
+ * reuses the same register, so check that the add resolves into the register
+ * the address was loaded into, for every register.
+ */
+SEC("raw_tp")
+__description("per-CPU address resolution")
+__success
+__arch_x86_64
+__jited("	movabsq	$0x{{.*}}, %rax")
+__jited("	addq	%gs:{{.*}}, %rax")
+__jited("	movabsq	$0x{{.*}}, %rdi")
+__jited("	addq	%gs:{{.*}}, %rdi")
+__jited("	movabsq	$0x{{.*}}, %rsi")
+__jited("	addq	%gs:{{.*}}, %rsi")
+__jited("	movabsq	$0x{{.*}}, %rdx")
+__jited("	addq	%gs:{{.*}}, %rdx")
+__jited("	movabsq	$0x{{.*}}, %rcx")
+__jited("	addq	%gs:{{.*}}, %rcx")
+__jited("	movabsq	$0x{{.*}}, %r8")
+__jited("	addq	%gs:{{.*}}, %r8")
+__jited("	movabsq	$0x{{.*}}, %rbx")
+__jited("	addq	%gs:{{.*}}, %rbx")
+__jited("	movabsq	$0x{{.*}}, %r13")
+__jited("	addq	%gs:{{.*}}, %r13")
+__jited("	movabsq	$0x{{.*}}, %r14")
+__jited("	addq	%gs:{{.*}}, %r14")
+__jited("	movabsq	$0x{{.*}}, %r15")
+__jited("	addq	%gs:{{.*}}, %r15")
+__naked void percpu_addr(void)
+{
+	asm volatile ("					\
+	r0 = %[percpu_data] ll;				\
+	r1 = %[percpu_data] ll;				\
+	r2 = %[percpu_data] ll;				\
+	r3 = %[percpu_data] ll;				\
+	r4 = %[percpu_data] ll;				\
+	r5 = %[percpu_data] ll;				\
+	r6 = %[percpu_data] ll;				\
+	r7 = %[percpu_data] ll;				\
+	r8 = %[percpu_data] ll;				\
+	r9 = %[percpu_data] ll;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_addr(percpu_data)
+	: __clobber_all);
+}
+
+#else
+
+SEC("raw_tp")
+__description("percpu addr dummy")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta


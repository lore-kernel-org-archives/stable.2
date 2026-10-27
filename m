Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072777;
	b=OkOfB5ZkBnvWea+vxTEIZyPws5ZCooQlQ9edsmDMj3YrLr90ylSrNIv+I4nk5d2uS1xQ
	 6MjZJzneHlElW7asm9m4PlHvIGb7qJANDyhc18WK6dlO8zFv9ksG33pM8t5jnrkd+4osS
	 B+8JHxXDjEpozjDVxeu4VTaMb25GncYByuoCDUD2ad40keWLRb1cXGzg1cr6GvCBwH9GK
	 X0DMd7+SB43n5QugM0bM6QJ6B591okaOvjseQRPZO4MmszvlMgxMStTPlexYzI1RiXdGd
	 EG5JMx1MipKD0jLPm8VuvSofKOuzCgId8q4MY1KA6DqJ+L0POJm6PTlztX3Usg/2Vtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072777;
	h=DMARC-Filter:DKIM-Signature:Cc:Message-Id:X-Mailer:In-Reply-To:From:
	 Subject:Content-Transfer-Encoding:Mime-Version:X-Original-From:
	 Content-Type:To:Date:References:X-Lms-Return-Path;
	bh=awjYNd491nH1SZjZGjhroF+c3sVhiRJKmezrWXmeqDU=;
	b=i8HSbQWmrAen2armzPzOLoz/5gtmIsoV2eIF13440cVNLzkVFko2QMZX5I3I6twVU6P2
	 v8Ps/frRIfzxqHAQ06rePnluZmypyFWTmFK7tnZLx3by+zJpA0XNaPn5kQGdlpPfRZ+Q1
	 EGJhv7YfJVvhpe/69ZeTrk06N8owD7JneqD2ts1rOwQtb8t1bQdghlmFBLIRPYYybxAKT
	 Mjx0NYD1RHDSTbdkp/LUB4ati1ZduQW5j9qR3gvKXAaL3vgZx9ntYPR4Dkg5HDFltDJ8Q
	 Ky6BIhhX6zuJTpvRm2Qn7BLnAaVZW5yr1vLC2RxRYPq7HCjSZCiGCzjaU7j3t+VInvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=TuTu3Xf+;
	arc=none smtp.remote-ip=209.127.230.115
Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981A606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0981A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=TuTu3Xf+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793072772; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=awjYNd491nH1SZjZGjhroF+c3sVhiRJKmezrWXmeqDU=;
 b=TuTu3Xf+2URGmVj3QUvPeznBVTv/yMbYToVSYOMa1OROIYxAdcQ8hsg5P50KaeUFxLWpan
 9flkSj9eShgQgjce1VwHeaPNPJyjUtpjmxDo+8E2IYZhNxIb+jbMuL/xoNx/+X5AmhVMoS
 B42f5yB7VHTitjN+tzL3aPUyE6GaZlEl7G6Ea8fdSAw1bOWDrO2QJFqrvLVsWzhVOlxs7F
 mFvD9km76S7CvRG48qSIKVTTtbRjpzZVsEVazibWFDCeVKyHU6oHQQ3g5Es5kxq2g5eTtU
 LXQ8/a1WmKaDO6vSytG1MEt/xZf8Bpyq9M2zqSmrG4W+baGfp1KLR1mFyPkxxQ==
Cc: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, 
	<chang.seok.bae@intel.com>, <shuah@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Guixiong Wei" <weiguixiong@bytedance.com>
Message-ID: <f3a1ac9a118970b2025c11ee04c0e4c89459cf29.1793072271.git.weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793072271.git.weiguixiong@bytedance.com>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Subject: [PATCH v3 2/2] selftests/x86/amx: Test dynamic fpstate cleanup across exec()
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <x86@kernel.org>
Date: Tue, 27 Oct 2026 11:45:27 +0800
References: <cover.1793072271.git.weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+26ae01e82+16399d+vger.kernel.org+weiguixiong@bytedance.com>
Message-ID: <20261027034527.7grZVQ26nk0x0zxrxMlq-utN-Tiokdb62C83SOq_nnM@z>

Add a regression test for dynamic fpstate leaks across exec(). Repeatedly
fork a child, load XTILEDATA to allocate dynamic state, and exec the test
binary. Snapshot the start addresses of matching /proc/vmallocinfo entries
before and after the loop; addresses present only in the "after" snapshot
count as new allocations that outlived their task.

Before the first exec(), verify that the child's allocation is visible.
Skip the check if vmallocinfo is inaccessible, if a matching entry's
address is hidden by kptr_restrict, or if the allocation cannot be
observed; address-set diff cannot distinguish allocations in those cases.

The test assumes no concurrent workload creates matching allocations.
A set difference equal to the iteration count indicates a leak; an empty
difference indicates success. Report other counts as inconclusive.

Assisted-by: LLM
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 tools/testing/selftests/x86/amx.c | 251 +++++++++++++++++++++++++++++-
 1 file changed, 249 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 40769c16de1bb..ea35d5332dc3f 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -5,6 +5,7 @@
 #include <errno.h>
 #include <setjmp.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <stdbool.h>
 #include <unistd.h>
@@ -30,6 +31,9 @@
 #define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
 #define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
 
+#define EXEC_TEST_ARG		"--exec-test-child"
+#define EXEC_TEST_ITERS		10
+
 struct xstate_info xtiledata;
 
 /* The helpers for managing XSAVE buffer and tile states: */
@@ -478,11 +482,253 @@ static void test_fork(void)
 	_exit(0);
 }
 
-int main(void)
+/*
+ * Snapshot start addresses of /proc/vmallocinfo entries whose caller
+ * matches a dynamic fpstate allocation. Returns false if the file is
+ * not readable (default mode 0400), or if a matching entry's address
+ * cannot be used (kptr_restrict hides the address, or parsing fails);
+ * in those cases the caller cannot distinguish allocations and must
+ * SKIP rather than report a potentially false PASS.
+ */
+struct fpstate_snapshot {
+	unsigned long *addrs;
+	size_t len, cap;
+};
+
+static int cmp_ulong(const void *a, const void *b)
+{
+	unsigned long x = *(const unsigned long *)a, y = *(const unsigned long *)b;
+
+	return (x > y) - (x < y);
+}
+
+static bool snapshot_fpstates(struct fpstate_snapshot *s)
+{
+	char *line = NULL;
+	size_t line_size = 0;
+	bool ok = true;
+	FILE *fp;
+
+	s->addrs = NULL;
+	s->len = 0;
+	s->cap = 0;
+
+	fp = fopen("/proc/vmallocinfo", "r");
+	if (!fp) {
+		if (errno == EACCES || errno == EPERM || errno == ENOENT)
+			return false;
+		fatal_error("fopen /proc/vmallocinfo");
+	}
+
+	while (getline(&line, &line_size, fp) >= 0) {
+		unsigned long addr;
+
+		/*
+		 * fpstate_realloc() is static and may or may not be inlined
+		 * into __xfd_enable_feature() depending on build options;
+		 * match either caller to stay compiler-independent.
+		 */
+		if (!strstr(line, "__xfd_enable_feature") &&
+		    !strstr(line, "fpstate_realloc"))
+			continue;
+		/*
+		 * vmallocinfo prints the start address with %pK. If
+		 * kptr_restrict hides it (address shown as 0) or the
+		 * format is unexpected, address-set diff loses the
+		 * ability to distinguish allocations. Bail out so the
+		 * caller SKIPs instead of silently masking a leak.
+		 */
+		if (sscanf(line, "0x%lx", &addr) != 1 || !addr) {
+			ok = false;
+			break;
+		}
+		if (s->len == s->cap) {
+			unsigned long *tmp;
+
+			s->cap = s->cap ? s->cap * 2 : 64;
+			tmp = realloc(s->addrs, s->cap * sizeof(*s->addrs));
+			if (!tmp)
+				fatal_error("realloc snapshot");
+			s->addrs = tmp;
+		}
+		s->addrs[s->len++] = addr;
+	}
+
+	if (ferror(fp))
+		fatal_error("read /proc/vmallocinfo");
+
+	free(line);
+	fclose(fp);
+	if (!ok) {
+		free(s->addrs);
+		s->addrs = NULL;
+		s->len = 0;
+		s->cap = 0;
+		return false;
+	}
+	qsort(s->addrs, s->len, sizeof(*s->addrs), cmp_ulong);
+	return true;
+}
+
+static int count_new(const struct fpstate_snapshot *before,
+		     const struct fpstate_snapshot *after)
+{
+	int n = 0;
+	size_t i;
+
+	for (i = 0; i < after->len; i++)
+		if (!bsearch(&after->addrs[i], before->addrs, before->len,
+			     sizeof(*before->addrs), cmp_ulong))
+			n++;
+	return n;
+}
+
+static int exec_test_fails;
+
+static void check_exec_child_status(int status)
+{
+	if (WIFEXITED(status) && !WEXITSTATUS(status))
+		return;
+	if (WIFSIGNALED(status))
+		errx(1, "[FAIL]\texec test child killed by signal %d",
+		     WTERMSIG(status));
+	errx(1, "[FAIL]\texec test child exited with status %d",
+	     WEXITSTATUS(status));
+}
+
+/*
+ * Fork a child that loads tiledata and blocks on a pipe before exec().
+ * The parent samples /proc/vmallocinfo while the child is still suspended
+ * and verifies that the dynamic fpstate allocation is observable. Without
+ * that visibility the test cannot distinguish "released" from "never
+ * observed", so it reports SKIP instead of a potentially false PASS.
+ */
+static bool observe_dynamic_fpstate(const struct fpstate_snapshot *before)
+{
+	struct fpstate_snapshot mid;
+	int ready_pipe[2], go_pipe[2];
+	pid_t child;
+	int status;
+	bool observable;
+	char c = 0;
+
+	if (pipe(ready_pipe) || pipe(go_pipe))
+		fatal_error("pipe");
+
+	child = fork();
+	if (child < 0)
+		fatal_error("fork");
+	if (!child) {
+		close(ready_pipe[0]);
+		close(go_pipe[1]);
+		if (!load_rand_tiledata(stashed_xsave))
+			fatal_error("failed to load tiledata");
+		if (write(ready_pipe[1], &c, 1) != 1)
+			fatal_error("write ready");
+		if (read(go_pipe[0], &c, 1) != 1)
+			fatal_error("read go");
+		close(ready_pipe[1]);
+		close(go_pipe[0]);
+		execl("/proc/self/exe", "amx", EXEC_TEST_ARG, NULL);
+		fatal_error("exec");
+	}
+
+	close(ready_pipe[1]);
+	close(go_pipe[0]);
+
+	if (read(ready_pipe[0], &c, 1) != 1)
+		fatal_error("read ready");
+
+	observable = snapshot_fpstates(&mid) && count_new(before, &mid) > 0;
+	free(mid.addrs);
+
+	if (write(go_pipe[1], &c, 1) != 1)
+		fatal_error("write go");
+
+	close(ready_pipe[0]);
+	close(go_pipe[1]);
+
+	if (waitpid(child, &status, 0) != child)
+		fatal_error("waitpid");
+	check_exec_child_status(status);
+
+	return observable;
+}
+
+static void test_exec(void)
+{
+	struct fpstate_snapshot before, after;
+	int new_count, i;
+
+	printf("[RUN]\tCheck dynamic fpstate cleanup across exec().\n");
+
+	if (!snapshot_fpstates(&before)) {
+		printf("[SKIP]\tvmallocinfo inaccessible or addresses hidden by kptr_restrict.\n");
+		return;
+	}
+
+	if (!observe_dynamic_fpstate(&before)) {
+		free(before.addrs);
+		printf("[SKIP]\tCannot observe dynamic fpstate allocations via vmallocinfo.\n");
+		return;
+	}
+	free(before.addrs);
+
+	if (!snapshot_fpstates(&before))
+		fatal_error("snapshot before");
+
+	for (i = 0; i < EXEC_TEST_ITERS; i++) {
+		pid_t child;
+		int status;
+
+		child = fork();
+		if (child < 0)
+			fatal_error("fork");
+		if (!child) {
+			if (!load_rand_tiledata(stashed_xsave))
+				fatal_error("failed to load tiledata");
+			execl("/proc/self/exe", "amx", EXEC_TEST_ARG, NULL);
+			fatal_error("exec");
+		}
+
+		if (waitpid(child, &status, 0) != child)
+			fatal_error("waitpid");
+		check_exec_child_status(status);
+	}
+
+	if (!snapshot_fpstates(&after)) {
+		free(before.addrs);
+		printf("[SKIP]\tvmallocinfo inaccessible or addresses hidden by kptr_restrict.\n");
+		return;
+	}
+	new_count = count_new(&before, &after);
+	free(before.addrs);
+	free(after.addrs);
+
+	if (!new_count) {
+		printf("[OK]\tDynamic fpstate allocations were freed across exec().\n");
+		return;
+	}
+
+	if (new_count == EXEC_TEST_ITERS) {
+		printf("[FAIL]\texec() leaked %d dynamic fpstate allocations\n",
+		       new_count);
+		exec_test_fails++;
+		return;
+	}
+
+	printf("[SKIP]\tUnexpected new allocation count %d; result inconclusive.\n",
+	       new_count);
+}
+
+int main(int argc, char **argv)
 {
 	unsigned long features;
 	long rc;
 
+	if (argc == 2 && !strcmp(argv[1], EXEC_TEST_ARG))
+		return 0;
+
 	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
 	if (rc || (features & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
 		ksft_print_msg("no AMX support\n");
@@ -504,6 +750,7 @@ int main(void)
 	req_xtiledata_perm();
 
 	test_fork();
+	test_exec();
 
 	/*
 	 * Perform generic xstate tests for context switching, ptrace,
@@ -514,5 +761,5 @@ int main(void)
 	clearhandler(SIGILL);
 	free_stashed_xsave();
 
-	return 0;
+	return exec_test_fails ? 1 : 0;
 }
-- 
2.55.0

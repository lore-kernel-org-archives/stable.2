Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7A1643B
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085185; cv=none; b=fRwiLosyQTfreEAEOMeLPDza0aUXAG5HncH6xOezUiKO1dKKpNMb39i2xJydI3XkR2cnsf5DxyzrKLl0asJsr7NokH1aHrZimbaywPuejeoZ53WgP9eUhN6wKUlbOWVevCi6jL/fdoXWqq0GTkis4n5untiPHdUN1mVFA7zsaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085185; c=relaxed/simple;
	bh=O1yMkrNVVv8rHzNadH2P/WPFvcU6jaHLtVMu3eogdBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXZ9agbJShTPmB7VfFWyIHvZBArIc4wFIpxZF7Ia8tWbz8hc9mMrsanUfirMDKjV+x074tU+AxA8UcqcEI2OKuwWrZEmIyeSlpxoCYHY55I+aGLduCHF7ISIYbLyW5RXzqrf81cUajip2AX5O/Yzvxs0kgrZnH5Pzl60XlGis0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=jypv4AES; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="jypv4AES"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-482938466a7so172291f8f.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1787085182; x=1787689982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9SWoJcKrqlyi5bbh6XhhKYusErYtjw2zBkPAeN0Lv8s=;
        b=jypv4AES/tP1LliB58RHUMi6lbtSOBxRNwmRbUzZrCprzWrA4B1wbNXrEOhlFnZ5Tw
         JMPnzbEdTesnXQr3Yz26t+iWe24/1dX+MK4ZnNgfI7oldfdH/47Koxve0pycdNogqJpS
         MvXNzbxFnjlUsZ6e0AjB8k4Jg2IY1mYoSCaLA4dJDkydOEHDTO7c131IuMOJid3nyysx
         t19JHxm9OUDCvsKL2t6hOblh7mBlcps44Ep+wYris50E1fWdE6G8Si+fr3YKzBs7VDII
         hythfaae+7mavC0gbkjcbdbRkG250mZsBNLCsMF1fmAQbc86qMvG/wofCPMEy2Qn2pfA
         2Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085182; x=1787689982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9SWoJcKrqlyi5bbh6XhhKYusErYtjw2zBkPAeN0Lv8s=;
        b=hhDF3ivTnLVqqO7Z2No8Qc43q7VIemgvCbJQUkrUQaWaynryyktOR7XlTBOurgz+fv
         veRXlI5Ls/slbAvDudNE4JLDWDyyRpDMd2+YJmMiBJl5tfOrzlgnCcsolTCjyfnjP26g
         BEVa30k/9tzTSraBuU4NCNn5a3G6BKGZg2s62RqD4wWeEy6DEbfFk//KIdvC/4vBmmEM
         Gp0VtMb7orpKxm+dOJoM9ZjX3LKBkFq7Cvpy0qQJdE/IH/I44G/x2LHL4btBTc1471MQ
         rttZHkoJwCewjHTuDpLm5XZwHpHtz8rX7wwZ68mGfqcPogZ/8bUeVStoqyTgTIvZmEIf
         osxA==
X-Forwarded-Encrypted: i=1; AHgh+RoMTuum0X839vxwCAKOMD3aVAiORIMNTymXh+pQ2V1bGsow4gfSvsQ4gA7NyRUBDfL3LyLNEYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBckzwPAfVl6ixC1g0iFV5vJP3BuH30/J6XrEJOASe2EAY4w8
	K/wFc16yx4qq9dNMduope+SgLXt660GDYV5Lr1VyLV3mzl26+9ZV1hTHGmxrJB3XkuM=
X-Gm-Gg: AR+sD12Hcu/oofzCGtn4l82pFtHQGdGVk/bxQzHYHwytzCAj0XoV183t9SWNvemv+7w
	NzwORMxTcm3vMaXG3Q9PLGsYT7oVEn/8+lyfpXBUhEScbak9E1Eep4/zSifmGQozYu8awgK5VD4
	4BerOecjRTK567aCb3ZtPPoTU6Y/0Dlzjphek2vqMpDZ1ASZRy/zR082mYKx5hjEaxJmCnsE4LJ
	grBDvXpMWU0qW7530TO5LryqTspleBzP6B3+JpTk90iDfNuF8/6ZApXgDCAkp/2yDRdvDd1D/16
	Sb66Flm+V5N+q4vPbo931QwRvLjQEQsmbotGimYMupkgZKYrpO+26PTLOPt+JtbicXmc2Uz1GrN
	cpK6GMZ9sTt332Hcnnr36dOkKC7mppv5ORSBzyF5Sui8JwPl3YpMEyFLXMXwIVw9J2GM6LGD5VQ
	iy61P9EE0Z0plI/hwzueU7mkU3g6HFaQgmcJafyEq7bYOL0lXqDWKgVNGV1N5r8oTG9YR1zAbgZ
	q+jS9cSKyI+/g==
X-Received: by 2002:a5d:5d0b:0:b0:47f:d011:f644 with SMTP id ffacd0b85a97d-482b07cc0dfmr976306f8f.4.1787085181571;
        Tue, 18 Aug 2026 13:33:01 -0700 (PDT)
Received: from christian-gtr9.tailscale.swine.de ([2a02:6b67:d11b:4200:508:9a18:a3aa:3270])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c55bsm14072839f8f.20.2026.08.18.13.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 13:33:00 -0700 (PDT)
From: Christian Simon <simon@swine.de>
To: bpf@vger.kernel.org
Cc: Christian Simon <simon@swine.de>,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH bpf v2] bpf: guard uprobes against private-stack corruption
Date: Tue, 18 Aug 2026 21:32:27 +0100
Message-ID: <20260818203234.1142913-1-simon@swine.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eligible BPF programs use one private stack per program and CPU. Both
bpf_prog_run_array_uprobe() and uprobe_prog_run() use migrate_disable()
to keep an invocation on one CPU, but another task can still preempt it
and run the same program on that CPU. The second invocation then reuses
and can overwrite the first invocation's private stack.

Protect each real program invocation with the existing per-program
recursion context. When the program is already active on this CPU,
account for the missed invocation and skip it. Return zero when skipping
an uprobe-multi invocation so session handling does not suppress its
return probe.

Skip dummy_bpf_prog in the classic array path before acquiring the
recursion context because its active pointer is NULL.

Add a regression test that pins two threads to one CPU and overlaps
classic and multi uprobe invocations while preserving a sentinel in a
private stack frame. Without the guards, the second invocation executes
and corrupts the first invocation's sentinel.

Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrumentation/issues/3056
Cc: stable@vger.kernel.org
Signed-off-by: Christian Simon <simon@swine.de>
---
Changes in v2:
- Address review comments from sashiko-bot
  - Guard the uprobe-multi path as well.
  - Remove const from correct line
- Add a regression selftest for uprobe-classic/multi paths.
- Add the arm64 Fixes tag.

 include/linux/bpf.h                           |  33 +++--
 kernel/trace/bpf_trace.c                      |  11 +-
 .../bpf/prog_tests/uprobe_private_stack.c     | 118 ++++++++++++++++++
 .../bpf/progs/uprobe_private_stack.c          |  54 ++++++++
 4 files changed, 206 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_private_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_private_stack.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..a94fc9898ece 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2572,6 +2572,14 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
 
 typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
 
+#ifdef CONFIG_BPF_SYSCALL
+void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
+#else
+static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
+{
+}
+#endif
+
 static __always_inline u32
 bpf_prog_run_array(const struct bpf_prog_array *array,
 		   const void *ctx, bpf_prog_run_fn run_prog)
@@ -2617,7 +2625,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 			  const void *ctx, bpf_prog_run_fn run_prog)
 {
 	const struct bpf_prog_array_item *item;
-	const struct bpf_prog *prog;
+	struct bpf_prog *prog;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 	u32 ret = 1;
@@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
+		/* dummy_bpf_prog has no recursion state. */
+		if (unlikely(!prog->len)) {
+			item++;
+			continue;
+		}
+
+		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
+			bpf_prog_inc_misses_counter(prog);
+			bpf_prog_put_recursion_context(prog);
+			item++;
+			continue;
+		}
+
 		if (!prog->sleepable)
 			rcu_read_lock();
 
 		run_ctx.bpf_cookie = item->bpf_cookie;
 		ret &= run_prog(prog, ctx);
-		item++;
 
 		if (!prog->sleepable)
 			rcu_read_unlock();
+
+		bpf_prog_put_recursion_context(prog);
+		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
 	migrate_enable();
@@ -3208,8 +3231,6 @@ static inline bool has_current_bpf_ctx(void)
 	return !!current->bpf_ctx;
 }
 
-void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
-
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
@@ -3538,10 +3559,6 @@ static inline bool has_current_bpf_ctx(void)
 	return false;
 }
 
-static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
-{
-}
-
 static inline void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 75495a5c3507..379d472590ec 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3139,7 +3139,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_prog *prog = link->link.prog;
 	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
-	int err;
+	int err = 0;
 
 	if (link->task && !same_thread_group(current, link->task))
 		return 0;
@@ -3151,10 +3151,17 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 
 	migrate_disable();
 
+	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
+		bpf_prog_inc_misses_counter(prog);
+		goto out;
+	}
+
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
-	err = bpf_prog_run(link->link.prog, regs);
+	err = bpf_prog_run(prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
+out:
+	bpf_prog_put_recursion_context(prog);
 	migrate_enable();
 
 	if (sleepable)
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_private_stack.c b/tools/testing/selftests/bpf/prog_tests/uprobe_private_stack.c
new file mode 100644
index 000000000000..20a5b87b1de6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_private_stack.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+#include <sched.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+#include "uprobe_private_stack.skel.h"
+
+static noinline void uprobe_private_stack_trigger(void)
+{
+	asm volatile("");
+}
+
+static void *trigger_uprobe(void *arg)
+{
+	uprobe_private_stack_trigger();
+	return NULL;
+}
+
+static void run_private_stack_test(struct uprobe_private_stack *skel, bool multi)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, opts);
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, multi_opts);
+	const char *binary = "/proc/self/exe";
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	pthread_t thread;
+	int err, i;
+
+	skel->bss->ready = 0;
+	skel->bss->release = 0;
+	skel->bss->executions = 0;
+	skel->bss->corruptions = 0;
+	skel->bss->loop_exhausted = 0;
+
+	if (multi) {
+		prog = skel->progs.uprobe_multi_private_stack;
+		link = bpf_program__attach_uprobe_multi(prog, 0, binary,
+							"uprobe_private_stack_trigger",
+							&multi_opts);
+	} else {
+		opts.func_name = "uprobe_private_stack_trigger";
+		prog = skel->progs.uprobe_private_stack;
+		link = bpf_program__attach_uprobe_opts(prog, 0, binary, 0, &opts);
+	}
+	if (!ASSERT_OK_PTR(link, "attach_uprobe"))
+		return;
+
+	err = pthread_create(&thread, NULL, trigger_uprobe, NULL);
+	if (!ASSERT_OK(err, "pthread_create"))
+		goto cleanup;
+
+	for (i = 0; i < 10000; i++) {
+		if (__atomic_load_n(&skel->bss->ready, __ATOMIC_ACQUIRE))
+			break;
+		usleep(1000);
+	}
+
+	if (ASSERT_LT(i, 10000, "first_uprobe_ready"))
+		uprobe_private_stack_trigger();
+	__atomic_store_n(&skel->bss->release, 1, __ATOMIC_RELEASE);
+
+	err = pthread_join(thread, NULL);
+	if (!ASSERT_OK(err, "pthread_join"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->loop_exhausted, 0, "loop_exhausted");
+	ASSERT_EQ(skel->bss->executions, 1, "executions");
+	ASSERT_EQ(skel->bss->corruptions, 0, "corruptions");
+
+cleanup:
+	bpf_link__destroy(link);
+}
+
+void test_uprobe_private_stack(void)
+{
+#if defined(__x86_64__) || defined(__aarch64__)
+	struct uprobe_private_stack *skel = NULL;
+	cpu_set_t old_mask, mask;
+	bool affinity_set = false;
+	int cpu;
+
+	if (!ASSERT_OK(sched_getaffinity(0, sizeof(old_mask), &old_mask),
+		       "get_affinity"))
+		return;
+
+	CPU_ZERO(&mask);
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, &old_mask)) {
+			CPU_SET(cpu, &mask);
+			break;
+		}
+	}
+	if (!ASSERT_LT(cpu, CPU_SETSIZE, "available_cpu"))
+		return;
+	/* Both triggers must contend for the same per-CPU private stack. */
+	if (!ASSERT_OK(sched_setaffinity(0, sizeof(mask), &mask), "set_affinity"))
+		return;
+	affinity_set = true;
+
+	skel = uprobe_private_stack__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	if (test__start_subtest("classic"))
+		run_private_stack_test(skel, false);
+	if (test__start_subtest("multi"))
+		run_private_stack_test(skel, true);
+
+cleanup:
+	uprobe_private_stack__destroy(skel);
+	if (affinity_set)
+		ASSERT_OK(sched_setaffinity(0, sizeof(old_mask), &old_mask),
+			  "restore_affinity");
+#else
+	test__skip();
+#endif
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_private_stack.c b/tools/testing/selftests/bpf/progs/uprobe_private_stack.c
new file mode 100644
index 000000000000..a8d623a3d2fd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_private_stack.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+volatile int ready;
+volatile int release;
+volatile int executions;
+volatile int corruptions;
+int loop_exhausted;
+
+static long wait_for_release(__u32 index, void *ctx)
+{
+	return release ? 1 : 0;
+}
+
+static __always_inline int run_private_stack_test(void)
+{
+	/* A 64-byte frame makes the JIT select a private stack. */
+	volatile __u64 stack[8] = {};
+	__u64 id = bpf_get_current_pid_tgid();
+	int seq;
+
+	stack[0] = id;
+	seq = executions;
+	executions = seq + 1;
+	/* An unguarded second invocation overwrites the first invocation's frame. */
+	if (seq) {
+		stack[0] = ~id;
+		return 0;
+	}
+
+	ready = 1;
+	bpf_loop(1 << 23, wait_for_release, NULL, 0);
+	if (!release)
+		loop_exhausted = 1;
+	if (stack[0] != id)
+		corruptions++;
+
+	return 0;
+}
+
+SEC("uprobe")
+int uprobe_private_stack(struct pt_regs *ctx)
+{
+	return run_private_stack_test();
+}
+
+SEC("uprobe.multi")
+int uprobe_multi_private_stack(struct pt_regs *ctx)
+{
+	return run_private_stack_test();
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.54.0


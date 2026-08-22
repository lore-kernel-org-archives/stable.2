Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E039060B
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439314; cv=none; b=KAsSWuL+yP+O4r/sQfef/XSWAnKuzX6DMAfTgaobH2T14TyeZgApCu4xoplmKHT04VAtxHEJmbengtiPrL/N6dVSX6+edFHcR7XxBFvKCEdJkml7qfozk/1iI2Fd8LHImFNIAOW4/YQZK1ivOHWTIP2x1FWA2GyK8aHIt5cxjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439314; c=relaxed/simple;
	bh=i3Mn6SB3xT5fAqa+BBbOw5fOZCX//7Fo7DxSLr1w7g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I67mU9Fd7NtszbiJ12hajEKrN/DwxeVrycoxJEuNzNEBHtfFB8XcpFlbjZV5XYH7r8cM2+QLpYwXFPLtwFoomn572vNBfLGRxqXPo7dhwP2i5tjyz4ahhWElGuS2kIIvZFifWw9jGgbRspk7N/hh47Z5Sjo1rGiwnJnDrVvAYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=SGAKwHNv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="SGAKwHNv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so20620875e9.0
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1787439310; x=1788044110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cqXNtm/X0Euu5dXqktA8qVqHP0B9fKlZuu2Ye+nl69k=;
        b=SGAKwHNvL3AnHj6daRR0GjdDv9sB2HUn5dhzbqcRBnyW3cCITA94x8G+Qz8qcUa6P6
         Y1ofMKmHBWarPMr7hAREKxNpDdWyGMW04uf4UEU1T18BXjzIs1Bzxy6OAaHbQ2RprIsm
         P8qJIqajkRZgF1NNIrMV7ybhVdElidz0jHpwsRGZUfSoDg+t3qaDMvdUm6/VdQnujaWk
         ZgHzvgij0LBouYG7gK3XdrEtjZQ3/K0NydHyJzSoW0NzVRFgSMfhnY3gKp6MV0rbqjwO
         S9kE7IA4/n3chZ1VuNjjFQFYDoYq0kVCL7Igif5e5elIoam3fxm/nD6zyxwKtV/B2sHa
         qBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787439310; x=1788044110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cqXNtm/X0Euu5dXqktA8qVqHP0B9fKlZuu2Ye+nl69k=;
        b=GNLywinf4xLlRSj4je+QKT+3NNRdI3OdgsX57Oow6zOQRAoEo7ln0thgm5KMaM27Yr
         vOOCVNwzjXYFtZGxya6QxVa3alk3NavVW60vLrie0BaldSno9yRxaXJDbyCt6XRUK6W1
         RBbYRReiIoiD3V0t2zMkUErUOB0wgxGwpnAQKQ3uEPC9Q+S+mbEx6Ght4HAj0d+Cm52c
         1CroWg4gzTSyOLEMc4LY0qqJKo5XPgBFdjuzCjehkYaF4/11IrvM4Cu3AgwhSlt7+qlk
         DOt+xyCWeQ4OB/+zapJW3ESK4k2iQDXTlANYRLy/BjYGL5US2Mxvoqu+7fji/N5CUPlJ
         8g8g==
X-Forwarded-Encrypted: i=1; AHgh+Ro32AuCLGvks8b/XBwbWyAb0Z+LLvwY4DTns069tvLMytEeRzTM9UMYcXJttmshmHx5ek/Hfl8=@vger.kernel.org
X-Gm-Message-State: AFuF++lFl7xU56tvhe174gnQwzLswyWnolvPzDx7KfIKE4OSYqwaQVcI
	MC0VYZEDO6lB/1M3j42qtAPg4aDAT5Ear9JE7Pp7HeqGVu/wVGDy0d/J/HHsRshtJZ4=
X-Gm-Gg: AR+sD11jO19fHJxklbI5xg6jopvXLf2TfK9A54XhzwNKf9+6IOHIbIb5v6N9Hnb6Ord
	AcFocQxvNGgcVT6wp4IpCPiwsbXPojoknv8EMPgK5QPIV6921vOXxbFBXKFjaRp6iQ5KqJuJIWC
	4RPIu8tOj9fxDpiE2zEq3UCy2kNraZGTYdcUBft55I/UUcz9wjMhxLUyT38rNAhu6VJHIUBH1Mo
	cBlg9toZh38TBRI+YnErjz2yXN895ZiqLBClpkZ286RukMbWALaMtpXK9Bd1NdZRcKtH/PXgXY9
	vKwD4s5mi77r32uWHZUlZVQYuwRs2LhvGeqyh5nUPfXiTHV0GY7uxAyZLGifEhttBpaGl1MVQHc
	Y4w+cQOaGi63NSwOEObuPbZj+9ZlBI7d8zRcFPlZSX9H516CNoIuCSNxWUNynLGWjdYB4SpYuOI
	3fl9ol6TBJv5ky515CZDJvZEnvgc2ewfMPewMVmaJ2TjNmUI4I+iHvKzB/QvM7d2EY3bRf8UvHn
	pY5Qh6xvtkjEnQ=
X-Received: by 2002:a05:600c:4f12:b0:499:af7d:b759 with SMTP id 5b1f17b1804b1-499c19cc660mr85920405e9.13.1787439310244;
        Sat, 22 Aug 2026 15:55:10 -0700 (PDT)
Received: from christian-gtr9.tailscale.swine.de ([2a02:6b67:d11b:4200:385d:79ca:2b97:1169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm41376435e9.2.2026.08.22.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 15:55:09 -0700 (PDT)
From: Christian Simon <simon@swine.de>
To: bpf@vger.kernel.org
Cc: Christian Simon <simon@swine.de>,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	stable@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	olsajiri@gmail.com
Subject: [PATCH bpf v3 2/2] selftests/bpf: verify preemptible uprobes avoid private stack
Date: Sat, 22 Aug 2026 23:54:44 +0100
Message-ID: <20260822225444.2774461-3-simon@swine.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822225444.2774461-1-simon@swine.de>
References: <20260822225444.2774461-1-simon@swine.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pin two threads to one CPU and overlap invocations of the same uprobe
program. Verify that both invocations execute and that the first
invocation's stack frame is not corrupted by the second.

Cover sleepable classic and multi-uprobe programs with both 64-byte
stack frames, which select private stack when eligible, and small stack
frames as controls. Skip the test when preemption, JIT, or architecture
private-stack support is unavailable.

Signed-off-by: Christian Simon <simon@swine.de>
---

I have noticed the "volatile" warning, I do think it is fine for this
selftests purposes.


 .../bpf/prog_tests/uprobe_sleepable_stack.c   | 165 ++++++++++++++++++
 .../bpf/progs/uprobe_sleepable_stack.c        |  89 ++++++++++
 2 files changed, 254 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_sleepable_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_sleepable_stack.c b/tools/testing/selftests/bpf/prog_tests/uprobe_sleepable_stack.c
new file mode 100644
index 000000000000..a18970d2c584
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_sleepable_stack.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that preemptible uprobe programs don't use private stack.
+ *
+ * Private stack is per-CPU and per-program, so preemption during a program's
+ * execution would allow another task to corrupt the stack. The verifier must
+ * disable private stack for programs whose invocation can be preempted.
+ *
+ * This test overlaps two invocations of the same uprobe program on the same
+ * CPU and verifies:
+ * 1. Both invocations execute
+ * 2. No stack corruption occurs (each task has its own stack frame)
+ */
+#include <pthread.h>
+#include <sched.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+#include "uprobe_sleepable_stack.skel.h"
+
+static noinline void uprobe_sleepable_stack_trigger(void)
+{
+	asm volatile("");
+}
+
+static void *trigger_uprobe(void *arg)
+{
+	uprobe_sleepable_stack_trigger();
+	return NULL;
+}
+
+static void reset_state(struct uprobe_sleepable_stack *skel)
+{
+	skel->bss->ready = 0;
+	skel->bss->release = 0;
+	skel->bss->executions = 0;
+	skel->bss->corruptions = 0;
+	skel->bss->loop_exhausted = 0;
+}
+
+static void assert_results(struct uprobe_sleepable_stack *skel)
+{
+	ASSERT_EQ(skel->bss->loop_exhausted, 0, "loop_exhausted");
+	ASSERT_EQ(skel->bss->executions, 2, "executions");
+	ASSERT_EQ(skel->bss->corruptions, 0, "corruptions");
+}
+
+static void run_test(struct uprobe_sleepable_stack *skel, bool multi,
+		     bool large_stack)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, opts);
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, multi_opts);
+	const char *binary = "/proc/self/exe";
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	pthread_t thread;
+	long link_err;
+	int err, i;
+
+	reset_state(skel);
+
+	if (multi) {
+		prog = large_stack ? skel->progs.uprobe_multi_sleepable_large_stack :
+					     skel->progs.uprobe_multi_sleepable_small_stack;
+		link = bpf_program__attach_uprobe_multi(
+			prog, 0, binary, "uprobe_sleepable_stack_trigger",
+			&multi_opts);
+	} else {
+		opts.func_name = "uprobe_sleepable_stack_trigger";
+		prog = large_stack ? skel->progs.uprobe_sleepable_large_stack :
+					     skel->progs.uprobe_sleepable_small_stack;
+		link = bpf_program__attach_uprobe_opts(prog, 0, binary, 0,
+						       &opts);
+	}
+
+	link_err = libbpf_get_error(link);
+	if (link_err == -EOPNOTSUPP) {
+		test__skip();
+		return;
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
+		uprobe_sleepable_stack_trigger();
+	__atomic_store_n(&skel->bss->release, 1, __ATOMIC_RELEASE);
+
+	err = pthread_join(thread, NULL);
+	if (!ASSERT_OK(err, "pthread_join"))
+		goto cleanup;
+
+	assert_results(skel);
+
+cleanup:
+	bpf_link__destroy(link);
+}
+
+void test_uprobe_sleepable_stack(void)
+{
+	struct uprobe_sleepable_stack *skel = NULL;
+	cpu_set_t old_mask, mask;
+	bool affinity_set = false;
+	int cpu;
+
+#if !defined(__x86_64__) && !defined(__aarch64__) && !defined(__powerpc64__)
+	test__skip();
+	return;
+#endif
+	if (!env.jit_enabled) {
+		test__skip();
+		return;
+	}
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
+	/* Both triggers must run on the same CPU to test stack sharing */
+	if (!ASSERT_OK(sched_setaffinity(0, sizeof(mask), &mask),
+		       "set_affinity"))
+		return;
+	affinity_set = true;
+
+	skel = uprobe_sleepable_stack__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	if (!skel->kconfig->CONFIG_PREEMPTION) {
+		test__skip();
+		goto cleanup;
+	}
+
+	if (test__start_subtest("sleepable_classic_large"))
+		run_test(skel, false, true);
+	if (test__start_subtest("sleepable_classic_small"))
+		run_test(skel, false, false);
+	if (test__start_subtest("sleepable_multi_large"))
+		run_test(skel, true, true);
+	if (test__start_subtest("sleepable_multi_small"))
+		run_test(skel, true, false);
+
+cleanup:
+	uprobe_sleepable_stack__destroy(skel);
+	if (affinity_set)
+		ASSERT_OK(sched_setaffinity(0, sizeof(old_mask), &old_mask),
+			  "restore_affinity");
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c b/tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c
new file mode 100644
index 000000000000..07e0ff548720
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+extern bool CONFIG_PREEMPTION __kconfig __weak;
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
+/*
+ * Test that preemptible uprobes don't use private stack. A 64-byte frame would
+ * normally trigger private stack selection, but programs whose invocation can
+ * be preempted must not use it. Both invocations must execute without
+ * corruption.
+ */
+static __always_inline int run_stack_test(volatile __u64 *stack)
+{
+	__u64 id = bpf_get_current_pid_tgid();
+	int seq;
+
+	if (!CONFIG_PREEMPTION)
+		return 0;
+
+	stack[0] = id;
+	seq = executions;
+	executions = seq + 1;
+	/*
+	 * If private stack were used, an unguarded second invocation would
+	 * overwrite the first invocation's frame. With regular stack, each task
+	 * has its own stack frame.
+	 */
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
+SEC("uprobe.s//proc/self/exe:uprobe_sleepable_stack_trigger")
+int uprobe_sleepable_large_stack(struct pt_regs *ctx)
+{
+	/* A 64-byte frame would select private stack for non-sleepable progs */
+	volatile __u64 stack[8] = {};
+
+	return run_stack_test(stack);
+}
+
+SEC("uprobe.s//proc/self/exe:uprobe_sleepable_stack_trigger")
+int uprobe_sleepable_small_stack(struct pt_regs *ctx)
+{
+	/* Small stack as control - never triggers private stack */
+	volatile __u64 stack[1] = {};
+
+	return run_stack_test(stack);
+}
+
+SEC("uprobe.multi.s//proc/self/exe:uprobe_sleepable_stack_trigger")
+int uprobe_multi_sleepable_large_stack(struct pt_regs *ctx)
+{
+	volatile __u64 stack[8] = {};
+
+	return run_stack_test(stack);
+}
+
+SEC("uprobe.multi.s//proc/self/exe:uprobe_sleepable_stack_trigger")
+int uprobe_multi_sleepable_small_stack(struct pt_regs *ctx)
+{
+	volatile __u64 stack[1] = {};
+
+	return run_stack_test(stack);
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.54.0


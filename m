Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D946EF77
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766853; cv=none; b=PUgvvweyjlGbrdQzNgGvBtGnbSRaBVaW5Yy9Azr9BLwBt47h8jNK/e0WgaqpmPBZ/D65CAnxH8Ut6nvhHBTDecz1xAQAldZxYTeO6gMTsMVHznEA5jupfO4hPfvZgCiYXkdZOWKU9xsVcv6Ft23CVFLnHiXiT9VXRd1acDTf7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766853; c=relaxed/simple;
	bh=N1sVBRYBtof0X9/v+HwGL+cwJDMoIWeaDX5yGgdCEhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGKGHw1Z7+qkzNP6kDruV/HCp/7+4xvMVL26M5dvvrqZw+qMxP4UIfDf14NVWVhQgSZEV5gkWoxby/SW/TjIZdcq5yKApf+B29WXmS6Rn2p8VATDJHwFI/v2HS/C9zZk9F3HldGD5czJmSJ4fKXqumduf5i2gLksb/PnwqWz8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo2d7yO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo2d7yO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ABD1F00893;
	Wed, 30 Sep 2026 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766852;
	bh=oqRh1YYCXTiDuyHe1XQa/mAF/ZQVM38nQZiTWl3r4H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mo2d7yO7LKFoe0eq7F/DTVcCo9e4ZiEg+ltnpRtHARxJQkGOUB2JW+olHlnl6hb3u
	 k0QNpdyKK0kyU109LlLJ2S0jInfs0adLTHE4Z8BTQUt/95MPfGswbxLUTkWagn3BKB
	 VO+XccMSV8eCVZtoOVrECu3lmb2A69fPTFH54UTY3Vx2Rwkx3wUx+6Qg88a7bucJTs
	 xwwVjEqEspBN7LIwLlKRORwSbMAJ3ndSRe2w6+GN5haObFZ3opCt/e/g/Wz3sHQ+xq
	 DQ+/OROWUP///VJ9yGov9V/AnGuwZcwWt3Lobiha+8fcVFFqc/4K/8JJCcQTReem5l
	 2ytnTc3VdWeDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] perf: Supply task information to sched_task()
Date: Wed, 30 Sep 2026 07:14:08 -0400
Message-ID: <20260930111409.1206848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092954-reviving-drearily-7882@gregkh>
References: <2026092954-reviving-drearily-7882@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit d57e94f5b891925e4f2796266eba31edd5a01903 ]

To save/restore LBR call stack data in system-wide mode, the task_struct
information is required.

Extend the parameters of sched_task() to supply task_struct information.

When schedule in, the LBR call stack data for new task will be restored.
When schedule out, the LBR call stack data for old task will be saved.
Only need to pass the required task_struct information.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250314172700.438923-4-kan.liang@linux.intel.com

[Stable backport: keep the two-argument task_ctx_sched_out() interface.
Use list_for_each_entry_safe() in perf_pmu_sched_task(), as in upstream
59e63416f5153, so callbacks may remove their list entry and the follow-up
3d8d74100954 can apply its per-PMU scheduling checks.]

Stable-dep-of: 3d8d74100954 ("perf/core: Run sched_task() for PMUs with only CPU-wide events")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/core-book3s.c    |  8 ++++++--
 arch/s390/kernel/perf_pai_crypto.c |  3 ++-
 arch/s390/kernel/perf_pai_ext.c    |  3 ++-
 arch/x86/events/amd/brs.c          |  3 ++-
 arch/x86/events/amd/lbr.c          |  3 ++-
 arch/x86/events/core.c             |  5 +++--
 arch/x86/events/intel/core.c       |  4 ++--
 arch/x86/events/intel/lbr.c        |  3 ++-
 arch/x86/events/perf_event.h       | 14 +++++++++-----
 include/linux/perf_event.h         |  2 +-
 kernel/events/core.c               | 24 +++++++++++++-----------
 11 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 4bb84dc4393fc..fafb0343afd5e 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -132,7 +132,10 @@ static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
-static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in) {}
+static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+				 struct task_struct *task, bool sched_in)
+{
+}
 static inline void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
@@ -451,7 +454,8 @@ static void power_pmu_bhrb_disable(struct perf_event *event)
 /* Called from ctxsw to prevent one process's branch entries to
  * mingle with the other process's entries during context switch.
  */
-static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+				 struct task_struct *task, bool sched_in)
 {
 	if (!ppmu->bhrb_nr)
 		return;
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 044fba8332b22..b24ee5fbf9581 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -378,7 +378,8 @@ static int paicrypt_push_sample(void)
 /* Called on schedule-in and schedule-out. No access to event structure,
  * but for sampling only event CRYPTO_ALL is allowed.
  */
-static void paicrypt_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static void paicrypt_sched_task(struct perf_event_pmu_context *pmu_ctx,
+				struct task_struct *task, bool sched_in)
 {
 	/* We started with a clean page on event installation. So read out
 	 * results on schedule_out and if page was dirty, clear values.
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index 089bd3104b394..3b6f18675ab40 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -467,7 +467,8 @@ static int paiext_push_sample(void)
 /* Called on schedule-in and schedule-out. No access to event structure,
  * but for sampling only event NNPA_ALL is allowed.
  */
-static void paiext_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static void paiext_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			      struct task_struct *task, bool sched_in)
 {
 	/* We started with a clean page on event installation. So read out
 	 * results on schedule_out and if page was dirty, clear values.
diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 01fcd43522bca..d752242ecc0d7 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -381,7 +381,8 @@ static void amd_brs_poison_buffer(void)
  * On ctxswin, sched_in = true, called after the PMU has started
  * On ctxswout, sched_in = false, called before the PMU is stopped
  */
-void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 0788c11febf6a..0c1e7f0a613c7 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -376,7 +376,8 @@ void amd_pmu_lbr_del(struct perf_event *event)
 	perf_sched_cb_dec(event->pmu);
 }
 
-void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1519ab15a5449..497a1c20277f2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2626,9 +2626,10 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 	NULL,
 };
 
-static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			       struct task_struct *task, bool sched_in)
 {
-	static_call_cond(x86_pmu_sched_task)(pmu_ctx, sched_in);
+	static_call_cond(x86_pmu_sched_task)(pmu_ctx, task, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8d1ec1d888da7..72bb65071ad10 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4933,10 +4933,10 @@ static void intel_pmu_cpu_dead(int cpu)
 }
 
 static void intel_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
-				 bool sched_in)
+				 struct task_struct *task, bool sched_in)
 {
 	intel_pmu_pebs_sched_task(pmu_ctx, sched_in);
-	intel_pmu_lbr_sched_task(pmu_ctx, sched_in);
+	intel_pmu_lbr_sched_task(pmu_ctx, task, sched_in);
 }
 
 static void intel_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 3e904ba942784..dc4e0804b9008 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -538,7 +538,8 @@ void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 	     task_context_opt(next_ctx_data)->lbr_callstack_users);
 }
 
-void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			      struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	void *task_ctx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4ca15be45cb80..f33ae9529c871 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -816,7 +816,7 @@ struct x86_pmu {
 
 	void		(*check_microcode)(void);
 	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx,
-				      bool sched_in);
+				      struct task_struct *task, bool sched_in);
 
 	/*
 	 * Intel Arch Perfmon v2+
@@ -1310,7 +1310,8 @@ void amd_pmu_lbr_reset(void);
 void amd_pmu_lbr_read(void);
 void amd_pmu_lbr_add(struct perf_event *event);
 void amd_pmu_lbr_del(struct perf_event *event);
-void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in);
 void amd_pmu_lbr_enable_all(void);
 void amd_pmu_lbr_disable_all(void);
 int amd_pmu_lbr_hw_config(struct perf_event *event);
@@ -1351,7 +1352,8 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 	perf_sched_cb_dec(event->pmu);
 }
 
-void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in);
 #else
 static inline int amd_brs_init(void)
 {
@@ -1376,7 +1378,8 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 {
 }
 
-static inline void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static inline void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx,
+					  struct task_struct *task, bool sched_in)
 {
 }
 
@@ -1558,7 +1561,8 @@ void intel_ds_init(void);
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 				 struct perf_event_pmu_context *next_epc);
 
-void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			      struct task_struct *task, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 90c782749b055..76a4b7fa6e39d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -453,7 +453,7 @@ struct pmu {
 	 * context-switches callback
 	 */
 	void (*sched_task)		(struct perf_event_pmu_context *pmu_ctx,
-					bool sched_in);
+					 struct task_struct *task, bool sched_in);
 
 	/*
 	 * Kmem cache of PMU specific data
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95743e6c5b0cb..efc70c89be44d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3524,7 +3524,8 @@ static void perf_event_swap_task_ctx_data(struct perf_event_context *prev_ctx,
 	}
 }
 
-static void perf_ctx_sched_task_cb(struct perf_event_context *ctx, bool sched_in)
+static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
+				   struct task_struct *task, bool sched_in)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 	struct perf_cpu_pmu_context *cpc;
@@ -3533,7 +3534,7 @@ static void perf_ctx_sched_task_cb(struct perf_event_context *ctx, bool sched_in
 		cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
 
 		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
-			pmu_ctx->pmu->sched_task(pmu_ctx, sched_in);
+			pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in);
 	}
 }
 
@@ -3591,7 +3592,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);
 
-			perf_ctx_sched_task_cb(ctx, false);
+			perf_ctx_sched_task_cb(ctx, task, false);
 			perf_event_swap_task_ctx_data(ctx, next_ctx);
 
 			perf_ctx_enable(ctx, false);
@@ -3621,7 +3622,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 		perf_ctx_disable(ctx, false);
 
 inside_switch:
-		perf_ctx_sched_task_cb(ctx, false);
+		perf_ctx_sched_task_cb(ctx, task, false);
 		task_ctx_sched_out(ctx, EVENT_ALL);
 
 		perf_ctx_enable(ctx, false);
@@ -3663,7 +3664,8 @@ void perf_sched_cb_inc(struct pmu *pmu)
  * PEBS requires this to provide PID/TID information. This requires we flush
  * all queued PEBS records before we context switch to a new task.
  */
-static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc, bool sched_in)
+static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc,
+				  struct task_struct *task, bool sched_in)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct pmu *pmu;
@@ -3677,7 +3679,7 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc, bool sched_i
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
 
-	pmu->sched_task(cpc->task_epc, sched_in);
+	pmu->sched_task(cpc->task_epc, task, sched_in);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -3688,14 +3690,14 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 				bool sched_in)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
-	struct perf_cpu_pmu_context *cpc;
+	struct perf_cpu_pmu_context *cpc, *cpc2;
 
 	/* cpuctx->task_ctx will be handled in perf_event_context_sched_in/out */
 	if (prev == next || cpuctx->task_ctx)
 		return;
 
-	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
-		__perf_pmu_sched_task(cpc, sched_in);
+	list_for_each_entry_safe(cpc, cpc2, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
+		__perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
 }
 
 static void perf_event_switch(struct task_struct *task,
@@ -3999,7 +4001,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 		perf_ctx_lock(cpuctx, ctx);
 		perf_ctx_disable(ctx, false);
 
-		perf_ctx_sched_task_cb(ctx, true);
+		perf_ctx_sched_task_cb(ctx, task, true);
 
 		perf_ctx_enable(ctx, false);
 		perf_ctx_unlock(cpuctx, ctx);
@@ -4030,7 +4032,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 
 	perf_event_sched_in(cpuctx, ctx);
 
-	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
+	perf_ctx_sched_task_cb(cpuctx->task_ctx, task, true);
 
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
 		perf_ctx_enable(&cpuctx->ctx, false);
-- 
2.53.0


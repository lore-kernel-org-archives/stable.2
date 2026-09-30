Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E93ED3CF
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766854; cv=none; b=hpSbgViRY6qtCEtVEx/zLWwkdJs0oH++SI4ewcCzYyf9LRgp9OXsNKqPDiytK/trPJrpR9uCZ0JN7BgpfKwl3kc0j4Trip+gcMYoqTgWTpkk7dwtIcAumGbaGWkho0nGAJzK11RjWlPvFl4+qxhuEDeTbI3AMOyMa+0t9G+0cdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766854; c=relaxed/simple;
	bh=cv56E07WE3YiaOz2rh2wbJTp4Ur4A9/z5+8RDWus7v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYOqSNKOqY/XJ4V7KfjkbLcKm8U1JEaf/FyHcc9BopU3GQGHM9fjt3XcnCTvzOtVJNHuqmEGAAWSAK5amPUOlMdxOOThnWp4PUPbelX8H6S3Dp21k2XS3xRH6t8xxVb33qDBTAN0FHLEgBZWQ3E3qzR4AfH2sCMXAGxdzQnngzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeVyv0qO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeVyv0qO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423941F00898;
	Wed, 30 Sep 2026 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766852;
	bh=6s8s+/BbZTVS0jad5uX6NRMBYG8EQxTqaJzGi/lZQaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JeVyv0qOENdSlfRyzo9gtphJvedxv4dsTw53yAQmrm8EqY32njWY+EUR5IC5hvrGX
	 mLL4jjE5E62fzOXBf4zawO4uAQtndu/pBJjW4BeqHfFTKuH5EWeVC4esJi8A7H/YqE
	 gYBelVzmOnVHbwiNTVyv8zybyFUdUmp1xLMSJpcxte1GLWnWOH23ovxEUGte5rJMJl
	 trw9Z41AfHDKB6h8CloPDqCW0WHwbUze7/jjTnQMESQxW6DO7Nhkr5pwDQlOYlIk+v
	 pr2Oam5e6HMNfwwea7w7Zz32vzY6wfwHoVhr8BnbE+pd/9sC3Kqt+xIPu0NL2eVQQ5
	 hJ1Q2w13oyFBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Yifan Wu <wuyifan50@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] perf/core: Run sched_task() for PMUs with only CPU-wide events
Date: Wed, 30 Sep 2026 07:14:09 -0400
Message-ID: <20260930111409.1206848-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111409.1206848-1-sashal@kernel.org>
References: <2026092954-reviving-drearily-7882@gregkh>
 <20260930111409.1206848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

[ Upstream commit 3d8d74100954a3b17e5c5e37adfe14e16b1db103 ]

perf_pmu_sched_task() returns early when cpuctx->task_ctx is set and
leaves the work to perf_ctx_sched_task_cb(), which only walks
ctx->pmu_ctx_list. A PMU whose events are all CPU-wide is not on that
list, so nothing calls its sched_task(). With

  perf record -b -e cycles -a -- ls

armv8pmu_sched_task() is skipped on every switch to a task that has a
perf context but no event on that PMU, and BRBE records leak across the
task boundary. intel_pmu_lbr_add() calls perf_sched_cb_inc()
unconditionally too, so LBR records leak the same way on x86.

Drop the early return and skip only the CPCs that
perf_ctx_sched_task_cb() handles. That one needs a gate of its own to
make the split exact: it tests cpc->sched_cb_usage, which
perf_sched_cb_inc() sets per CPU for every branch stack user, so a task
with an event for that PMU pinned to another CPU would be handled twice.
On x86 the second __intel_pmu_lbr_restore() finds lbr_stack_state ==
LBR_NONE and calls intel_pmu_lbr_reset(), throwing away the callstack
the first one restored.

cpc->task_epc is set only while a task context is scheduled in, and
there is one epc per PMU on ctx->pmu_ctx_list, so the two gates are
inverses.

For the CPCs perf_pmu_sched_task() picks up, the callback now runs
outside the perf_ctx_disable() and perf_ctx_enable() pair in
perf_event_context_sched_in(). __perf_pmu_sched_task() disables the PMU
around the call itself.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yifan Wu <wuyifan50@huawei.com>
Link: https://patch.msgid.link/20260810133540.1947118-3-puranjay@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index efc70c89be44d..cce39de6a90e9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3533,6 +3533,9 @@ static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
 		cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
 
+		if (cpc->task_epc != pmu_ctx)
+			continue;
+
 		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
 			pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in);
 	}
@@ -3689,15 +3692,17 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 				struct task_struct *next,
 				bool sched_in)
 {
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_cpu_pmu_context *cpc, *cpc2;
 
-	/* cpuctx->task_ctx will be handled in perf_event_context_sched_in/out */
-	if (prev == next || cpuctx->task_ctx)
+	if (prev == next)
 		return;
 
-	list_for_each_entry_safe(cpc, cpc2, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
+	list_for_each_entry_safe(cpc, cpc2, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
+		if (cpc->task_epc)
+			continue;
+
 		__perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
+	}
 }
 
 static void perf_event_switch(struct task_struct *task,
-- 
2.53.0


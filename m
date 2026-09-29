Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234B35CB81
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681702; cv=none; b=A3/8zklME1/13xgdQK5dZENBlo7G5HpzKXO2ZiI+cBmBM4lGmVVZQZVa2B5rqOMxP90xfVldE0TqNljh5UvGqm6zs7Gc/CyJDk6Uqvoyp3YLWDonf/6BHGFjLQulD7ZdbfTHUq8oRMj/7GYpP92BQltRYBMvuPRjG+AWYoqB55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681702; c=relaxed/simple;
	bh=0H2L1gwuILqTh2uc9EtwctIWCZjszHOnZWYOX7v4C8s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ru1UMBZW9Mqni1k51X/K9f5qVPlSKlefrUqMLpOGG++EwYchs2hUdWljyCX0MSPdfZJVR0vmpngvbW635tVOgkiIxMXXd+DEP16ei6z1bCxLl9OUigfDnzG/5RI9cDJanmRgJ4Zk9k6etvNHrhRjgyiaVcpCSP8ze4IB1RIBEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B3sMwBwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B3sMwBwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BC21F000FF;
	Tue, 29 Sep 2026 11:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681700;
	bh=2Q4x3NlwxV+uA6oOk6zpeT/BP/wjWXpzwLUMGekkt6g=;
	h=Subject:To:Cc:From:Date;
	b=B3sMwBwHu0DWiZHM3yHeD2Az986M0m5U1uvrK+E0lgry65I2kZbaak1gCrZoOfcF+
	 SyreE3u/byJymJLzUQsNuz8kfm4o1E5/hE/SwgKod1uAVoYefaD0L3w3g7EFSrX2ro
	 +jg/MFJz4YW8j6uqZfQkYixMkrp7qfxv6BgP4G1c=
Subject: FAILED: patch "[PATCH] perf/core: Run sched_task() for PMUs with only CPU-wide" failed to apply to 6.6-stable tree
To: puranjay@kernel.org,peterz@infradead.org,wuyifan50@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:34:54 +0200
Message-ID: <2026092954-reviving-drearily-7882@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3d8d74100954a3b17e5c5e37adfe14e16b1db103
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092954-reviving-drearily-7882@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d8d74100954a3b17e5c5e37adfe14e16b1db103 Mon Sep 17 00:00:00 2001
From: Puranjay Mohan <puranjay@kernel.org>
Date: Mon, 10 Aug 2026 06:35:35 -0700
Subject: [PATCH] perf/core: Run sched_task() for PMUs with only CPU-wide
 events

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

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7ce72f366f6c..634d2ccbab82 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3764,6 +3764,9 @@ static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
 		cpc = this_cpc(pmu_ctx->pmu);
 
+		if (cpc->task_epc != pmu_ctx)
+			continue;
+
 		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
 			pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in);
 	}
@@ -3924,15 +3927,17 @@ static void perf_pmu_sched_task(struct task_struct *prev,
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A8476CC2
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312000; cv=none; b=dVaqBuyieUQlP3bYNGvaqXFSx0cNVGHsCfVgK09Sg85UrU8TFKeEJnhdCThpAtbTbTWqQVEPlebtSPFGhEDqFd2Tcn4HdRjX9Sk3qLZXIyR57M9eQDgAdvZlq1ZaCmOdNmyyqttUDH2w06kupLdFRs38wnqC+AbCFN4GvU96D18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312000; c=relaxed/simple;
	bh=uCxX8BiJhFB8KrFuLOQFBxg1mqDhmsa4d4r0WwAEKRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGTyQIL33UcG/fHjsLuhYLb9qkT9yvIwgNGDHUmxTW/JmqawXu9nhTyfmCixbjGETsVE8PkX68tLzH5P8p46TNQ1H0LnR9UkHM8zg+Uo3kn7l7sDKGpro/uF7IVs+mW3Ms7KQGwebgbVnQxexuchfoF/Y9HStE2q1lW/fTZeLuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzvfQAr3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzvfQAr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2331F000E9;
	Fri, 21 Aug 2026 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787311999;
	bh=VMrq2SlHZtxEcxVljZxIA649mXS8WevMzr7Em+GcyLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mzvfQAr3BsPlcvZQh03uKQgoGe1Rn2ULSy+GB+zwckslkoAxLBe9q6Q4S/xVP6jbX
	 rf5pILOOGfCs63bYLGPKU9RDxdSust+sTtsqxbk5Ja073jGQt0/Muhdipzl1MG/T9L
	 Bq7+ws16JtcQE7hLsxSnADbSjGY4h2qkzs2q3h3gTEYBbHePrYHdXFhsEEjoiU4hc3
	 QCHYRfRSpInHmEuxwBkBxKeVzxyVWcywwqQS3OB9CDbTBe8OGbqzE8yCpyoa96IqYE
	 xRiz0fXeBrXamwrGGySV0U1M0+77XqVb41i3gSTJkS9Ct10hP79YCkqP1JB7EII/AV
	 dPEhWg/QOUUKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] perf/core: Fix group leader use-after-free after sibling detach
Date: Fri, 21 Aug 2026 07:33:09 -0400
Message-ID: <20260821113309.2981106-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821113309.2981106-1-sashal@kernel.org>
References: <2026081732-unmixed-crudely-500c@gregkh>
 <20260821113309.2981106-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Chillara <aditya.chillara@oss.qualcomm.com>

[ Upstream commit 42c5ca1f0a288a52878bd72a5595b08261057438 ]

perf_group_detach() handles leader and sibling detach differently. When the
group leader is detached, all siblings are promoted to singleton events and
their group_leader pointer is reset to themselves. When a sibling is
detached, it is removed from the leader's sibling_list, but its
group_leader pointer is left pointing at the old leader.

That is harmless when the sibling is being closed and freed immediately, as
in the DETACH_DEAD path. It is not safe when the sibling is detached but
kept alive, such as during CPU hotplug with DETACH_GROUP. In that case the
sibling is removed from the context, while its file descriptor can still
keep it alive.

A typical failing sequence is:

  - A group contains leader L and sibling S.
  - CPU hot-unplug detaches S with DETACH_GROUP, removing it from
    L->sibling_list but leaving S->group_leader == L.
  - L is later closed and freed.
  - A PERF_IOC_FLAG_GROUP ioctl on S follows S->group_leader and
    dereferences the freed leader.

This was reproduced by running the perf event fuzzer, CPU hotplug, and a
stress workload concurrently:

  Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cdb
  CPU: 2 PID: 12489 Comm: perf_fuzzer 6.18.7 PREEMPT
  pc : perf_ioctl+0x34c/0xc68
  x20: ffffff89a3fa2c70 x8 : 6b6b6b6b6b6b6b6b
  Code: 943c4a0e 340047a0 f9404a94 f9411e88 (f940b908)
  Call trace:
  perf_ioctl+0x34c/0xc68 (P)
  __arm64_sys_ioctl+0xa0/0xf4
  invoke_syscall+0x58/0xe4
  el0_svc_common+0xa8/0xdc
  do_el0_svc+0x1c/0x28
  el0_svc+0x40/0xc0
  el0t_64_sync_handler+0x68/0xdc
  el0t_64_sync+0x1c4/0x1c8

The fault happened in perf_ioctl(), where perf_event_for_each() follows
the stale group_leader pointer and perf_event_for_each_child() then
dereferences the freed leader's context.

Fix the use-after-free by promoting the detached sibling to a singleton.
Also fix __event_disable() cgroup accounting and event state change.

Fixes: 8a49542c0554 ("perf_events: Fix races in group composition")
Assisted-by: PatchWise:gpt-5.5
Signed-off-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260807-fix-group-leader-uaf-v3-1-b0c2310c9a0d@oss.qualcomm.com
[ Adjusted context for 5.10's older APIs, keeping `event_sched_out()`'s 3-arg form and dropping the DETACH_EXIT/REVOKE/DEAD handling that doesn't exist there. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 67 ++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5e4d1b090db70..68df0d569f4c2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2222,6 +2222,34 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 	return event->attr.pinned ? &ctx->pinned_active : &ctx->flexible_active;
 }
 
+/* @sibling must already be unlinked from its old leader's sibling_list. */
+static void perf_promote_sibling_to_leader(struct perf_event *sibling,
+					   struct perf_event_context *ctx,
+					   int group_caps)
+{
+	/*
+	 * Events that have PERF_EV_CAP_SIBLING require being part of
+	 * a group and cannot exist on their own, schedule them out
+	 * and move them into the ERROR state. Also see
+	 * _perf_event_enable(), it will not be able to recover this
+	 * ERROR state.
+	 */
+	if (sibling->event_caps & PERF_EV_CAP_SIBLING)
+		__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
+
+	sibling->group_leader = sibling;
+	sibling->group_caps = group_caps;
+
+	if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
+		add_event_to_groups(sibling, ctx);
+
+		if (sibling->state == PERF_EVENT_STATE_ACTIVE)
+			list_add_tail(&sibling->active_list, get_event_list(sibling));
+	}
+
+	perf_event__header_size(sibling);
+}
+
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *leader = event->group_leader;
@@ -2245,8 +2273,9 @@ static void perf_group_detach(struct perf_event *event)
 	 */
 	if (leader != event) {
 		list_del_init(&event->sibling_list);
-		event->group_leader->nr_siblings--;
-		event->group_leader->group_generation++;
+		leader->nr_siblings--;
+		leader->group_generation++;
+		perf_promote_sibling_to_leader(event, ctx, event->event_caps);
 		goto out;
 	}
 
@@ -2256,32 +2285,14 @@ static void perf_group_detach(struct perf_event *event)
 	 * to whatever list we are on.
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
-
-		/*
-		 * Events that have PERF_EV_CAP_SIBLING require being part of
-		 * a group and cannot exist on their own, schedule them out
-		 * and move them into the ERROR state. Also see
-		 * _perf_event_enable(), it will not be able to recover this
-		 * ERROR state.
-		 */
-		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
-			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
-
-		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
 
 		/* Inherit group flags from the previous leader */
-		sibling->group_caps = event->group_caps;
-
-		if (!RB_EMPTY_NODE(&event->group_node)) {
-			add_event_to_groups(sibling, event->ctx);
-
-			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
-				list_add_tail(&sibling->active_list, get_event_list(sibling));
-		}
+		perf_promote_sibling_to_leader(sibling, ctx, event->group_caps);
 
 		WARN_ON_ONCE(sibling->ctx != event->ctx);
 	}
+	event->nr_siblings = 0;
 
 out:
 	for_each_sibling_event(tmp, leader)
@@ -2418,12 +2429,7 @@ __perf_remove_from_context(struct perf_event *event,
 		update_cgrp_time_from_cpuctx(cpuctx, false);
 	}
 
-	event_sched_out(event, cpuctx, ctx);
-
-	if (event->state > PERF_EVENT_STATE_OFF)
-		perf_cgroup_event_disable(event, ctx);
-
-	perf_event_set_state(event, min(event->state, state));
+	__event_disable(event, ctx, state);
 
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
@@ -2484,8 +2490,9 @@ static void __event_disable(struct perf_event *event,
 			    enum perf_event_state state)
 {
 	event_sched_out(event, __get_cpu_context(ctx), ctx);
-	perf_cgroup_event_disable(event, ctx);
-	perf_event_set_state(event, state);
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
 }
 
 /*
-- 
2.53.0


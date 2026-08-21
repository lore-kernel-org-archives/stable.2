Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE930BF70
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 04:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286223; cv=none; b=aNxp1qv8udsuGDcvpbKcQp9U+Yxc95Vae2Z3C2S7F83O3ad8vl5l/IPhyyGyMwoGX+myhOxwUqJcRAMdoR4T9XF44gpI1Z3Hfhzc7pT6G9bw7Mz2QAcRwXvnPHLHrsrHicSGe43aQFkVSL+ckv81DY9VyDrGvhJACmBAZBiHMbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286223; c=relaxed/simple;
	bh=Hejnxfzvz5SmixTKhbp+d+UOkQq1Yc2PPtY+wGgC23o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI5LLvjGR3VjXSWrOF0AHSnILmtVsGwFHNAR8tHDkY29atnlNZ+b7TDLapYgtOIyt/53YNxuoUKFNXE6eaIN63KK0pna2VPjHkVMiG6w6yGcye+SJulDIDn/acPmVDgGdTOJSIDmC36vjjIBMm2SyyTdEagjomM1lGPqfTfXDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbFbmx1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbFbmx1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0481F00A3E;
	Fri, 21 Aug 2026 04:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787286222;
	bh=VK9Or+KxAsUzP/bfvANFI102aav+vkLMyGy6sSbWfPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TbFbmx1n5jYKhr1krsdt2DZNUXJkaCONU3KX1PD/PmZaCOhCLxUoX+hhhl1w1J3uu
	 19GhItevKWEG+BdUo0XJ7pBnVlqXvuD1ExQC8GBa0iUKmgrYq57P9B7W7ZTvgsoD1T
	 tdoXeNv4nKPz7uPxFj51+Iq8ZZ4khpv7bji3fTMvo18hitZCBQny4BY4wXjhVVjyqg
	 iZpd3SAY6VDCGKwgnmRXCdiIzlfSG2ah/RAUt3aZNzF3QrfK9432l72iPnokDqflLA
	 mKlRksig3b3kex9qtWVzhXzjXLyDqSLk2nyjR6S/M9l3DNO8Xrv7pw9hJkn6lVgMCq
	 Loe9dF0Sg7uCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Leo Yan <leo.yan@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] perf: Fix cgroup state vs ERROR
Date: Fri, 21 Aug 2026 00:23:37 -0400
Message-ID: <20260821042339.2534361-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821042339.2534361-1-sashal@kernel.org>
References: <2026081731-publisher-ship-c8bd@gregkh>
 <20260821042339.2534361-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 61988e36dc5457cdff7ae7927e8d9ad1419ee998 ]

While chasing down a missing perf_cgroup_event_disable() elsewhere,
Leo Yan found that both perf_put_aux_event() and
perf_remove_sibling_event() were also missing one.

Specifically, the rule is that events that switch to OFF,ERROR need to
call perf_cgroup_event_disable().

Unify the disable paths to ensure this.

Fixes: ab43762ef010 ("perf: Allow normal events to output AUX data")
Fixes: 9f0c4fa111dc ("perf/core: Add a new PERF_EV_CAP_SIBLING event capability")
Reported-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250605123343.GD35970@noisy.programming.kicks-ass.net
Stable-dep-of: 42c5ca1f0a28 ("perf/core: Fix group leader use-after-free after sibling detach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 56 ++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4557bd86e0edb..c8a34a19a47fc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2138,14 +2138,13 @@ perf_aux_output_match(struct perf_event *event, struct perf_event *aux_event)
 }
 
 static void put_event(struct perf_event *event);
-static void event_sched_out(struct perf_event *event,
-			    struct perf_cpu_context *cpuctx,
-			    struct perf_event_context *ctx);
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state);
 
 static void perf_put_aux_event(struct perf_event *event)
 {
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 	struct perf_event *iter;
 
 	/*
@@ -2174,8 +2173,7 @@ static void perf_put_aux_event(struct perf_event *event)
 		 * state so that we don't try to schedule it again. Note
 		 * that perf_event_enable() will clear the ERROR status.
 		 */
-		event_sched_out(iter, cpuctx, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		__event_disable(iter, ctx, PERF_EVENT_STATE_ERROR);
 	}
 }
 
@@ -2229,21 +2227,6 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 	return event->attr.pinned ? &ctx->pinned_active : &ctx->flexible_active;
 }
 
-/*
- * Events that have PERF_EV_CAP_SIBLING require being part of a group and
- * cannot exist on their own, schedule them out and move them into the ERROR
- * state. Also see _perf_event_enable(), it will not be able to recover
- * this ERROR state.
- */
-static inline void perf_remove_sibling_event(struct perf_event *event)
-{
-	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
-
-	event_sched_out(event, cpuctx, ctx);
-	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
-}
-
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *leader = event->group_leader;
@@ -2279,8 +2262,15 @@ static void perf_group_detach(struct perf_event *event)
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
 
+		/*
+		 * Events that have PERF_EV_CAP_SIBLING require being part of
+		 * a group and cannot exist on their own, schedule them out
+		 * and move them into the ERROR state. Also see
+		 * _perf_event_enable(), it will not be able to recover this
+		 * ERROR state.
+		 */
 		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
-			perf_remove_sibling_event(sibling);
+			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
 
 		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
@@ -2536,6 +2526,15 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	event_function_call(event, __perf_remove_from_context, (void *)flags);
 }
 
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state)
+{
+	event_sched_out(event, __get_cpu_context(ctx), ctx);
+	perf_cgroup_event_disable(event, ctx);
+	perf_event_set_state(event, state);
+}
+
 /*
  * Cross CPU call to disable a performance event
  */
@@ -2552,13 +2551,18 @@ static void __perf_event_disable(struct perf_event *event,
 		update_cgrp_time_from_event(event);
 	}
 
+	/*
+	 * When disabling a group leader, the whole group becomes ineligible
+	 * to run, so schedule out the full group.
+	 */
 	if (event == event->group_leader)
 		group_sched_out(event, cpuctx, ctx);
-	else
-		event_sched_out(event, cpuctx, ctx);
 
-	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	perf_cgroup_event_disable(event, ctx);
+	/*
+	 * But only mark the leader OFF; the siblings will remain
+	 * INACTIVE.
+	 */
+	__event_disable(event, ctx, PERF_EVENT_STATE_OFF);
 }
 
 /*
-- 
2.53.0


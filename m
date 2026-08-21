Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86606352C5B
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284784; cv=none; b=ABfqnnJXxxgo3yqXxwAxqn9JMFIT6DUfRfl7IWQL88p3XncU1jgC6INlsnDhcem5EauCHFqh8aUGSkt+wbOAeOwKnlv6cuiu5ulEDJuW1ScoCmk0YX4XqgqNPyoNGVE+Nkmv4u7/dTkavXFZ0YmJ28cxB5y3ANrkEdG4oEu1Ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284784; c=relaxed/simple;
	bh=zTXssUs2YKtwlDXlLUpOTsRYdjz/3J7F56UVpj8LE8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uppquU+VA3aGQM5EPJAgbcRoI0AhJy1Adpp05OaqczhtzAAYKYOn9kYJHkoO+TKTcHiGNgpUjfXkwecsiiNTG8ARnPVvfB34d1IAJlw28j/L8LXod6fTEuQgsfvlaO4ZjzwdFGwRx9VGEa+3QxQ50I5x45PdYr8v02yfoCWzMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYrUwyv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYrUwyv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E21F000E9;
	Fri, 21 Aug 2026 03:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787284783;
	bh=oX/r23M7NQhdkvI9ay4PlUxNt7bLf1nkJvArR2L305c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fYrUwyv46R8t2Hph3c28K3HO8fUL8Xq8WponBZySWAZSiaUIneL/e4DznPwGN3Thy
	 +0iFz4R6SQy2jV5jyHKBKfbmFUblPF4V0KcC+CmC7m+oir0tRkDiZ/MU+tz9S25kKT
	 41r73X6uy6fXc7RaCUTr/QewJzXPEikqvq9qvHB3Di4DMPW7Ftben6fFJ1GJ4FKLn0
	 NZ5upGzbHEBLLe7AbaEMUF8u1iaYUKxiU7mxLJYR0CIn+BDR2HxWZJU2xRTJCRga8e
	 gM7VFkAqpOlC2gWUc/sMnMU4dpl+NAB0GS4hSRxx55jFogzcrbe8XK7eiLUj/SFCEU
	 V7MTm4uqpiyOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Leo Yan <leo.yan@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] perf/core: Fix child_total_time_enabled accounting bug at task exit
Date: Thu, 20 Aug 2026 23:59:37 -0400
Message-ID: <20260821035940.2526518-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081730-distance-sherry-000f@gregkh>
References: <2026081730-distance-sherry-000f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yeoreum Yun <yeoreum.yun@arm.com>

[ Upstream commit a3c3c66670cee11eb13aa43905904bf29cb92d32 ]

The perf events code fails to account for total_time_enabled of
inactive events.

Here is a failure case for accounting total_time_enabled for
CPU PMU events:

  sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
  ...

  armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
  armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
                             `          `          `
                             `          `          > total_time_running with child
                             `          > total_time_enabled with child
                             > count with child

  Performance counter stats for 'stress-ng --pthread=2 -t 2s':

       1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
       1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)

The two events above are opened on two different CPU PMUs, for example,
each event is opened for a cluster in an Arm big.LITTLE system, they
will never run on the same CPU.  In theory, the total enabled time should
be same for both events, as two events are opened and closed together.

As the result show, the two events' total enabled time including
child event is different (2289429840 vs 1950025700).

This is because child events are not accounted properly
if a event is INACTIVE state when the task exits:

  perf_event_exit_event()
   `> perf_remove_from_context()
     `> __perf_remove_from_context()
       `> perf_child_detach()   -> Accumulate child_total_time_enabled
         `> list_del_event()    -> Update child event's time

The problem is the time accumulation happens prior to child event's
time updating. Thus, it misses to account the last period's time when
the event exits.

The perf core layer follows the rule that timekeeping is tied to state
change. To address the issue, make __perf_remove_from_context()
handle the task exit case by passing 'DETACH_EXIT' to it and
invoke perf_event_state() for state alongside with accounting the time.

Then, perf_child_detach() populates the time into the parent's time metrics.

After this patch, the bug is fixed:

  sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 10s
  ...
  armv8_pmuv3_0/event=0x08/: 15396770398 32157963940 21898169000
  armv8_pmuv3_1/event=0x08/: 22428964974 32157963940 10259794940

   Performance counter stats for 'stress-ng --pthread=2 -t 10s':

      15,396,770,398      armv8_pmuv3_0/event=0x08/                                               (68.10%)
      22,428,964,974      armv8_pmuv3_1/event=0x08/                                               (31.90%)

[ mingo: Clarified the changelog. ]

Fixes: ef54c1a476aef ("perf: Rework perf_event_exit_event()")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Link: https://lore.kernel.org/r/20250326082003.1630986-1-yeoreum.yun@arm.com
Stable-dep-of: 42c5ca1f0a28 ("perf/core: Fix group leader use-after-free after sibling detach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 146b37e97832a..79a40c287f6b8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2373,6 +2373,7 @@ group_sched_out(struct perf_event *group_event,
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
 #define DETACH_DEAD	0x04UL
+#define DETACH_EXIT	0x08UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2386,6 +2387,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   struct perf_event_context *ctx,
 			   void *info)
 {
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 	unsigned long flags = (unsigned long)info;
 
 	if (ctx->is_active & EVENT_TIME) {
@@ -2397,16 +2399,19 @@ __perf_remove_from_context(struct perf_event *event,
 	 * Ensure event_sched_out() switches to OFF, at the very least
 	 * this avoids raising perf_pending_task() at this time.
 	 */
-	if (flags & DETACH_DEAD)
+	if (flags & DETACH_EXIT)
+		state = PERF_EVENT_STATE_EXIT;
+	if (flags & DETACH_DEAD) {
 		event->pending_disable = 1;
+		state = PERF_EVENT_STATE_DEAD;
+	}
 	event_sched_out(event, cpuctx, ctx);
+	perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
-	if (flags & DETACH_DEAD)
-		event->state = PERF_EVENT_STATE_DEAD;
 
 	if (!ctx->nr_events && ctx->is_active) {
 		if (ctx == &cpuctx->ctx)
@@ -13077,12 +13082,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		mutex_lock(&parent_event->child_mutex);
 	}
 
-	perf_remove_from_context(event, detach_flags);
-
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state > PERF_EVENT_STATE_EXIT)
-		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_remove_from_context(event, detach_flags | DETACH_EXIT);
 
 	/*
 	 * Child events can be freed.
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210029E0E5
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 04:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286223; cv=none; b=QoLNOLmDMP00yZLmYGr2wAHWDFyI1rT+BuSkZCZQ+YW0lWws+BF+Q/aWalsniGYl+ovzHlsYXxCVUtGrF4e5bisvHxpTIc6KXJ8oN188gOvpco8Cf/j+PO6mmMO/GZilU4QAUiZly+Kxqnn0OU8Tthbn3Hlfq/X1xGzxZSGcdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286223; c=relaxed/simple;
	bh=AjReH63Wp7hU0HenNbUkBd1986hNkzxrbEAQSxSutCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpnPSJwnCPIdP5iRWwyym6MJ/jNfaiCVNUCohezffrBatCfhcuJz2AK+RHcJI8zeOBVaISsBMt6uVGUKq1ma8O7fer5E6npal7goM00nfUhzX7+9tP1eSDb4rInWrT431by28D5dwpwy6F/ZQmZLtGnBaT9d3kYZPkeypE1RKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNZvbrsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNZvbrsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07161F000E9;
	Fri, 21 Aug 2026 04:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787286221;
	bh=AJ7QvM5NyJFnKvZrU/+wmlL6G/FIT8QbSfwqGziZxQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNZvbrsvnqZeYe0gqaNWVTgqjR5serP8DjwA9OTLokQeYTf0j64+hWEk/ZoStUORA
	 3ADE8nV4nEFW0aSXB9XgH08JzWZHAg34HdSQvVSlp6QVnil7V+q6TdsE0CdrZjRXmQ
	 yGw6YDH2DhwVBDytoa9dtTYZMu/sSveupC51m/avJ+ctZiC+ixIsm5+tcwSzw4t+A8
	 y+lOF3LpSc7oZ9mvQtZlxSf3OvEKDqXApPQxZnnKuWPsc0T/evuHi81EklcpaFrbP1
	 gjKMqythYtZCqnK7p1LPplXiE1y6BxKa3/oluvBk5iQF0+tWjRdA8JRa6AktOztqGc
	 HNC55em2eus3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Leo Yan <leo.yan@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] perf/core: Fix child_total_time_enabled accounting bug at task exit
Date: Fri, 21 Aug 2026 00:23:36 -0400
Message-ID: <20260821042339.2534361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081731-publisher-ship-c8bd@gregkh>
References: <2026081731-publisher-ship-c8bd@gregkh>
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
index 156221bd56615..4557bd86e0edb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2446,6 +2446,7 @@ group_sched_out(struct perf_event *group_event,
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
 #define DETACH_DEAD	0x04UL
+#define DETACH_EXIT	0x08UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2459,6 +2460,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   struct perf_event_context *ctx,
 			   void *info)
 {
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 	unsigned long flags = (unsigned long)info;
 
 	if (ctx->is_active & EVENT_TIME) {
@@ -2470,16 +2472,19 @@ __perf_remove_from_context(struct perf_event *event,
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
@@ -13046,12 +13051,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
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


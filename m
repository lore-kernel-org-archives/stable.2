Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598724;
	b=yu33vB9i4/E0Teq2HViOeMBp+C5OEcxG55p/ztuxvwTgHPSWZ1yP18KAzxzlbeieQTUM
	 vBkiOFm09m5nUItClGvM1sdISD+66wqh36nF6DHsUkzT1sm5whR03wuDJ0dw8elGYtUAt
	 pUrqxEk0yqD/+KRpQ5VIfwpTrzq+6jP3d5/LLIT/dU/dq6MgNc+mKiOMI4zSWEETLGzNB
	 JCzSiHG0dmt2lona3WOU6PQLoPgNchP6/WeXwBwv36bvTVytC+bVuNlTxR4O7AkgqQpXt
	 Q3L7agSi8PXOsxoijOfCqwqBlIzqZNJDD6Jo+xp66tUh+LsNnoDo4TQRvhsCgkVBjHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598724;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9Ay3GJfTk4phxpGWgZD41MWDVUq8z4qsOD/3xcMjI+c=;
	b=u1qtEs73FNeyvbDZFi+h5V42We9lKbbEYkREOqDGtXJCuOM/mzI/X1ja6hFGiXgrHCki
	 9+OqP3mAjjLjMiTjOQRwa9C213JaZWV0pBbVVaDTGXlzq6iee8nMUeSKyCtOiwuPbY9Mh
	 ZqmJZ7koA5HmryPXvpKSgFHZHVywvtBwKL0DHANeUPBak7XU5/A2G+14xi6jT7MFXRYPA
	 Cz8Fdzg/LxTg2ZMd9iSGo2hXdXtSE18HLdwe9TJBrF4IKTUY1v6FM8VRIIc+7l65nQBF+
	 DyMhifGZsv+y0CbNZUCIS93BvukeQDa0tHnhyRt9E6YwJT9fOKCWd0aLw5zM3UFvcMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QtR0Wble;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153D606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QtR0Wble
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FED1F000D3;
	Wed, 25 Nov 2026 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598723;
	bh=9Ay3GJfTk4phxpGWgZD41MWDVUq8z4qsOD/3xcMjI+c=;
	h=Subject:To:Cc:From:Date;
	b=QtR0Wble5vUm4r3S4UCOp6+45hH5yjCe7Gh2xFbSmwfgNPLzjpT6SL4KuvgPVD6uL
	 eJ/7kc/Mg/8qkfjA6ZCFLUoRF2n7bIn7SPzq6CcvratvrvA7dtNg3UJEbH/X7v8gr8
	 KdGz+NCtZbpgtHBdtsF1oR8w4kjnjiFbmiWpwKys=
Subject: FAILED: patch "[PATCH] perf/core: Do not resurrect cpuctx->cgrp after last cgroup" failed to apply to 6.1-stable tree
To: phatdt1116@gmail.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:16:33 +0100
Message-ID: <2026112533-alkaline-hate-c122@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 59f1398140869432c7171b9a2a279ca315467c4e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112533-alkaline-hate-c122@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59f1398140869432c7171b9a2a279ca315467c4e Mon Sep 17 00:00:00 2001
From: Phat Dinh <phatdt1116@gmail.com>
Date: Fri, 6 Nov 2026 17:16:42 +0700
Subject: [PATCH] perf/core: Do not resurrect cpuctx->cgrp after last cgroup
 event exit

perf_cgroup_switch() relies on:

    /*
     * cpuctx->cgrp is set when the first cgroup event enabled,
     * and is cleared when the last cgroup event disabled.
     */

It computes the next task's cgroup, schedules out the CPU context and
then assigns cpuctx->cgrp unconditionally:

    ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
    /*
     * must not be done before ctxswout due
     * to update_cgrp_time_from_cpuctx() in
     * ctx_sched_out()
     */
    cpuctx->cgrp = cgrp;

However, ctx_sched_out() can disable events itself. If a cgroup event
has a pending disable from perf_event_disable_inatomic() (e.g. its
PERF_EVENT_IOC_REFRESH limit ran out) that the irq_work has not
handled yet, event_sched_out() consumes it inline:

    if (event->pending_disable) {
        event->pending_disable = 0;
        perf_cgroup_event_disable(event, ctx);
        state = PERF_EVENT_STATE_OFF;
    }

If that was the last cgroup event, perf_cgroup_event_disable() clears
cpuctx->cgrp:

    if (--ctx->nr_cgroups)
        return;

    cpuctx->cgrp = NULL;

and perf_cgroup_switch() then sets it again. cpuctx->cgrp is left
non-NULL with ctx.nr_cgroups == 0, so the NULL check in
perf_cgroup_switch() no longer catches it and the next switch trips:

    WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);

cpuctx->cgrp does not hold a reference on the cgroup. Once that cgroup
is removed, the next ctx_sched_in() dereferences the stale pointer:

  BUG: KASAN: slab-use-after-free in ctx_sched_in+0xb1f/0xfa0
  Read of size 8 at addr ffff8881008972d0 by task swapper/3/0

  Tainted: [W]=WARN
  Call Trace:
   <IRQ>
   ctx_sched_in+0xb1f/0xfa0
   perf_event_sched_in+0x1a/0x70
   ctx_resched+0x32b/0xac0
   __perf_install_in_context+0x475/0xab0
   remote_function+0x105/0x200
   __flush_smp_call_function_queue+0x179/0x8d0
   __sysvec_call_function_single+0x1b/0x1c0
   sysvec_call_function_single+0x66/0x80
   </IRQ>
   <TASK>
   asm_sysvec_call_function_single+0x1a/0x20

Only assign cpuctx->cgrp when cgroup events remain after the context
has been scheduled out, so that it stays NULL as the invariant
requires.

Fixes: e19cd0b6fa59 ("perf/core: Always set cpuctx cgrp when enable cgroup event")
Signed-off-by: Phat Dinh <phatdt1116@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261106101642.494674-1-phatdt1116@gmail.com

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1404dabec2ce..e870f12c3ad8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1072,8 +1072,13 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 * must not be done before ctxswout due
 	 * to update_cgrp_time_from_cpuctx() in
 	 * ctx_sched_out()
+	 *
+	 * ctx_sched_out() can consume a pending disable and drop the last cgroup
+	 * event, which clear the cpuctx->cgrp. Cgroup tracking follow active cgroup
+	 * event, so do not resurrect it
 	 */
-	cpuctx->cgrp = cgrp;
+	if (cpuctx->ctx.nr_cgroups)
+		cpuctx->cgrp = cgrp;
 	/*
 	 * set cgrp before ctxsw in to allow
 	 * perf_cgroup_set_timestamp() in ctx_sched_in()


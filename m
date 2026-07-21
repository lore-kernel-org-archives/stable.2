Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAD2F4A0C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625462; cv=none; b=n0+7XfOzQGayX6SuA//A+qD57wiwYuTNvOdLdffN6PcenXk5Ogko2NxfozLKvZsaMH6E1oGhfhvGiglVjKf6X8VGcrFLxvni7l8VlxNecEu43az58v7VLscUyDc64Ckns/SfCGt/Lnsa3o+u36BGmwgiqxJIWGJqif//QjZExko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625462; c=relaxed/simple;
	bh=sLR0n2t310wETun8CoNMTKf6LTPgQZ7xCR8cu17ba/I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VMYN+pB9xbFkynZlPKbetAwSYKoLUmmBY7oZ28kYuKmA+Um2mYMt9AhB+ebRIg+HUUN4cWb1z0ctVB/rF0feTS8yznJew9iCnRtOd9UOc71zliCeU8ziU8l9dAblelE7inGRrRjaerNy5n/z48kJI12PNs09wfPHlyTkL+XKlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XfoUSzEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XfoUSzEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27511F000E9;
	Tue, 21 Jul 2026 09:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625461;
	bh=9WXu9O6sdc5Vie3o8jgTe5evoXqhbcs33PQvVvAhndk=;
	h=Subject:To:Cc:From:Date;
	b=XfoUSzEBrSTES+HZQZ5yPh+rL9g6pvJB9Uwm/NWY0YKA6iu5Xc3v4Mksej+jQkScO
	 tHqwTeUBjUVT9785qdf84cn1aOQfJhBo+2BdhGoYysh4SOwW9VEHFtf7vLVpZoSPNE
	 5YwCG8PRUoC0L5Bd5MGp4+mCqVanwXAat0XcqioM=
Subject: FAILED: patch "[PATCH] sched_ext: Skip ops.set_weight() for disabled tasks" failed to apply to 7.1-stable tree
To: jpiecuch@google.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:17:31 +0200
Message-ID: <2026072131-citation-reshape-587c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0e2f4ab68a89fad42e0f5a9ff4b740738e7aa1d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072131-citation-reshape-587c@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e2f4ab68a89fad42e0f5a9ff4b740738e7aa1d6 Mon Sep 17 00:00:00 2001
From: Kuba Piecuch <jpiecuch@google.com>
Date: Fri, 10 Jul 2026 14:43:41 +0000
Subject: [PATCH] sched_ext: Skip ops.set_weight() for disabled tasks

When switching a task's sched_class away from sched_ext, we get the
following sequence of events in __sched_setscheduler():

sched_change_begin()
  switched_from_scx()
    scx_disable_task(p)
      ops.disable(p)
__setscheduler_params()
  set_load_weight()
    reweight_task_scx(p)
      ops.set_weight(p)
p->sched_class = next_class;
sched_change_end()
  ...

Notably, ops.set_weight() is called _after_ ops.disable().
This violates the expected semantics of the callbacks, the expectation
being that ops.disable() can only be followed by ops.exit_task() or
ops.enable().

Skipping the weight adjustment for disabled tasks should be harmless
since the weight will be recalculated in scx_enable_task() if the task
ever rejoins SCX.

Fixes: 637b0682821b ("sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index aeee44e016ab..e3fa7b2fac9d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3967,6 +3967,17 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 	if (task_dead_and_done(p))
 		return;
 
+	/*
+	 * When switching sched_class away from SCX, reweight_task_scx()
+	 * is called _after_ scx_disable_task(). Skip calling ops.set_weight()
+	 * since the BPF scheduler may have already forgotten the task in
+	 * ops.disable().
+	 * p->scx.weight will be recalculated in scx_enable_task() if the task
+	 * ever returns to SCX class.
+	 */
+	if (scx_get_task_state(p) != SCX_TASK_ENABLED)
+		return;
+
 	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
 	if (SCX_HAS_OP(sch, set_weight))
 		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);


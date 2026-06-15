Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A67081F
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495705; cv=none; b=LO9amfzoYz0/ghMrtCd0xUBAEnD37pkGX315CqAQ3sIMI/7QjRjGOhPrgFBbOjd/sXGw/v4Nh0rDEhRtFeC2Vppy78PSRPJQO8YIySFIfiaqeBvNUGYG6wkwRq6MujGbxMuWyul5MkwYLdZtVL0FvlBe5kpcidMt2T8V1O7o3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495705; c=relaxed/simple;
	bh=5YZv2YE557TPIESh2QJVcIzAvbJPJ1CIChvC7v/o6Og=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LkhyGieK+Tp58DeSKce04Toa4c7LQ8Kd+UC3e7tSGMyF+hFObL+6KOjsdLD2tMjOy/GlAfuk4ObbVywpaS7t70lc8Rp26rHEGYvTBxR7aat4jjybMam4SOr5blFzqrADkaBzINzav8gK1CivLDMCmhhRLJisUeWKjsa4E+zKq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qbO7RO+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qbO7RO+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754E61F000E9;
	Mon, 15 Jun 2026 03:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781495704;
	bh=OMp73XIc4mp418FM0l9Gbvn0Sbre3oaOkxJrHN8o/nk=;
	h=Subject:To:Cc:From:Date;
	b=qbO7RO+nw0cby4xV5cEAPwEgZvKErQZSpeVO4nkLdXYzEzmpT6ypLxHw/xOcCKETv
	 n0muDlyFCniv9YKvPO7Wvbc39Wr0PohTSD90YOObHAJYWKZQwiUGplGUIFA86HGvX7
	 tUn+HMaruTBwq57lC6SyJFc9buyU4CAvO1pFTz6M=
Subject: FAILED: patch "[PATCH] sched_ext: Don't warn on NULL cgrp_moving_from in" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com,mfleming@cloudflare.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 05:53:53 +0200
Message-ID: <2026061553-elderly-speech-3446@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 02e545c4297a26dbbc41df81b831e7f605bcd306
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061553-elderly-speech-3446@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 02e545c4297a26dbbc41df81b831e7f605bcd306 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 1 Jun 2026 09:22:37 -1000
Subject: [PATCH] sched_ext: Don't warn on NULL cgrp_moving_from in
 scx_cgroup_move_task()

A WARN fires when systemd's user manager writes "+cpu +memory +pids" to
its own subtree_control while a sched_ext scheduler is loaded:

  WARNING: at kernel/sched/ext.c:3227 scx_cgroup_move_task+0xa8/0xb0
   scx_cgroup_move_task+0xa8/0xb0
   sched_move_task+0x134/0x290
   cpu_cgroup_attach+0x39/0x70
   cgroup_migrate_execute+0x37d/0x450
   cgroup_update_dfl_csses+0x1e3/0x270
   cgroup_subtree_control_write+0x3e7/0x440

scx_cgroup_can_attach() arms cgrp_moving_from only when a task's cpu
cgroup changes. It can still be NULL when scx_cgroup_move_task() runs,
through this sequence:

  Step                               Result
  ---------------------------------  ----------------------------------
  1. cpu enabled on cgroup G         cpu css = A
  2. cpu toggled off then on for G   A killed, B created (same cgroup)
  3. an exiting task keeps A alive   migration skips it, A now stale
  4. +memory migrates G              stale A vs current B pulls cpu in
  5. cpu attach runs for all tasks   hits a live, cpu-unchanged task
  6. scx_cgroup_move_task() on it    cgrp_moving_from NULL -> WARN

The mismatch is that scx_cgroup_can_attach() keys on cgroup identity
while migration drives the move on css identity, so a NULL cgrp_moving_from
here is a legitimate css-only migration, not a missing prep.

The call is already gated on cgrp_moving_from, so just drop the warning.
ops.cgroup_prep_move() and ops.cgroup_move() stay paired.

Fixes: 819513666966 ("sched_ext: Add cgroup support")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Matt Fleming <mfleming@cloudflare.com>
Closes: https://lore.kernel.org/all/20260601124156.2205704-1-mfleming@cloudflare.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c1762420cc35..8e88a25bc602 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4402,11 +4402,13 @@ void scx_cgroup_move_task(struct task_struct *p)
 		return;
 
 	/*
-	 * @p must have ops.cgroup_prep_move() called on it and thus
-	 * cgrp_moving_from set.
+	 * scx_cgroup_can_attach() sets cgrp_moving_from only when the task's
+	 * cgroup changes. Migration keys off css rather than cgroup identity,
+	 * so it can hand an unchanged-cgroup task here with cgrp_moving_from
+	 * NULL. Nothing to report to the BPF scheduler then, so skip it and
+	 * keep prep_move and move paired.
 	 */
-	if (SCX_HAS_OP(sch, cgroup_move) &&
-	    !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
+	if (SCX_HAS_OP(sch, cgroup_move) && p->scx.cgrp_moving_from)
 		SCX_CALL_OP_TASK(sch, cgroup_move, task_rq(p),
 				 p, p->scx.cgrp_moving_from,
 				 tg_cgrp(task_group(p)));


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED440B6F7
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545053; cv=none; b=my7IpfjHfegyqq5goYfB306Do7ssdgLRUIASlfwiRpx4CPNwcI+dqtXXOM717atpIVTc2pVX1S+ZAr6Xsx1EATYFq3VJqAo4DyT/BezUbSdNRT0uKW450VjB9MEIlGaqUJMyALhcPbAbqJy1OJUPupIOsTtEbdgDyMafDLOddMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545053; c=relaxed/simple;
	bh=eP6q3hwPfT3HQ/gvF9VatfO0+FK6j56f5qsO9MengX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCsinJSIOdWJjdqnxotcluJPBFI7fPFNarhGhmf1gRR7e+ffXRtzjzRGIcpSJ62U9FoIkA5zfaykFVBwk9hvax/fcdQ97gVAqpiSHeacmeaxXK1p0TVVSBgL64TGIiU/bLG/fb2UJBOiN1U7nvw8jDQxYwPcbX0pD1Bidat8YD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMMG2lkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMMG2lkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF761F000E9;
	Mon, 15 Jun 2026 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781545052;
	bh=qA4oVRewk8RCJL2zdx8WrPRY6MHpavtSOrpH8WN4R2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aMMG2lkWZ6wgYkQUm1qsDRLh63SoQTnDGFcJ4RL9dvelWXC8Is4Uzc64ubm8sd2HC
	 +6DiGSW6I46NvcNHWrXnE1JcyqZZi7hHEXvuNV+poDjvqKALhub68Xr74lbk2hdyB8
	 QhysGkgXU4cmgX0+75jMjEvQ5XWk4OgaupU4f4foM0bpOAlRfuYYa2V9wcJh0HFDML
	 RABjB8u8A/pqLIQMCjcL2sbuXoFyVQa/zjFm7+R0QCe8jCX6B57M1I1605U3T5j7CV
	 9Ia4yc5ZKRwssBEVJMIx24+nZyPAOMA6eWL8SV8TJtyYIk5eCK1FWBs1Oe/+BWKbK8
	 /BbS6MipraSdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Matt Fleming <mfleming@cloudflare.com>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()
Date: Mon, 15 Jun 2026 13:37:30 -0400
Message-ID: <20260615173730.2303601-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061554-brink-cesarean-5dc5@gregkh>
References: <2026061554-brink-cesarean-5dc5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 02e545c4297a26dbbc41df81b831e7f605bcd306 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 01dc2a613868fc..428cde37130dfc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4069,10 +4069,13 @@ void scx_cgroup_move_task(struct task_struct *p)
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
-	if (SCX_HAS_OP(cgroup_move) && !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
+	if (SCX_HAS_OP(cgroup_move) && p->scx.cgrp_moving_from)
 		SCX_CALL_OP_TASK(SCX_KF_UNLOCKED, cgroup_move, p,
 			p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
 	p->scx.cgrp_moving_from = NULL;
-- 
2.53.0


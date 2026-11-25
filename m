Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603039;
	b=oIqnT4nsIdej03803SQArBJTVDgPHg5UnEM3seqT39+mlrQDZO8PC8CmFxO3CXEopPi3
	 Dm6MDGosqRDVypADSM6buhjlMWSgEEPw50Drv1m9NFI/tnxCV4mAAeJzvH+Q18iiyxqLC
	 7nNPSADUlzw1gwSgg0j0yVt0xX2Q8WoFy02KsdPo7dZ0LI6WeYkThOJfo/Xbvlv2VjkI+
	 akPCXpE00XnEJx29S54n+cdvhZ+oaWTgaxmqz/cDBau6bEdv/Kg6385h6OrHGN+SuD6/o
	 scZ5wdTw4Bp9gTYV6LvEqnpwFxf86ny8pd5XOhqo0kA6MoLTe29Wg6gLLWLGriUYPPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603039;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cP1dEORtE2GzRdBy2lEtJb+/hBSsPrA5+HK/6T/9J+I=;
	b=g2fK7S+pk+M/CJ5ZYwS/+npfOtsx70O+wTM0RKgLC3fcZDRbVbbwIos+VXtfITCmAdPG
	 eBQsS2E8ZnBHv8/Auc3eY9Drf4mTRTCaiGyCx6NVq4SBY6xeA1PSfmpKllkEizM0MCwWp
	 0IOJ/jNi63aJFcct3GRm2274dTu+es3uk4wnF3AWtk33xjFpdTk2SAchrbAhpEoBTiIVH
	 E4WMB21yULPXGra8/1C8erKoNUI7Yln0VqDEE0qm5ZnIPvVxaPodGqLK6raNMyLoXIIvI
	 oh7uMfDdc+yjP+iASyHzdCkpRQgaTPQ7+UU7xda6snY/vLwKgoh2jBWfif9hNbGN6Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lGeSTLl7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBD606A331
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lGeSTLl7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43C41F000C0;
	Wed, 25 Nov 2026 10:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603039;
	bh=cP1dEORtE2GzRdBy2lEtJb+/hBSsPrA5+HK/6T/9J+I=;
	h=Subject:To:Cc:From:Date;
	b=lGeSTLl7DHZH+2r0/fCDXdNO79rNgslpV8b9Vn0yV1Ck8Qnm8UJR/EPLECCAF1Jmm
	 8e2c9XsX1onO033H4qw5hvLOZISyevG54Aq5S25Jk0RlHXcnCCffwsnjaaoXg2EVks
	 EuU9I8/E2VNQqq1WUfcAy1uuRGt4zdb8O52xbgos=
Subject: FAILED: patch "[PATCH] sched_ext: Read exit_kind before flushing in" failed to apply to 6.18-stable tree
To: jpiecuch@google.com,arighi@nvidia.com,sashiko-bot@kernel.org,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:22:35 +0100
Message-ID: <2026112535-handcraft-glance-0edb@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3133107d98057595c0af39ff907c852134926912
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112535-handcraft-glance-0edb@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3133107d98057595c0af39ff907c852134926912 Mon Sep 17 00:00:00 2001
From: Kuba Piecuch <jpiecuch@google.com>
Date: Wed, 4 Nov 2026 11:14:39 +0000
Subject: [PATCH] sched_ext: Read exit_kind before flushing in
 scx_flush_disable_work()

scx_disable_workfn() sets exit_kind to SCX_EXIT_DONE before it tears the
scheduler down. scx_flush_disable_work() reads exit_kind after syncing
disable_irq_work and flushing disable_work, so it can observe DONE from
a disable_work that was queued after its flush and return while the
teardown is still running:

  CPU A                          CPU B
  -----                          -----
  scx_vexit()
    scx_claim_exit() -> true
                                 bpf_struct_ops_map_link_detach()
                                   bpf_scx_unreg()
                                     scx_disable()
                                       scx_claim_exit() -> false
                                     scx_flush_disable_work()
                                       irq_work_sync()      // not queued
                                       kthread_flush_work() // not queued
    irq_work_queue()
  scx_disable_irq_workfn()
    kthread_queue_work()
  scx_disable_workfn()
    exit_kind = SCX_EXIT_DONE
    scx_root_disable()
                                       atomic_read() -> SCX_EXIT_DONE
                                   bpf_map_put()

Once bpf_scx_unreg() returns, its caller drops the struct_ops map
reference, and the struct_ops trampolines can be freed while
scx_root_disable() is still running and can still call into the BPF
scheduler, e.g. ops.exit().

Read exit_kind before syncing and flushing, with acquire ordering paired
with the atomic_try_cmpxchg() in scx_disable_workfn(). DONE is only set
from disable_work, so once it is observed, the following
kthread_flush_work() sees the queued work and waits for the teardown to
finish.

This patch was created with the help of an AI coding assistant.

Fixes: d99f7a32f09d ("sched_ext: Fix scx_flush_disable_work() UAF race")
Cc: stable@vger.kernel.org # v7.1+
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-195908@kernel.org/
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 6c593d3dee3c..949143bf4752 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7810,10 +7810,17 @@ void scx_flush_disable_work(struct scx_sched *sch)
 {
 	int kind;
 
+	/*
+	 * scx_disable_workfn() sets SCX_EXIT_DONE before tearing down. Read
+	 * exit_kind with acquire ordering (paired with atomic_try_cmpxchg() in
+	 * scx_disable_workfn()) before syncing and flushing so that, once DONE
+	 * is seen, the following flush observes the queued work and waits for
+	 * the teardown to finish.
+	 */
 	do {
+		kind = atomic_read_acquire(&sch->exit_kind);
 		irq_work_sync(&sch->disable_irq_work);
 		kthread_flush_work(&sch->disable_work);
-		kind = atomic_read(&sch->exit_kind);
 	} while (kind != SCX_EXIT_NONE && kind != SCX_EXIT_DONE);
 }
 


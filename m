Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17493C3BFA;
	Wed, 30 Sep 2026 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763551; cv=none; b=ihgOjJFTgQ7G7aynkJW2GEN4oUu8b8hM4GA89C8zxS39TwoEUGStcFdVuBWq/eEeVjUCOxNRbWYM0s4Nje9FbE5hZTY5IXX/oOMFAlJ8soD4uuG9vzfwbyADxrrX5R2ptvAtf6t+uSHxtqGIE/6VsthzXrnGmOlwac7YeWIuHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763551; c=relaxed/simple;
	bh=lv8cEJJhIRBGmZ/58YZwoAIipFgHhAhXSXEuCSLmEjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVi1MBSnhFn7j9lJKt45S4DUT2e6jj/5s4z11d8ymAzm9v+vColPDVcOmeXrhfrzZYFNxpAKYJ7gKyGggSRM+Vz2dcE5PUIy+qWaZXnN9zNEtWYtMsJgbPaeLNV1em+Y8Dv1zl9wLVY90Ie/T0vrrpG4h8va/ohbp8ICP1MNxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eFFD2Cte; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eFFD2Cte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=w0
	mNDi2wBxp1xFtPYsu1Ehyp75igmnL6MJTjYfrzswg=; b=eFFD2CteANhDDBFW76
	An4lJY29aLmNBdPEOVOQeLP4TmLOrE9Sx2NWU37XdPZPXHVuMAqK5w+9jX2Z0aya
	xAPGbo/FQuce3SQP8eafKMEn5Gl6mW1Gh5M20QOUFfFnVg89BSS/+XUxngefXU28
	rNWpbfNaMuCXOT0cDJMN89Txw=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3f7my4bxqx3XrBg--.5926S2;
	Wed, 30 Sep 2026 18:17:23 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] sched_ext: Hold DSQ refs for deferred reenqueues
Date: Wed, 30 Sep 2026 19:17:22 +0900
Message-ID: <20260930101722.2468434-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f7my4bxqx3XrBg--.5926S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1DtrW7KF1xZw4fur4fuFg_yoWrGr13pF
	WkXF1UA3yxJry0qr4vvw4xZF1fXrs5uw4xCry8Wr1akan8uwn2q392vF1agFZ8WrZYkw4x
	Jr1qka12ka90qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi7GYPUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRNuzWq84bN0IgAA3j

A deferred user-DSQ node can be detached by
process_deferred_reenq_users() before the DSQ RCU callback reaches
exit_dsq(). Once detached, exit_dsq() can no longer find the node,
while the deferred path still uses the raw DSQ pointer after dropping
deferred_reenq_lock. The callback can therefore free the DSQ before
the deferred path checks its ID or calls reenq_user().

An RCU grace period only delays reclamation past pre-existing RCU
read-side critical sections. It doesn't protect a deferred reenqueue
which has detached its node and keeps using the raw DSQ pointer
afterwards.

Take a reference under deferred_reenq_lock before detaching the node.
The RCU callback drops the base reference after exit_dsq(), and the
deferred path drops its reference after its final DSQ access. This
keeps the object alive until all detached reenqueues finish while
preserving invalidated-DSQ behavior.

A KASAN regression test of the pre-fix kernel reported the
use-after-free while processing the deferred reenqueue:

    BUG: KASAN: slab-use-after-free in run_deferred+0x1312/0x1710
    Read of size 8 at addr ffff8880087009b0 by task swapper/3/0
    Call Trace:
     <IRQ>
     run_deferred+0x1312/0x1710
     ttwu_do_activate+0x29a/0x600
     try_to_wake_up+0x815/0x1700

The patched kernel completed the same regression test without a KASAN
report.

Fixes: 84b1a0ea0b7c ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Hui Su <sh_def@163.com>

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 23f9e178bc5a..1d36196b2238 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -13,6 +13,7 @@
 
 #include <linux/llist.h>
 #include <linux/rhashtable-types.h>
+#include <linux/refcount.h>
 
 enum scx_public_consts {
 	SCX_OPS_NAME_LEN	= 128,
@@ -92,6 +93,8 @@ struct scx_dispatch_q {
 	struct llist_node	free_node;
 	struct scx_sched	*sched;
 	struct scx_dsq_pcpu __percpu *pcpu_user;
+	/* one base ref held until deferred reclamation, plus detached workers */
+	refcount_t		deferred_reenq_refs;
 	struct rcu_head		rcu;
 };
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 405d0d1038f8..9fd18fa5725b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5057,6 +5057,7 @@ static void process_deferred_reenq_users(struct rq *rq)
 			dsq_pcpu = container_of(dru, struct scx_dsq_pcpu,
 						deferred_reenq_user);
 			dsq = dsq_pcpu->dsq;
+			refcount_inc(&dsq->deferred_reenq_refs);
 			reenq_flags = dru->flags;
 			WRITE_ONCE(dru->flags, 0);
 			list_del_init(&dru->node);
@@ -5068,10 +5069,14 @@ static void process_deferred_reenq_users(struct rq *rq)
 		/* destroy_dsq() may have raced and invalidated @dsq, nothing to reenq */
 		dsq_id = READ_ONCE(dsq->id);
 		if (unlikely(dsq_id == SCX_DSQ_INVALID))
-			continue;
+			goto put_dsq;
 
 		BUG_ON(dsq_id & SCX_DSQ_FLAG_BUILTIN);
 		reenq_user(rq, dsq, reenq_flags);
+
+put_dsq:
+		if (refcount_dec_and_test(&dsq->deferred_reenq_refs))
+			kfree(dsq);
 	}
 }
 
@@ -5565,6 +5570,7 @@ s32 scx_init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id, struct scx_sched *sch)
 	if (dsq_id & SCX_DSQ_FLAG_BUILTIN)
 		return 0;
 
+	refcount_set(&dsq->deferred_reenq_refs, 1);
 	dsq->pcpu_user = alloc_percpu(struct scx_dsq_pcpu);
 	if (!dsq->pcpu_user)
 		return -ENOMEM;
@@ -5609,7 +5615,8 @@ static void free_dsq_rcufn(struct rcu_head *rcu)
 	struct scx_dispatch_q *dsq = container_of(rcu, struct scx_dispatch_q, rcu);
 
 	exit_dsq(dsq);
-	kfree(dsq);
+	if (refcount_dec_and_test(&dsq->deferred_reenq_refs))
+		kfree(dsq);
 }
 
 static void free_dsq_irq_workfn(struct irq_work *irq_work)


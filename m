Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE7B1C3F0C;
	Thu,  8 Oct 2026 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791427780; cv=none; b=ZNpmQUvxJwb0rsdYxhS12Ww09Xk9mBH6HkDMU0SJw1C2lngkgHsnmh46UP5uv3ycmYLq3fipTSVS1Itwc1sjJFvtYn/ik2ofp1XMJ7Z3yesPcWfOP73EqYQgKk+fDGiTEuIKYD8UGkmCfv6f9Drh951EQ5ioovn5U+SgMUFgdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791427780; c=relaxed/simple;
	bh=OKrmHgSPMHb2julbeoAI4VAzYmtWl/JEjrfi9IxqV+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6yzxDETBBZ4jRDb4SOm1RtfWsGiDc0l0J04beo0nMe6AAxLoUJT4ZrflE0qgbfepxNMJ0iZ/kEaHsG2livwgR0X4ibV29wOtAZLDGP2EH/l0+Y+/3RsGEXz08PsKmEVHufLMsITYab6k/Ifj+DloCIGG+hnFovCwbJrja4B9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WTLwa6Bp; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WTLwa6Bp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=br
	RJxqNT6EqFF7Z/m/5gnDQF3Ws+MJW+LSRnBiwaYeI=; b=WTLwa6BpUjSr+XT6Tg
	iyn6QsrQowx7h3dGNjBfRZsIYSkV51QkVUGtzkQHgFWQAZwgZvzj2LKWmqRZOQmU
	Uev7TmvH2FaiWL9e6HJXdwxQzsjYFYJWdlYFsGULSwsuuLi3QyvgdBo5lIIpgUX/
	v/cfKDo0yAbwHTZzhswt1e1bs=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnz61eBMdq74OuDQ--.5313S2;
	Thu, 08 Oct 2026 10:47:59 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: sched-ext@lists.linux.dev,
	tj@kernel.org
Cc: void@manifault.com,
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
	yphbchou0911@gmail.com,
	etsal@meta.com,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] sched_ext: Serialize user DSQ destruction against deferred reenqueues
Date: Thu,  8 Oct 2026 11:47:53 +0900
Message-ID: <20261008024753.4096008-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnz61eBMdq74OuDQ--.5313S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4UAr4kZw1fXF4xGF1fCrg_yoWrWw1UpF
	W0qry5Cw45tw42gr4ayw4xAF1fXws3uF43WryfGr4Skwn8uws2vFWIvF17uFs0qrs3Cwnx
	tFnxK3WDKr4DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi7GYPUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwh+kBGrHBF8OEgAA3X

A deferred user-DSQ node can be detached by
process_deferred_reenq_users() before the DSQ RCU callback reaches
exit_dsq(). Once detached, exit_dsq() cannot find the node, while the
deferred path continues using the raw DSQ pointer after dropping
deferred_reenq_lock. The callback can free the DSQ before the deferred
path checks its ID or calls reenq_user().

The first RCU grace period drains producers that found @dsq, but does not
cover a consumer that detached its request and continues using @dsq.

Avoid adding reference counting to the deferred reenqueue hot path.
Instead, synchronize the rare destruction path with outstanding users.
After the initial grace period, take every rq lock with its deferred lock.
This unlinks requests not yet detached and closes the detach-to-cursor
window for active consumers. reenq_user() leaves its iteration cursor on
@dsq->list until its final access. Since destroy_dsq() requires @dsq->nr
to be zero, a non-empty list after the sweep indicates an outstanding
cursor; defer reclamation through another RCU callback until it exits.

A test-only pre-fix fixture invoked free_dsq_rcufn() after detaching a
request and before its final DSQ access. KASAN reported the resulting
use-after-free:

    BUG: KASAN: slab-use-after-free in run_deferred+0x1312/0x1710
    Read of size 8 at addr ffff8880087009b0 by task swapper/3/0
    Call Trace:
     <IRQ>
     run_deferred+0x1312/0x1710
     ttwu_do_activate+0x29a/0x600
     try_to_wake_up+0x815/0x1700

Fixes: 84b1a0ea0b7c ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
Tested on x86_64 KVM:
- The pre-fix fixture reproduced the UAF under KASAN; the v3 cursor/reclamation
  case completed without a report.
- CONFIG_PROVE_LOCKING=y and CONFIG_LOCKDEP=y completed the same test without
  lockdep warnings.

Changes in v3:
- Drop the refcount approach per Tejun and move synchronization to rare DSQ
  destruction.
- Sweep rq/deferred locks and defer reclamation while a reenq_user() cursor
  remains active.
- v2 was accidentally posted without the version tag.

v2 (posted without version tag):
https://lore.kernel.org/lkml/20260930143443.2862150-1-sh_def@163.com/
---
 kernel/sched/ext/ext.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 405d0d1038f8..293e5e223277 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5579,6 +5579,35 @@ s32 scx_init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id, struct scx_sched *sch)
 	return 0;
 }
 
+/*
+ * Synchronize DSQ destruction against deferred reenqueues.
+ *
+ * Taking each rq lock with its deferred lock removes requests not yet
+ * detached and closes the detach-to-cursor window. A reenq_user() cursor
+ * stays linked on @dsq->list until its final DSQ access.
+ */
+static bool drain_dsq_reenq_users(struct scx_dispatch_q *dsq)
+{
+	s32 cpu;
+
+	/* The first RCU grace period has drained producers which found @dsq. */
+	for_each_possible_cpu(cpu) {
+		struct scx_dsq_pcpu *pcpu = per_cpu_ptr(dsq->pcpu_user, cpu);
+		struct scx_deferred_reenq_user *dru = &pcpu->deferred_reenq_user;
+		struct rq *rq = cpu_rq(cpu);
+
+		scoped_guard (rq_lock_irqsave, rq) {
+			guard(raw_spinlock)(&rq->scx.deferred_reenq_lock);
+
+			if (!list_empty(&dru->node))
+				list_del_init(&dru->node);
+		}
+	}
+
+	guard(raw_spinlock_irqsave)(&dsq->lock);
+	return list_empty(&dsq->list);
+}
+
 static void exit_dsq(struct scx_dispatch_q *dsq)
 {
 	s32 cpu;
@@ -5608,6 +5637,12 @@ static void free_dsq_rcufn(struct rcu_head *rcu)
 {
 	struct scx_dispatch_q *dsq = container_of(rcu, struct scx_dispatch_q, rcu);
 
+	/* An active reenq_user() cursor still references @dsq. */
+	if (!drain_dsq_reenq_users(dsq)) {
+		call_rcu(&dsq->rcu, free_dsq_rcufn);
+		return;
+	}
+
 	exit_dsq(dsq);
 	kfree(dsq);
 }

base-commit: f2f095c87603b8dfb6752e130d902970371c3852


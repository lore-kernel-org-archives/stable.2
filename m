Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCA1427A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195474; cv=none; b=A15DYl4YHLb3IYQ9yqw0M1XHM3/9DSgd5ZceOYyRMAtukUviQ6S8JvvPMfGaE4tjUnnrdPMWCRUhud86w3j/wH2lDT2EiH0UZ8oDDuHT2GPN7DiT0IYLp8HOGqcq9YubNhKhBoyGoQ/+GhyP/JvaW9Isx+o+3xJyHpyLyna5m7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195474; c=relaxed/simple;
	bh=FmxOGE6xvaKsn69JZ+rxUMDrtz6vbJg9/DSfDXM1Sjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKm4KyXyVK/ahPCioX6kirbcSHraNcXFhKynPJ0hp+LKpUYe5Vlw1GSJANryCmE+LGqlHutOPNI1HsXDCeuptW8pi2JmcT8Xgf7941576J5ML0i0PkFOuVFhScohNW4Jer+l5WCN0Gm9tBvEg6p04PMLkOGJnXHH7lSvyIyoH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRffAyr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRffAyr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F56D1F00A3D;
	Mon, 27 Jul 2026 23:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195473;
	bh=Ite15heUthxSH3IT+sQMNbnKfTl5iNEBRMnp87mzKTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MRffAyr7vuBn01BKXSEQHb3w1LV0sVaed4ILteTJp1d4fQu7RFEMUQ4/BJy5eqJUg
	 VmMRoCNquTssrIgVkbfyl2LUlCBvO3WNRKxWQr2Ol3XgkbR6iZHGhvJSd2knQlhqsR
	 dg0jPZEUZSRFAtw5lxoq85YXHTgmWB/t2O/45ARuK24jd+HkWZm0Om0aWr6+Fkgq44
	 rr/g4BeJEWKruWrwkm2f3ULmlJ6LMrlxg7wk5I+anT59X1mWohzXjpy3Vp5WQra9kX
	 Pd/H3y5jRhvmEDf4CK+xMpKIKcgmAUlFlo2oA1yahum2CvqYgc7kuCHVmFTy+MT63/
	 K+s0FWhvPf0gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] workqueue: Add system_percpu_wq and system_dfl_wq
Date: Mon, 27 Jul 2026 19:37:49 -0400
Message-ID: <20260727233750.2439387-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727233750.2439387-1-sashal@kernel.org>
References: <2026072054-anywhere-moodiness-9087@gregkh>
 <20260727233750.2439387-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Crivellari <marco.crivellari@suse.com>

[ Upstream commit 128ea9f6ccfb6960293ae4212f4f97165e42222d ]

Currently, if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make it
clear by adding a system_percpu_wq.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 50fd6dd755c6 ("tracing/user_events: Fix use-after-free in user_event_mm_dup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/workqueue.h |  8 +++++---
 kernel/workqueue.c        | 14 ++++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 52c6dd6d80ac09..c4df93bee09c7f 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -410,7 +410,7 @@ enum {
 /*
  * System-wide workqueues which are always present.
  *
- * system_wq is the one used by schedule[_delayed]_work[_on]().
+ * system_percpu_wq is the one used by schedule[_delayed]_work[_on]().
  * Multi-CPU multi-threaded.  There are users which expect relatively
  * short queue flush time.  Don't queue works which can run for too
  * long.
@@ -421,7 +421,7 @@ enum {
  * system_long_wq is similar to system_wq but may host long running
  * works.  Queue flushing might take relatively long.
  *
- * system_unbound_wq is unbound workqueue.  Workers are not bound to
+ * system_dfl_wq is unbound workqueue.  Workers are not bound to
  * any specific CPU, not concurrency managed, and all queued works are
  * executed immediately as long as max_active limit is not reached and
  * resources are available.
@@ -435,10 +435,12 @@ enum {
  * system_power_efficient_wq is identical to system_wq if
  * 'wq_power_efficient' is disabled.  See WQ_POWER_EFFICIENT for more info.
  */
-extern struct workqueue_struct *system_wq;
+extern struct workqueue_struct *system_wq; /* use system_percpu_wq, this will be removed */
+extern struct workqueue_struct *system_percpu_wq;
 extern struct workqueue_struct *system_highpri_wq;
 extern struct workqueue_struct *system_long_wq;
 extern struct workqueue_struct *system_unbound_wq;
+extern struct workqueue_struct *system_dfl_wq;
 extern struct workqueue_struct *system_freezable_wq;
 extern struct workqueue_struct *system_power_efficient_wq;
 extern struct workqueue_struct *system_freezable_power_efficient_wq;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0c451d6c579a8d..fd215673ddf8a3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -425,12 +425,16 @@ static struct kthread_worker *pwq_release_worker;
 
 struct workqueue_struct *system_wq __read_mostly;
 EXPORT_SYMBOL(system_wq);
+struct workqueue_struct *system_percpu_wq __read_mostly;
+EXPORT_SYMBOL(system_percpu_wq);
 struct workqueue_struct *system_highpri_wq __read_mostly;
 EXPORT_SYMBOL_GPL(system_highpri_wq);
 struct workqueue_struct *system_long_wq __read_mostly;
 EXPORT_SYMBOL_GPL(system_long_wq);
 struct workqueue_struct *system_unbound_wq __read_mostly;
 EXPORT_SYMBOL_GPL(system_unbound_wq);
+struct workqueue_struct *system_dfl_wq __read_mostly;
+EXPORT_SYMBOL_GPL(system_dfl_wq);
 struct workqueue_struct *system_freezable_wq __read_mostly;
 EXPORT_SYMBOL_GPL(system_freezable_wq);
 struct workqueue_struct *system_power_efficient_wq __read_mostly;
@@ -6696,10 +6700,11 @@ void __init workqueue_init_early(void)
 	}
 
 	system_wq = alloc_workqueue("events", 0, 0);
+	system_percpu_wq = alloc_workqueue("events", 0, 0);
 	system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
 	system_long_wq = alloc_workqueue("events_long", 0, 0);
-	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND,
-					    WQ_MAX_ACTIVE);
+	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
+	system_dfl_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
 	system_freezable_wq = alloc_workqueue("events_freezable",
 					      WQ_FREEZABLE, 0);
 	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
@@ -6707,8 +6712,9 @@ void __init workqueue_init_early(void)
 	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_power_efficient",
 					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
 					      0);
-	BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
-	       !system_unbound_wq || !system_freezable_wq ||
+	BUG_ON(!system_wq || !system_percpu_wq || !system_highpri_wq ||
+	       !system_long_wq || !system_unbound_wq || !system_dfl_wq ||
+	       !system_freezable_wq ||
 	       !system_power_efficient_wq ||
 	       !system_freezable_power_efficient_wq);
 }
-- 
2.53.0


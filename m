Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F84A6888
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578748; cv=none; b=cabmnEh3mV88Z769hZq6anMku1RaRIOuaaWPS0QMNp9+o50FLMMXorDMncc9OPUUtu4de5ZgKIxQxzP4xF0zZqs6fuh2JZacUMcCcpS/0aK20+RgGvxf+vNKvg4BD8EjHoD6Uzruras48VmqI6GbWCankdQNOO/ylWU3FkR2N5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578748; c=relaxed/simple;
	bh=+ESTaKjnd+lr5mIhhT3CCCNrxAxan+eiEFj/ENV/SIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDfvAQkJSzv1yxWp+tf/nNyMz62DO+hYU1yQ0ey8529MbsnPIfGqLYCyx0dwE00mKxS7lHqWf1ONEeS2piM4s10HPwlyIm1HA/3DFmV6RkEsl49KXeaKvHyWYGzIFbaBw/Dw66tj0Tvevzpl+TO36S9l1dejVrFw9PelA4gE89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjioVT6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjioVT6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585121F00893;
	Wed, 16 Sep 2026 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789578740;
	bh=UpZFr761NMsICx+MPbkVp4G4RyZRIwGKtrqcZRgh/k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NjioVT6TamX3kkhEPmRuq6dGSm0GjKoC18FHHMUgQ9dmOsjFW1qcZ4UBhQi7t3M4Y
	 1pqvyLuO5lCOz1zu2tqRUAaCmq3/jQQ9WexB7tpAmjhiscHSSf81ZFtJii3neI3kKL
	 glaxpGh3aiBUMewtB/HJjMTSyDfBSj5eua45lPVILz+cW/3krZmb42GXiKSRnaIAqA
	 26vqRLVJKvNRHLO8qyI7Wyp2LM66JRkFPhZsi4TMis3CWKYRPHxZcgFpnuJfmpDKP1
	 YUEN9L1MTGaLLMr1LezPPN6/siFkorHnVnns4WicUMiRz6VtsNaGxszsfzbcwiWKZm
	 Gt1WxNbOCdhHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?=E6=9C=B1=E6=81=BA=E4=B9=BE?= <zhukaiqian@xiaomi.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?=E5=88=98=E6=9C=AF=E9=AB=98?= <liushugao@xiaomi.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tick/broadcast: Plug clockevents replacement race
Date: Wed, 16 Sep 2026 13:12:17 -0400
Message-ID: <20260916171217.785123-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091657-yoyo-rekindle-0050@gregkh>
References: <2026091657-yoyo-rekindle-0050@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 113a9796effe3376d2ec5aabcca1fef4fef4cd62 ]

朱恺乾 reported and decoded the following race condition when a broadcast
device is replaced:

CPUA					CPUB
 __tick_broadcast_oneshot_control()
   bc = tick_broadcast_device.evtdev;
					tick_install_broadcast_device(dev)
        				clockevents_exchange_device(cur, dev)
					   shutdown(cur);
					   detach(cur);
					   cur->handler = noop;
					   tick_broadcast_device.evtdev = dev;

  tick_broadcast_set_event(bc, next_event); <- FAIL: arms a detached device.

If the original broadcast device has a restricted interrupt affinity mask
and the last CPU in that mask goes offline then the BUG() in
tick_cleanup_dead_cpu() triggers because the clockevent device is not in
detached state.

The reason for this is that tick_install_broadcast_device() is not
serialized vs. tick broadcast operations.

The obvious cure is to serialize tick_install_broadcast_device() with
tick_broadcast_lock against a concurrent tick broadcast operation.

That requires to split clockevents_exchange_device() into two parts, one
which does the exchange, shutdown and detach operation and the other which
drops the module reference count. This is required because the module
reference cannot be dropped while holding tick_broadcast_lock.

Let clockevents_exchange_device() do both operations as before, but let the
broadcast device code take the two step approach and do the device
exchange under tick_broadcast_lock and drop the module reference count
after releasing it.

Fixes: f8381cba04ba ("[PATCH] tick-management: broadcast functionality")
Reported-by: 朱恺乾 <zhukaiqian@xiaomi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Tested-by: 刘术高 <liushugao@xiaomi.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/87cymdsu0r.ffs@tglx
[ Replaced scoped_guard() with a block containing guard() for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/clockevents.c    | 33 +++++++++++++++++++-------------
 kernel/time/tick-broadcast.c | 37 ++++++++++++++++++++++--------------
 kernel/time/tick-internal.h  |  2 ++
 3 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 003ccf338d201..87892f4c3f293 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -557,33 +557,40 @@ void clockevents_handle_noop(struct clock_event_device *dev)
 {
 }
 
-/**
- * clockevents_exchange_device - release and request clock devices
- * @old:	device to release (can be NULL)
- * @new:	device to request (can be NULL)
- *
- * Called from various tick functions with clockevents_lock held and
- * interrupts disabled.
- */
-void clockevents_exchange_device(struct clock_event_device *old,
-				 struct clock_event_device *new)
+void __clockevents_exchange_device(struct clock_event_device *old,
+				   struct clock_event_device *new)
 {
 	/*
 	 * Caller releases a clock event device. We queue it into the
 	 * released list and do a notify add later.
 	 */
 	if (old) {
-		module_put(old->owner);
 		clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
 		list_move(&old->list, &clockevents_released);
 	}
 
 	if (new) {
-		BUG_ON(!clockevent_state_detached(new));
+		WARN_ON(!clockevent_state_detached(new));
 		clockevents_shutdown(new);
 	}
 }
 
+/**
+ * clockevents_exchange_device - release and request clock devices
+ * @old:	device to release (can be NULL)
+ * @new:	device to request (can be NULL)
+ *
+ * Called from various tick functions with clockevents_lock held and
+ * interrupts disabled.
+ */
+void clockevents_exchange_device(struct clock_event_device *old,
+				 struct clock_event_device *new)
+{
+	__clockevents_exchange_device(old, new);
+	if (old)
+		module_put(old->owner);
+}
+
 /**
  * clockevents_suspend - suspend clock devices
  */
@@ -650,7 +657,7 @@ void tick_cleanup_dead_cpu(int cpu)
 		if (cpumask_test_cpu(cpu, dev->cpumask) &&
 		    cpumask_weight(dev->cpumask) == 1 &&
 		    !tick_is_broadcast_device(dev)) {
-			BUG_ON(!clockevent_state_detached(dev));
+			WARN_ON(!clockevent_state_detached(dev));
 			list_del(&dev->list);
 		}
 	}
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 13a71a894cc16..5ca420e0f7d35 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -162,23 +162,32 @@ static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
  */
 void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)
 {
-	struct clock_event_device *cur = tick_broadcast_device.evtdev;
+	struct clock_event_device *cur;
 
-	if (tick_set_oneshot_wakeup_device(dev, cpu))
-		return;
+	{
+		guard(raw_spinlock_irqsave)(&tick_broadcast_lock);
 
-	if (!tick_check_broadcast_device(cur, dev))
-		return;
+		if (tick_set_oneshot_wakeup_device(dev, cpu))
+			return;
 
-	if (!try_module_get(dev->owner))
-		return;
+		cur = tick_broadcast_device.evtdev;
+		if (!tick_check_broadcast_device(cur, dev))
+			return;
 
-	clockevents_exchange_device(cur, dev);
+		if (!try_module_get(dev->owner))
+			return;
+
+		__clockevents_exchange_device(cur, dev);
+		if (cur)
+			cur->event_handler = clockevents_handle_noop;
+		WRITE_ONCE(tick_broadcast_device.evtdev, dev);
+		if (!cpumask_empty(tick_broadcast_mask))
+			tick_broadcast_start_periodic(dev);
+	}
+
+	/* Module release must be outside of the lock */
 	if (cur)
-		cur->event_handler = clockevents_handle_noop;
-	tick_broadcast_device.evtdev = dev;
-	if (!cpumask_empty(tick_broadcast_mask))
-		tick_broadcast_start_periodic(dev);
+		module_put(cur->owner);
 
 	if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
 		return;
@@ -1205,7 +1214,7 @@ int tick_broadcast_oneshot_active(void)
  */
 bool tick_broadcast_oneshot_available(void)
 {
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
+	struct clock_event_device *bc = READ_ONCE(tick_broadcast_device.evtdev);
 
 	return bc ? bc->features & CLOCK_EVT_FEAT_ONESHOT : false;
 }
@@ -1213,7 +1222,7 @@ bool tick_broadcast_oneshot_available(void)
 #else
 int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 {
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
+	struct clock_event_device *bc = READ_ONCE(tick_broadcast_device.evtdev);
 
 	if (!bc || (bc->features & CLOCK_EVT_FEAT_HRTIMER))
 		return -EBUSY;
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 649f2b48e8f06..52e6fec7377d3 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -48,6 +48,8 @@ static inline void clockevent_set_state(struct clock_event_device *dev,
 }
 
 extern void clockevents_shutdown(struct clock_event_device *dev);
+extern void __clockevents_exchange_device(struct clock_event_device *old,
+					  struct clock_event_device *new);
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
 extern void clockevents_switch_state(struct clock_event_device *dev,
-- 
2.53.0


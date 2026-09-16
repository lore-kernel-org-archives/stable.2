Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C54E236C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580114; cv=none; b=VX6jzysYtQUJxkAFbLb15aRi2Wnk4IO39DNVr81UMaZmwrGGT1R677AsgVHMfnyxCTT3r1vsacTuCwCycHwJU5Cb8102J7iBW0vv1TjhaThjAUO9eMjVTQsUPjM1oPfprPhpAVCbSCHdCYnDSdpbIh0KE8cu4s36UnKIWcMOgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580114; c=relaxed/simple;
	bh=lVP0kK+jxEwtjyAYstjcRLqQCbLKMP7aqPzFA0o1UWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJK2WKOiETdIdyF5DDsjY7bnffrpdf5KYUTk2v7fK54oJmcYKCrRzdB+YLV8pAxf8KmstiTGpXPYLdaWELNp4CoTx+xLR/x67+ptu9vVbc3m3d+5lNYMPO/sdfAfWOvAu4FJblN5afPXY82VYMQ8MgJB+RXZAd2hTnVIV4txox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuMWZdBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuMWZdBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B67C1F000FF;
	Wed, 16 Sep 2026 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580099;
	bh=dXn4t4UTQmbsAW5WZlAIGjMMCE+Z2VX3Mjza49Evzfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PuMWZdBKaC78Nl5ehmtR/lHbUuxCZF5AIUDlUPov5Ti1Lb6EhgB5S0dlaRwYlzNas
	 rz6VB8smTjayGhBYqL4JDDK+w+KDmNBhH5IqHn1rspeuXsIH0tUFkSeC5nK78kRG3Y
	 5Gp0b+//DEpJrAkHtfzTbrAsyt5WjDbXR+1ALJCf9hdxeQsGzpLl21UkUxAHXv9462
	 W6yrwS24T8HAz0CNszJKF/hzAEWuAFBv13wALnb24K8tcMxfnglGMoG57btk+AnuCK
	 bSyhO/UNH8zSrjthDEiQBtMbbOwsAZhbBQ8yEhS392z8hjRbsCbfSWKf33SM5RLxbF
	 N4v2CcTz8t8qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?=E6=9C=B1=E6=81=BA=E4=B9=BE?= <zhukaiqian@xiaomi.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?=E5=88=98=E6=9C=AF=E9=AB=98?= <liushugao@xiaomi.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tick/broadcast: Plug clockevents replacement race
Date: Wed, 16 Sep 2026 13:34:57 -0400
Message-ID: <20260916173457.1131871-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091601-elevating-dragonfly-758f@gregkh>
References: <2026091601-elevating-dragonfly-758f@gregkh>
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
[ replaced scoped_guard() with a nested guard() block for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/clockevents.c    | 33 ++++++++++++++++++++-------------
 kernel/time/tick-broadcast.c | 34 ++++++++++++++++++++++------------
 kernel/time/tick-internal.h  |  2 ++
 3 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index f5490222e134a..49861ae3fc785 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -558,34 +558,41 @@ void clockevents_handle_noop(struct clock_event_device *dev)
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
 		list_del(&old->list);
 		list_add(&old->list, &clockevents_released);
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
@@ -651,7 +658,7 @@ void tick_cleanup_dead_cpu(int cpu)
 		if (cpumask_test_cpu(cpu, dev->cpumask) &&
 		    cpumask_weight(dev->cpumask) == 1 &&
 		    !tick_is_broadcast_device(dev)) {
-			BUG_ON(!clockevent_state_detached(dev));
+			WARN_ON(!clockevent_state_detached(dev));
 			list_del(&dev->list);
 		}
 	}
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index dc3838c00d6c7..35351b7fe486b 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -93,20 +93,30 @@ static bool tick_check_broadcast_device(struct clock_event_device *curdev,
  */
 void tick_install_broadcast_device(struct clock_event_device *dev)
 {
-	struct clock_event_device *cur = tick_broadcast_device.evtdev;
+	struct clock_event_device *cur;
 
-	if (!tick_check_broadcast_device(cur, dev))
-		return;
+	{
+		guard(raw_spinlock_irqsave)(&tick_broadcast_lock);
 
-	if (!try_module_get(dev->owner))
-		return;
+		cur = tick_broadcast_device.evtdev;
+		if (!tick_check_broadcast_device(cur, dev))
+			return;
+
+		if (!try_module_get(dev->owner))
+			return;
 
-	clockevents_exchange_device(cur, dev);
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
+
 	/*
 	 * Inform all cpus about this. We might be in a situation
 	 * where we did not switch to oneshot mode because the per cpu
@@ -1009,7 +1019,7 @@ int tick_broadcast_oneshot_active(void)
  */
 bool tick_broadcast_oneshot_available(void)
 {
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
+	struct clock_event_device *bc = READ_ONCE(tick_broadcast_device.evtdev);
 
 	return bc ? bc->features & CLOCK_EVT_FEAT_ONESHOT : false;
 }
@@ -1017,7 +1027,7 @@ bool tick_broadcast_oneshot_available(void)
 #else
 int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 {
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
+	struct clock_event_device *bc = READ_ONCE(tick_broadcast_device.evtdev);
 
 	if (!bc || (bc->features & CLOCK_EVT_FEAT_HRTIMER))
 		return -EBUSY;
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index e61c1244e7d46..0204523af663d 100644
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


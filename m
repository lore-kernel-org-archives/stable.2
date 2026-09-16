Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC084A5ED7
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568278; cv=none; b=HSOEgI3SzhKTPqgVi0dMHtpNBM4xcZQjoZX6oBGL3mqYeedQ61ddqMsaPkqJkrkzDl9l7B57Iyl/MFy1SqKwYKJCicPR/GJk37p7PSUT0+63kKTRsfHFl1JqYjDDl2fjG+jyqQXni1azInP0Efi8ZuGhUBjC7vQnTpBt+TOWRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568278; c=relaxed/simple;
	bh=r1zM6q89GLKpkLDuRer7rGfdJ/ngfpgdo9YRZIoKANM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bUK55cTcV+hkDTST0d1rCdmlZUVNeXxXRO3nilxxnJNI5MieJgzDNiW/JkKbOuwPWDEnv+32DXBSgqhyETuj5dWFKNjDcudKuz2BZYnMb3yEOhMF8zxN4/z9enIIjW7T5huL7uBCt2lmmEVznRXOF0kTPg+qqAcPL3kUKZkehm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KPhRFrup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KPhRFrup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01D31F000FF;
	Wed, 16 Sep 2026 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789568276;
	bh=WrEepDh8WPvvf/1O6PBqf96l+NegMMnjN59UDtEHZpU=;
	h=Subject:To:Cc:From:Date;
	b=KPhRFrup4W5uPULP+IXI6v5eR5zgMe+Gx3AeFeGRlpbbBI4UfQm6K0Sw2ygdtn9aD
	 Ukw3n1dcy+9JlfTtGSYOxF+lade3Tr2mdnAOxHNkuWLoD3aziUjgP2iZptatuiKcxt
	 V2NSNqBiHU/QCw7yVMndHsFAAfugUr2qKUsm6bFU=
Subject: FAILED: patch "[PATCH] tick/broadcast: Plug clockevents replacement race" failed to apply to 5.10-stable tree
To: tglx@kernel.org,brads@mainlining.org,liushugao@xiaomi.com,tglx@linutronix.de,zhukaiqian@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 15:16:01 +0100
Message-ID: <2026091601-elevating-dragonfly-758f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 113a9796effe3376d2ec5aabcca1fef4fef4cd62
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091601-elevating-dragonfly-758f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 113a9796effe3376d2ec5aabcca1fef4fef4cd62 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@kernel.org>
Date: Mon, 12 Aug 2024 16:19:48 +0200
Subject: [PATCH] tick/broadcast: Plug clockevents replacement race
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 0014d163f989..62ad7c000386 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -615,6 +615,24 @@ void clockevents_handle_noop(struct clock_event_device *dev)
 {
 }
 
+void __clockevents_exchange_device(struct clock_event_device *old,
+				   struct clock_event_device *new)
+{
+	/*
+	 * Caller releases a clock event device. We queue it into the
+	 * released list and do a notify add later.
+	 */
+	if (old) {
+		clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
+		list_move(&old->list, &clockevents_released);
+	}
+
+	if (new) {
+		WARN_ON(!clockevent_state_detached(new));
+		clockevents_shutdown(new);
+	}
+}
+
 /**
  * clockevents_exchange_device - release and request clock devices
  * @old:	device to release (can be NULL)
@@ -626,20 +644,9 @@ void clockevents_handle_noop(struct clock_event_device *dev)
 void clockevents_exchange_device(struct clock_event_device *old,
 				 struct clock_event_device *new)
 {
-	/*
-	 * Caller releases a clock event device. We queue it into the
-	 * released list and do a notify add later.
-	 */
-	if (old) {
+	__clockevents_exchange_device(old, new);
+	if (old)
 		module_put(old->owner);
-		clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
-		list_move(&old->list, &clockevents_released);
-	}
-
-	if (new) {
-		BUG_ON(!clockevent_state_detached(new));
-		clockevents_shutdown(new);
-	}
 }
 
 /**
@@ -699,7 +706,7 @@ void tick_offline_cpu(unsigned int cpu)
 		if (cpumask_test_cpu(cpu, dev->cpumask) &&
 		    cpumask_weight(dev->cpumask) == 1 &&
 		    !tick_is_broadcast_device(dev)) {
-			BUG_ON(!clockevent_state_detached(dev));
+			WARN_ON(!clockevent_state_detached(dev));
 			list_del(&dev->list);
 		}
 	}
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 115e0bf01276..bda3d2391a60 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -165,23 +165,31 @@ static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
  */
 void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)
 {
-	struct clock_event_device *cur = tick_broadcast_device.evtdev;
+	struct clock_event_device *cur;
 
-	if (tick_set_oneshot_wakeup_device(dev, cpu))
-		return;
+	scoped_guard(raw_spinlock_irqsave, &tick_broadcast_lock) {
 
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
@@ -1218,7 +1226,7 @@ int tick_broadcast_oneshot_active(void)
  */
 bool tick_broadcast_oneshot_available(void)
 {
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
+	struct clock_event_device *bc = READ_ONCE(tick_broadcast_device.evtdev);
 
 	return bc ? bc->features & CLOCK_EVT_FEAT_ONESHOT : false;
 }
@@ -1226,7 +1234,7 @@ bool tick_broadcast_oneshot_available(void)
 #else
 int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 {
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
+	struct clock_event_device *bc = READ_ONCE(tick_broadcast_device.evtdev);
 
 	if (!bc || (bc->features & CLOCK_EVT_FEAT_HRTIMER))
 		return -EBUSY;
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 182974c4f21b..65680db95053 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -55,6 +55,8 @@ static inline void clockevent_set_state(struct clock_event_device *dev,
 }
 
 extern void clockevents_shutdown(struct clock_event_device *dev);
+extern void __clockevents_exchange_device(struct clock_event_device *old,
+					  struct clock_event_device *new);
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
 extern void clockevents_switch_state(struct clock_event_device *dev,


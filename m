Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7B35B136;
	Mon,  7 Sep 2026 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772538; cv=none; b=gVlKQ9vrlHOBbIpumE1D7EfdnGA03qjdNQcvJ48Ye/9acm7w+A7bm/9HrkeIGpgAGHq1Yp9ArNwIXbDTF/EXfQS1CjrSPqmvAhLvlnctLkTMg47PNJjfMOF9EF8DWKOyW3ry5V26xYvz5z6B8mDKECSuCQJ4CBjjMGBOTGf+EH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772538; c=relaxed/simple;
	bh=JrhI1pwfP5E7pM/lrcbDACaZ5BelzgMgrifuwTDGV9U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IXhkYekE/KPRsSe1AQ+PIfKP5OqiWaD0B4JupvcUnlrRL5GVufC8sKejTQMuNEbkiJSXGuADhcarl+02+B5XoMY2IkEpvlS0+EPiqv0nA/eu0VmFwYKKdBLSo20JBb8qZGtciqN3QADr+7vRcnDdGAqjEBwXG00OFVwLVgvHmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jV05nrkB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7OBjapsh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jV05nrkB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7OBjapsh"
Date: Mon, 07 Sep 2026 09:15:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788772534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO9nRGpDhYZlMnMKD8svHE0MFR5a0GKjMcBKoppBhww=;
	b=jV05nrkBafELDtt3WXVaN7WEaynHEcOFchW593CklL0PjYzrr14gbr/E9Ua1Nxqq2ihx+Q
	/grU1x7s/nRw6DVhdo4y/q1T78zq8NtmJuvboItPYyuShI/P4WzDAnToDwkjLG7MOMp+lj
	R7jFBo9LU7krrjtcuW9CuUF8MW8jUAe4eBbuvaMIogyjpv+6Q0gT4C2VnwSpSNBP53KZDn
	YYo9beb/juHdUKdd7aZWB3O02iVcJSYSvzoEgBfLNZaQ/sdWBVpwUv6VdNhVXeovKSwMap
	2v8CuaAo1Qex4MFprjZ3f2/asznGwRCh75TH+Cg2Wu0lUHBZUgL7p2AX4UufRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788772534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO9nRGpDhYZlMnMKD8svHE0MFR5a0GKjMcBKoppBhww=;
	b=7OBjapsh6H6CQobK1vPhBG/mznTXsUtmyPoKlnxxIYyc4LLGMWH3q8MJC9zVwQfw08R2v1
	BqVjBObKrdPivNBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] tick/broadcast: Plug clockevents replacement race
Cc: zhukaiqian@xiaomi.com, Thomas Gleixner <tglx@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, Bradley Morgan <brads@mainlining.org>,
 liushugao@xiaomi.com, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87cymdsu0r.ffs@tglx>
References: <87cymdsu0r.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178877253200.623050.1090783884992407003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     113a9796effe3376d2ec5aabcca1fef4fef4cd62
Gitweb:        https://git.kernel.org/tip/113a9796effe3376d2ec5aabcca1fef4fef=
4cd62
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 12 Aug 2024 16:19:48 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 07 Sep 2026 11:10:20 +02:00

tick/broadcast: Plug clockevents replacement race

=E6=9C=B1=E6=81=BA=E4=B9=BE reported and decoded the following race condition=
 when a broadcast
device is replaced:

CPUA					CPUB
 __tick_broadcast_oneshot_control()
   bc =3D tick_broadcast_device.evtdev;
					tick_install_broadcast_device(dev)
        				clockevents_exchange_device(cur, dev)
					   shutdown(cur);
					   detach(cur);
					   cur->handler =3D noop;
					   tick_broadcast_device.evtdev =3D dev;

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
Reported-by: =E6=9C=B1=E6=81=BA=E4=B9=BE <zhukaiqian@xiaomi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Tested-by: =E5=88=98=E6=9C=AF=E9=AB=98 <liushugao@xiaomi.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/87cymdsu0r.ffs@tglx
---
 kernel/time/clockevents.c    | 33 +++++++++++++++++++-------------
 kernel/time/tick-broadcast.c | 36 +++++++++++++++++++++--------------
 kernel/time/tick-internal.h  |  2 ++-
 3 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 0014d16..62ad7c0 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -615,34 +615,41 @@ void clockevents_handle_noop(struct clock_event_device =
*dev)
 {
 }
=20
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
=20
 	if (new) {
-		BUG_ON(!clockevent_state_detached(new));
+		WARN_ON(!clockevent_state_detached(new));
 		clockevents_shutdown(new);
 	}
 }
=20
 /**
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
+/**
  * clockevents_suspend - suspend clock devices
  */
 void clockevents_suspend(void)
@@ -699,7 +706,7 @@ void tick_offline_cpu(unsigned int cpu)
 		if (cpumask_test_cpu(cpu, dev->cpumask) &&
 		    cpumask_weight(dev->cpumask) =3D=3D 1 &&
 		    !tick_is_broadcast_device(dev)) {
-			BUG_ON(!clockevent_state_detached(dev));
+			WARN_ON(!clockevent_state_detached(dev));
 			list_del(&dev->list);
 		}
 	}
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 115e0bf..bda3d23 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -165,23 +165,31 @@ static bool tick_set_oneshot_wakeup_device(struct clock=
_event_device *newdev,
  */
 void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)
 {
-	struct clock_event_device *cur =3D tick_broadcast_device.evtdev;
+	struct clock_event_device *cur;
=20
-	if (tick_set_oneshot_wakeup_device(dev, cpu))
-		return;
+	scoped_guard(raw_spinlock_irqsave, &tick_broadcast_lock) {
=20
-	if (!tick_check_broadcast_device(cur, dev))
-		return;
+		if (tick_set_oneshot_wakeup_device(dev, cpu))
+			return;
=20
-	if (!try_module_get(dev->owner))
-		return;
+		cur =3D tick_broadcast_device.evtdev;
+		if (!tick_check_broadcast_device(cur, dev))
+			return;
=20
-	clockevents_exchange_device(cur, dev);
+		if (!try_module_get(dev->owner))
+			return;
+
+		__clockevents_exchange_device(cur, dev);
+		if (cur)
+			cur->event_handler =3D clockevents_handle_noop;
+		WRITE_ONCE(tick_broadcast_device.evtdev, dev);
+		if (!cpumask_empty(tick_broadcast_mask))
+			tick_broadcast_start_periodic(dev);
+	}
+
+	/* Module release must be outside of the lock */
 	if (cur)
-		cur->event_handler =3D clockevents_handle_noop;
-	tick_broadcast_device.evtdev =3D dev;
-	if (!cpumask_empty(tick_broadcast_mask))
-		tick_broadcast_start_periodic(dev);
+		module_put(cur->owner);
=20
 	if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
 		return;
@@ -1218,7 +1226,7 @@ int tick_broadcast_oneshot_active(void)
  */
 bool tick_broadcast_oneshot_available(void)
 {
-	struct clock_event_device *bc =3D tick_broadcast_device.evtdev;
+	struct clock_event_device *bc =3D READ_ONCE(tick_broadcast_device.evtdev);
=20
 	return bc ? bc->features & CLOCK_EVT_FEAT_ONESHOT : false;
 }
@@ -1226,7 +1234,7 @@ bool tick_broadcast_oneshot_available(void)
 #else
 int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 {
-	struct clock_event_device *bc =3D tick_broadcast_device.evtdev;
+	struct clock_event_device *bc =3D READ_ONCE(tick_broadcast_device.evtdev);
=20
 	if (!bc || (bc->features & CLOCK_EVT_FEAT_HRTIMER))
 		return -EBUSY;
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 182974c..65680db 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -55,6 +55,8 @@ static inline void clockevent_set_state(struct clock_event_=
device *dev,
 }
=20
 extern void clockevents_shutdown(struct clock_event_device *dev);
+extern void __clockevents_exchange_device(struct clock_event_device *old,
+					  struct clock_event_device *new);
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
 extern void clockevents_switch_state(struct clock_event_device *dev,

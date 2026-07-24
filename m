Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6C3515C8
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882536; cv=pass; b=l2z/IiGZNSQdOH2X+/9OMN+DWKonsqV3O9K468DMWH49F8NIQy9f/dgS1Gb/Ach3IE9fN5ihhoggw9XQ4uIQM0HD+kEMbRMUSBq/8ZvL2SlKgPaRyj6MgAQHwUczoKC/GKuUl0T0gnlrFGal4FkUEDXCksoW5Go1cwlMTSu00fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882536; c=relaxed/simple;
	bh=3FFKPOsk1TrCrXj1oiKJBwHB4jCcN0u/YqyrA/dPxtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+9ymon0IVjvwCyPS0wWOgNQBisNpB+API/xSawFCmqJHU7bGIp5roHdoP5zQ/4CsvYtDN1g22LwexwrkTdKEh6WLHpFIvJpMdqLrRosE9zjSyKPuyF55UC+XyajD8voPOaiTgQnLqSTI33m3pVew1jQZce+fpDuOwnIQpTfS6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=m0UfuQzk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=7qFdBKtV; arc=pass smtp.client-ip=81.169.146.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="m0UfuQzk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="7qFdBKtV"
ARC-Seal: i=1; a=rsa-sha256; t=1784882531; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=k5xgLi6/0ihMHm2Ar1/CWpOlWw3a4PjbBbXj55e8CcdISQCONtYT0/rIYnf7eVs+iu
    7s6hmuUZTlU7cilnZzsqwCIXhoAPzkArguybnup9A27buSn0YwGamSa7likeNyxKmOtL
    WjGMvsGP+r0p48N4glgHxj9WlXQHWgSPNLOmrrTq50/NdLdX09jiQhpjqOxOhxjcdWSQ
    7Er1eMbD9Ord4NT8HfYDMegP2Lv9aq67go2TySfKQ4VUBItgRS7gaimD0OcFRHAsChpb
    rtP4qhFKYI0ycomdUH4MGk0DBCzgIUuawlXIovuuy5GJieCPHR+31Z/vP1pO13pKTo2R
    3YtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882531;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0/mBNH7cm4SwrdiBZZQmX+Vg6SbIdM4tHobaGtnm8Mk=;
    b=O4LWW2FOK5mPylbDX5oqV4rTFQZkf5q2WPTSbbdr6n30Uc56xU03KOKngER1CX/nP8
    ZUOsqz6xdb2u3FO7r/menc1rXanGe1AUzT+S9B8PgZl3T0SATLXJxGd7lEfJZVCFu+C0
    YunitQb3zzv62bk4Dfsm1wNoC3dUmmsvNJRPRVEa/2L/eX+aPSViHRU7NTKINdb60PHz
    2cTMqURM7NWwuIpSU7SCjCJOqVzXI7YMRDUBiTXsmXezht90nparkDhSshi7F+au0Fbr
    a8KhmpiuW1vtm9Ti1S0ZyKZO9Jte5/kYvY7/Ff5hnvlWEWtlneXmqddDdpkogTiuAdf0
    laWA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882531;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0/mBNH7cm4SwrdiBZZQmX+Vg6SbIdM4tHobaGtnm8Mk=;
    b=m0UfuQzkOSHh/O4J6BHqsh1JOMuf/Lqc+sbvDaC5i0YzmSgwkeDnwKJ24vI1fy/+hU
    pJcVdHQ2j1+8X17tyGn/mUKWlMZnCuXVzi60rCXO2B+tO67jwno+AQ28bi//E0z2worP
    bxOR/RQm0fZfexUkpSsz+Vs57utWAbvCvJsEpaN5NbbdgJhNciLBKg9asAEMLTRj3qZA
    yU18gF/sWaQgPv5XeanJmrLMvtMVa+SjkJlOAIpM8G/Icc4v7vWovFPBZWDdNbOOmgHY
    F3QUUHY1FdYN9VmIdgQsJ4RXXhI3b7x5Y425cbJqNvm6FgYLREpCgm3w3KYubVsUXRr1
    q9rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882531;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0/mBNH7cm4SwrdiBZZQmX+Vg6SbIdM4tHobaGtnm8Mk=;
    b=7qFdBKtVh/C3ATDNIe364gN+dOU7LiOfMDdEsNJKNkJRleGoul8oRbiEQmFDEJ/tKX
    WmIjMZrCBDqrGD+q3JCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8gBrXJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:42:11 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/8] can: bcm: add locking when updating filter and timer values
Date: Fri, 24 Jul 2026 10:41:57 +0200
Message-ID: <20260724084204.13169-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072010-winner-hurried-07df@gregkh>
References: <2026072010-winner-hurried-07df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit 749179c2e25b95d22499ed29096b3e02d6dfd2b4 upstream.

KCSAN detected a simultaneous access to timer values that can be
overwritten in bcm_rx_setup() when updating timer and filter content
while bcm_rx_handler(), bcm_rx_timeout_handler() or bcm_rx_thr_handler()
run concurrently on incoming CAN traffic.

Protect the timer (ival1/ival2/kt_ival1/kt_ival2/kt_lastmsg) and filter
(nframes/flags/frames/last_frames) updates in bcm_rx_setup() with a new
per-op bcm_rx_update_lock, taken with the matching scope in the RX
handlers. memcpy_from_msg() is staged into a temporary buffer before the
lock is taken, since it can sleep and must not run under a spinlock.

hrtimer_cancel() is always called without bcm_rx_update_lock held, since
bcm_rx_timeout_handler()/bcm_rx_thr_handler() take the same lock and a
running callback would otherwise deadlock against the canceller.

Also close a related race: bcm_rx_setup() cleared the RTR flag in the
stored reply frame's can_id as a separate, unprotected step after the
frame content was already installed, so a concurrent bcm_rx_handler()
could transmit a stale reply with CAN_RTR_FLAG still set. Fold that
normalization into the initial frame preparation instead (on the staged
buffer for updates, directly on op->frames pre-registration for new
ops), so the installed frame is always atomically self-consistent.

bcm_rx_handler()'s RX_RTR_FRAME check now takes a lock-protected
snapshot of op->flags before deciding whether to call bcm_can_tx(),
but does not hold the lock across that call.

Also take a lock-protected snapshot of the currframe in bcm_can_tx()
to avoid partly overwrites by content updates in bcm_tx_setup().
Finally check if a TX_RESET_MULTI_IDX/SETTIMER might have reset
op->currframe between the two locked sections in bcm_can_tx().

Omit calling hrtimer_forward() with zero interval in bcm_rx_thr_handler().
kt_ival2 may have been concurrently cleared by bcm_rx_setup() before it
cancels this timer, so check kt_ival2 inside the bcm_rx_update_lock.

Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
Reported-by: syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@google.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-3-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 176 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 133 insertions(+), 43 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 9b940e8..3d151bb 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -128,6 +128,7 @@ struct bcm_op {
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
 	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
+	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
 
 struct bcm_sock {
@@ -292,21 +293,27 @@ static int bcm_proc_show(struct seq_file *m, void *v)
  * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interface
  *              of the given bcm tx op
  */
-static void bcm_can_tx(struct bcm_op *op)
+static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 {
 	struct sk_buff *skb;
 	struct net_device *dev;
-	struct canfd_frame *cf;
+	struct canfd_frame cframe;
+	bool cyclic = !cf;
+	unsigned int idx = 0;
 	int err;
 
 	/* no target device? => exit */
 	if (!op->ifindex)
 		return;
 
-	/* read currframe under lock protection */
-	spin_lock_bh(&op->bcm_tx_lock);
-	cf = op->frames + op->cfsiz * op->currframe;
-	spin_unlock_bh(&op->bcm_tx_lock);
+	if (cyclic) {
+		/* read currframe under lock protection */
+		spin_lock_bh(&op->bcm_tx_lock);
+		idx = op->currframe;
+		memcpy(&cframe, op->frames + op->cfsiz * idx, op->cfsiz);
+		cf = &cframe;
+		spin_unlock_bh(&op->bcm_tx_lock);
+	}
 
 	dev = dev_get_by_index(sock_net(op->sk), op->ifindex);
 	if (!dev) {
@@ -335,14 +342,20 @@ static void bcm_can_tx(struct bcm_op *op)
 	if (!err)
 		op->frames_abs++;
 
-	op->currframe++;
+	/* only advance the cyclic sequence if nothing reset currframe while
+	 * we were sending - a concurrent TX_RESET_MULTI_IDX means this
+	 * frame's bookkeeping belongs to a sequence that no longer exists
+	 */
+	if (!cyclic || op->currframe == idx) {
+		op->currframe++;
 
-	/* reached last frame? */
-	if (op->currframe >= op->nframes)
-		op->currframe = 0;
+		/* reached last frame? */
+		if (op->currframe >= op->nframes)
+			op->currframe = 0;
 
-	if (op->count > 0)
-		op->count--;
+		if (op->count > 0)
+			op->count--;
+	}
 
 	spin_unlock_bh(&op->bcm_tx_lock);
 out:
@@ -456,7 +469,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 	struct bcm_msg_head msg_head;
 
 	if (op->kt_ival1 && (op->count > 0)) {
-		bcm_can_tx(op);
+		bcm_can_tx(op, NULL);
 		if (!op->count && (op->flags & TX_COUNTEVT)) {
 
 			/* create notification to user */
@@ -473,7 +486,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 		}
 
 	} else if (op->kt_ival2) {
-		bcm_can_tx(op);
+		bcm_can_tx(op, NULL);
 	}
 
 	return bcm_tx_set_expiry(op, &op->timer) ?
@@ -617,6 +630,8 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, timer);
 	struct bcm_msg_head msg_head;
 
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
 	/* if user wants to be informed, when cyclic CAN-Messages come back */
 	if ((op->flags & RX_ANNOUNCE_RESUME) && op->last_frames) {
 		/* clear received CAN frames to indicate 'nothing received' */
@@ -633,6 +648,8 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 	msg_head.can_id  = op->can_id;
 	msg_head.nframes = 0;
 
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
 	bcm_send_to_user(op, &msg_head, NULL, 0);
 
 	return HRTIMER_NORESTART;
@@ -681,15 +698,26 @@ static int bcm_rx_thr_flush(struct bcm_op *op)
 static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
 {
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, thrtimer);
+	enum hrtimer_restart ret;
 
-	if (bcm_rx_thr_flush(op)) {
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
+	/* kt_ival2 may have been concurrently cleared by bcm_rx_setup()
+	 * before it cancels this timer - never forward with a zero
+	 * interval in that case.
+	 */
+	if (bcm_rx_thr_flush(op) && op->kt_ival2) {
 		hrtimer_forward_now(hrtimer, op->kt_ival2);
-		return HRTIMER_RESTART;
+		ret = HRTIMER_RESTART;
 	} else {
 		/* rearm throttle handling */
 		op->kt_lastmsg = 0;
-		return HRTIMER_NORESTART;
+		ret = HRTIMER_NORESTART;
 	}
+
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
+	return ret;
 }
 
 /*
@@ -699,8 +727,10 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 {
 	struct bcm_op *op = (struct bcm_op *)data;
 	const struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
+	struct canfd_frame rtrframe;
 	unsigned int i;
 	unsigned char traffic_flags;
+	bool rtr_frame;
 
 	if (op->can_id != rxframe->can_id)
 		return;
@@ -724,9 +754,18 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* update statistics */
 	op->frames_abs++;
 
-	if (op->flags & RX_RTR_FRAME) {
+	/* snapshot the flag under lock: op->flags/op->frames may be updated
+	 * concurrently by bcm_rx_setup().
+	 */
+	spin_lock_bh(&op->bcm_rx_update_lock);
+	rtr_frame = op->flags & RX_RTR_FRAME;
+	if (rtr_frame)
+		memcpy(&rtrframe, op->frames, op->cfsiz);
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
+	if (rtr_frame) {
 		/* send reply for RTR-request (placed in op->frames[0]) */
-		bcm_can_tx(op);
+		bcm_can_tx(op, &rtrframe);
 		return;
 	}
 
@@ -738,6 +777,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			traffic_flags |= RX_OWN;
 	}
 
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe,
@@ -773,6 +814,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 
 rx_starttimer:
 	bcm_rx_starttimer(op);
+
+	spin_unlock_bh(&op->bcm_rx_update_lock);
 }
 
 /*
@@ -1115,7 +1158,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		list_add_rcu(&op->list, &bo->tx_ops);
 
 	if (op->flags & TX_ANNOUNCE)
-		bcm_can_tx(op);
+		bcm_can_tx(op, NULL);
 
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
@@ -1129,6 +1172,24 @@ free_op:
 	return err;
 }
 
+static void bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
+				   struct bcm_op *op, void *new_frames)
+{
+	/* funny feature in RX(!)_SETUP only for RTR-mode:
+	 * copy can_id into frame BUT without RTR-flag to
+	 * prevent a full-load-loopback-test ... ;-]
+	 * normalize this on the staged buffer, before it is
+	 * ever installed into op->frames.
+	 */
+	if (msg_head->flags & RX_RTR_FRAME) {
+		struct canfd_frame *frame0 = new_frames;
+
+		if ((msg_head->flags & TX_CP_CAN_ID) ||
+		    frame0->can_id == op->can_id)
+			frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
+	}
+}
+
 /*
  * bcm_rx_setup - create or update a bcm rx op (for bcm_sendmsg)
  */
@@ -1163,6 +1224,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	/* check the given can_id */
 	op = bcm_find_op(&bo->rx_ops, msg_head, ifindex);
 	if (op) {
+		void *new_frames = NULL;
+
 		/* update existing BCM operation */
 
 		/*
@@ -1174,19 +1237,48 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			return -E2BIG;
 
 		if (msg_head->nframes) {
-			/* update CAN frames content */
-			err = memcpy_from_msg(op->frames, msg,
+			/* get new CAN frames content before locking */
+			new_frames = kmalloc(msg_head->nframes * op->cfsiz,
+					     GFP_KERNEL);
+			if (!new_frames)
+				return -ENOMEM;
+
+			err = memcpy_from_msg(new_frames, msg,
 					      msg_head->nframes * op->cfsiz);
-			if (err < 0)
+			if (err < 0) {
+				kfree(new_frames);
 				return err;
+			}
 
-			/* clear last_frames to indicate 'nothing received' */
-			memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
+			bcm_rx_setup_rtr_check(msg_head, op, new_frames);
 		}
 
+		spin_lock_bh(&op->bcm_rx_update_lock);
 		op->nframes = msg_head->nframes;
 		op->flags = msg_head->flags;
 
+		if (msg_head->nframes) {
+			/* update CAN frames content */
+			memcpy(op->frames, new_frames,
+			       msg_head->nframes * op->cfsiz);
+
+			/* clear last_frames to indicate 'nothing received' */
+			memset(op->last_frames, 0,
+			       msg_head->nframes * op->cfsiz);
+		}
+
+		if (msg_head->flags & SETTIMER) {
+			op->ival1 = msg_head->ival1;
+			op->ival2 = msg_head->ival2;
+			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
+			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+			op->kt_lastmsg = 0;
+		}
+		spin_unlock_bh(&op->bcm_rx_update_lock);
+
+		/* free temporary frames / kfree(NULL) is safe */
+		kfree(new_frames);
+
 		/* Only an update -> do not call can_rx_register() */
 		do_rx_register = 0;
 
@@ -1197,6 +1289,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			return -ENOMEM;
 
 		spin_lock_init(&op->bcm_tx_lock);
+		spin_lock_init(&op->bcm_rx_update_lock);
 		op->can_id = msg_head->can_id;
 		op->nframes = msg_head->nframes;
 		op->cfsiz = CFSIZ(msg_head->flags);
@@ -1238,6 +1331,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 				kfree(op);
 				return err;
 			}
+
+			bcm_rx_setup_rtr_check(msg_head, op, op->frames);
 		}
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
@@ -1262,29 +1357,22 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	/* check flags */
 
 	if (op->flags & RX_RTR_FRAME) {
-		struct canfd_frame *frame0 = op->frames;
-
 		/* no timers in RTR-mode */
 		hrtimer_cancel(&op->thrtimer);
 		hrtimer_cancel(&op->timer);
-
-		/*
-		 * funny feature in RX(!)_SETUP only for RTR-mode:
-		 * copy can_id into frame BUT without RTR-flag to
-		 * prevent a full-load-loopback-test ... ;-]
-		 */
-		if ((op->flags & TX_CP_CAN_ID) ||
-		    (frame0->can_id == op->can_id))
-			frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
-
 	} else {
 		if (op->flags & SETTIMER) {
 
-			/* set timer value */
-			op->ival1 = msg_head->ival1;
-			op->ival2 = msg_head->ival2;
-			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
-			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+			/* set timers (locked) for newly created op */
+			if (do_rx_register) {
+				spin_lock_bh(&op->bcm_rx_update_lock);
+				op->ival1 = msg_head->ival1;
+				op->ival2 = msg_head->ival2;
+				op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
+				op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+				op->kt_lastmsg = 0;
+				spin_unlock_bh(&op->bcm_rx_update_lock);
+			}
 
 			/* disable an active timer due to zero value? */
 			if (!op->kt_ival1)
@@ -1294,9 +1382,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			 * In any case cancel the throttle timer, flush
 			 * potentially blocked msgs and reset throttle handling
 			 */
-			op->kt_lastmsg = 0;
 			hrtimer_cancel(&op->thrtimer);
+
+			spin_lock_bh(&op->bcm_rx_update_lock);
 			bcm_rx_thr_flush(op);
+			spin_unlock_bh(&op->bcm_rx_update_lock);
 		}
 
 		if ((op->flags & STARTTIMER) && op->kt_ival1)
-- 
2.43.0


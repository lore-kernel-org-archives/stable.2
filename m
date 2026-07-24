Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795D40312F
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888052; cv=pass; b=OH8PdMWFZ1CSljAeFiy+VB/sJSqBerQwx/xtpgrgNnJ+IMwaDpd29uKQyjvqIU8t8e7IzpKSwAVYRF04ztksa8z569z12hh2A+7mhtN6Z//F2Aaw8E1XshvJ8U765wHvkuN8Q6PhAaeZUvU8Kjgz4VO8avuOxsZycTUgvsH4XXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888052; c=relaxed/simple;
	bh=CoAnXheM75RzwoChUa/X/6JqOSVOyDyGM73r80FcGBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bht5TYxIB6NAdcmgl4xetWFp9hjc4o/CvhJYLmwiL8zvwtvUiGU0sdLupKDlQmsP3/1I0e7vKt9BQW9Q5Wxo/hCk3Y9g6m0gaFUKQ2jWjB8lp6ghoK7RLbsNk1xcmf6y6ZbKJe4uwxFKOOSU5WUCxAxDjGaIcmBscBqzckhjaDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MpUzMoED; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=xkXOWDUU; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MpUzMoED";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="xkXOWDUU"
ARC-Seal: i=1; a=rsa-sha256; t=1784888047; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=X87LMITql8HIRl540IOkkeBDc7wke6PtrPICDLWrcxT0M9HTmI2hLxNoR2CDatUTUZ
    OhA4ulyGQAGZHhQ2Y3i9R2/5JSjOBw1cu1ux/GfE1JGMzZZpN5nYgnMMt0e0LCL07DdK
    aC+VP4SRJYBQP47rAnBD3BWsbI3f8R81DmTQaXJYV2cmyB901ZHps0VUYYCZuI1OX1J1
    dcFMOyHRzLyAhReiCJ7kaq3/hAaSYqqhJGD9wEbaXNfBt4pungwXpPjr40cVKNR1YIgj
    OQsEKAD6U4e7iwizoJdgg/6lDd0u2RuC5cuobpRSSbrY4I1RcNJZF+nuaghxKpApl+qk
    jVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888047;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DAi+mTzvMsmGBK0a1mIE8Xs9eI7CNJl1WUcCdQ1bAkA=;
    b=Al2qBR13jHT0PIOkMlgYjbp+BkesShUdEdRNaJ4k18M4jbNnJs3mFIFEAyqOzXCaGy
    blTQtsac1+66MnA7OHKd78y7qopiu9yonTrezsoLa3nZB8LTsxTW8mswDzh/q/nzbQT8
    K9s6ToIGLCreAqGScfURrxI8FV7l6s1GVeFXmdOD9wm7b0bOcjFmhAsqg4h/0OgR1dNM
    fD8ycCGCfiny2cucTZAE0ZAzMMCmG14EAT0QDQKm8bs37sSgo/zc2R955ORkIa2t7m6Q
    z0Wudeih5/ih4l4oGORaUVnLPnHo/Qlzt7I0BHfVshHLCR0RAWnqx8Q/y30eJIomTxuj
    f7XQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888047;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DAi+mTzvMsmGBK0a1mIE8Xs9eI7CNJl1WUcCdQ1bAkA=;
    b=MpUzMoEDxiVOoUB8xfEoEIx4PfOguJnpy/DwIr2LANQifGU/zjWUpdCfgg1JZo3Lzg
    fA9zeByWJqZ5PD/nsHNmXrr46uMfGQ9NuPtHH5tQwqwGcAjTcGbr1Vr3OfAi9NvcuZmz
    hURiVhQ9jHjeUEsSzD+twoks7DrNH4Mllm/rIRD4G5+ie99YQRtLiVvovArIrg0DkSXT
    DCgwoyv3XKV56+piM0VcPlCQmXTvK1FWmBHGNGj0hy9oICRYnISRlRZhGdP0zgSpQ0i3
    PcWCWnVyYpbKwK5bP17eDV8tX/Ng21SuFhu2eflJQiowZynlOcWMeNxT0Mp7akT6Pwwj
    RH7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888047;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DAi+mTzvMsmGBK0a1mIE8Xs9eI7CNJl1WUcCdQ1bAkA=;
    b=xkXOWDUUQ/VEOeLNmKvSDqlcPBSfRIhvlao6JTA3oLID+cpPTA6aTsYbfVtjXaivfB
    Mpn73R6gZoCkgUyX+2BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAE6tFJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:14:06 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y 9/9] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
Date: Fri, 24 Jul 2026 12:13:42 +0200
Message-ID: <20260724101342.16000-9-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724101342.16000-1-socketcan@hartkopp.net>
References: <2026072037-bagginess-bluish-c081@gregkh>
 <20260724101342.16000-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit 2f5976f54a04e9f18b25283036ac3136be453b17 upstream.

An ANYDEV rx op (ifindex == 0) with an active RX timeout and/or
throttle timer has no defined semantics when matching frames arrive
from several interfaces: bcm_rx_handler() can run concurrently for
the same op on different CPUs, racing hrtimer_cancel()/
bcm_rx_starttimer() against bcm_rx_timeout_handler() and causing
spurious RX_TIMEOUT notifications and last_frames corruption. The
same concurrency lets throttled multiplex frames from different
interfaces clobber the single rx_ifindex/rx_stamp fields shared by
the op.

Add op->if_detected to track the first interface that delivers a
matching frame while a timeout/throttle timer is configured, and
reject frames from any other interface for that op. The claim is
decided in bcm_rx_handler() before hrtimer_cancel() touches
op->timer, so a rejected frame can never disturb the claimed
interface's watchdog. RTR-mode ops are excluded via RX_RTR_FRAME,
independent of kt_ival1/kt_ival2, since those may briefly hold a
stale value from an earlier non-RTR configuration.

The claim is released in bcm_notify() on NETDEV_UNREGISTER and in
bcm_rx_setup() when SETTIMER reconfigures the timer values.

A (re-)claim is only possible on CAN devices in NETREG_REGISTERED
dev->reg_state to cover the release in bcm_notify() where reg_state
becomes NETREG_UNREGISTERING until synchronize_net().

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-can/20260709105031.1A39C1F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-11-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 95eb791..8dc3e6c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -114,6 +114,7 @@ struct bcm_op {
 	struct hrtimer timer, thrtimer;
 	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
 	int rx_ifindex;
+	int if_detected; /* first received ifindex in ANYDEV rx_op mode */
 	int cfsiz;
 	u32 count;
 	u32 nframes;
@@ -753,6 +754,33 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	if (skb->len != op->cfsiz)
 		return;
 
+	/* An ANYDEV op with an active RX timeout and/or throttle timer
+	 * tracks a single source interface: claim the first interface that
+	 * delivers a matching frame and reject frames from any other one,
+	 * before hrtimer_cancel() below can touch op->timer - this avoids
+	 * racing bcm_rx_timeout_handler() across concurrent interfaces.
+	 * RX_RTR_FRAME ops are excluded, as kt_ival1/kt_ival2 may briefly
+	 * hold a stale value from an earlier non-RTR configuration.
+	 */
+	if (!op->ifindex) {
+		spin_lock_bh(&op->bcm_rx_update_lock);
+
+		if (!(op->flags & RX_RTR_FRAME) &&
+		    (op->kt_ival1 || op->kt_ival2)) {
+			/* don't claim to vanishing interface */
+			if (!op->if_detected &&
+			    skb->dev->reg_state == NETREG_REGISTERED)
+				op->if_detected = skb->dev->ifindex;
+
+			if (op->if_detected != skb->dev->ifindex) {
+				spin_unlock_bh(&op->bcm_rx_update_lock);
+				return;
+			}
+		}
+
+		spin_unlock_bh(&op->bcm_rx_update_lock);
+	}
+
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
@@ -779,10 +807,9 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	 */
 	bcm_update_rx_stats(op);
 
-	/* save rx timestamp and originator for recvfrom() under lock.
-	 * For an op subscribed on all interfaces (ifindex == 0)
-	 * bcm_rx_handler() can run concurrently on different CPUs so
-	 * the CAN content and the meta data must be bundled correctly.
+	/* save rx timestamp and originator for recvfrom() under lock: an
+	 * ANYDEV op without an active timer can still run concurrently on
+	 * different CPUs, so content and meta data must be bundled here.
 	 */
 	op->rx_stamp = skb->tstamp;
 	op->rx_ifindex = skb->dev->ifindex;
@@ -1316,6 +1343,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
 			op->kt_lastmsg = 0;
+			op->if_detected = 0; /* reclaim ifindex in ANYDEV mode */
 		}
 		spin_unlock_bh(&op->bcm_rx_update_lock);
 
@@ -1719,10 +1747,21 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 		lock_sock(sk);
 
 		/* rx_ops: remove device specific receive entries */
-		list_for_each_entry(op, &bo->rx_ops, list)
+		list_for_each_entry(op, &bo->rx_ops, list) {
 			if (op->rx_reg_dev == dev)
 				bcm_rx_unreg(dev, op);
 
+			/* release an ANYDEV op's claim (see bcm_rx_handler())
+			 * on this now confirmed-gone interface.
+			 */
+			if (!op->ifindex) {
+				spin_lock_bh(&op->bcm_rx_update_lock);
+				if (op->if_detected == dev->ifindex)
+					op->if_detected = 0;
+				spin_unlock_bh(&op->bcm_rx_update_lock);
+			}
+		}
+
 		/* tx_ops: stop device specific cyclic transmissions on the
 		 * vanishing ifindex. Cancelling the timer is enough to stop
 		 * cyclic bcm_can_tx() calls as there is no re-arming.
-- 
2.43.0


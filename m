Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AF53CBE7A
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882632; cv=pass; b=VTE57N/pHOFjvKZicgPlp2jnNK6EVRs5kLAchJCgnuULNmYIhmjVIIiZIaDA9gPV3yuIJ7rPK5BRq0ZFsn6oi7EPds9PWAyUhWmGD4LRURCXFSVrp0HLU8wU0Q+ZkcvVADDmQWpFh4U2+zkXfkBlmdhnD6jHsnE0KFvHOpI+uzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882632; c=relaxed/simple;
	bh=Pc0yBTzTDt1DJ5hrtPHJpkyxvh5nTw7f2v9UzGkvTOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNOYquQn9dPVvBNhZxWIDHtLokX3Q+y23dNUBCGLjyopeUZhubEPQsWdu8lI6qnGWLUcC4UVceTn38HQILalfCsRZuquEOZUUQlRtpI/B3qJch8GcwiWo1Pj7Ic7f2MkTh4mi6oxweC0flnm9diXAahopdC3Ym02aexyiBTEdk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Eh1uAEZk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=EV9v3mvz; arc=pass smtp.client-ip=81.169.146.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Eh1uAEZk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EV9v3mvz"
ARC-Seal: i=1; a=rsa-sha256; t=1784882450; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TD2jUfEYRBGTY1nita5NbW4vE5BMMOSRT0xYH6prBQrR/M3vqKsCXcavKSP8A0MGIX
    jpyWOdi5nEyafeCaDHGekRbiTr/Q+pOH5hJ8w/JsrxHzmR72nXEARcy8wi0chCTBwLJh
    27+uyeVK3vGFkUkZdfHmxaazsn8PzhAk/QLNRSqfqw0tlZSgW25Dzpbr1/GvF6tJDwxp
    jFCnNHD0lCWg0INGc+Ke+EN1qu0nVlI8MFzFzuf3a7YSuvhOBCQGH97vneww4YR7g1PO
    vr0CDV2JG9Dn508FJ8rPA2XbBUO0raJ4tqMmY4gmAYIuBjG0SHd2aliLuleRsDcXBG+W
    3FWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882450;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=siknNDG2uKaEvvTfUJ5bu54jWmwU/odjQQwWHyNERXc=;
    b=chbpvHWAHgssv9uDcBvhCaPsdANTsFv8RjkRAxuq4YDVPXv5/SjeSr18u7S7GAvN9x
    1EwkGXROkz4oj87L6/EbVqqmgsduJkDxlRfRorMUGA5hsjAExIjoaAVMxuIda5tWKKIK
    dn/20fnPhTKDTTJu28iUglCcpehaTII0gWjdNtK6uWtp/NgX1BA78DPBIA15PGJzfFNi
    CEW4BaZGZYdPnQa9tE6SiE+/Ef6vj1VByhLQu3SnXkHnBhjOMSnzCruQxGBB6sFfL9zW
    0N0G/pRJJOpMmPyjJxX/vWM64T9eFhl2LsSZDO/lTy8grd1JzfXV3NTrytD3smasAYi6
    7jwg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882450;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=siknNDG2uKaEvvTfUJ5bu54jWmwU/odjQQwWHyNERXc=;
    b=Eh1uAEZkF2LqrbYx5cPDmAfbxc/npw9Cj5nhOHZBFORdH5U7tzNH4YBNVPuWmHSkCq
    CpughCoIzuA0yJx3wCduel/5bscuvyYkiCDIRVZx1dTJAqjljnxsJdq9bjkVOlDeFtqJ
    c2fJnTFG3D3fhPXr/GNmicakqb1ONUVw+B3ppqOiwVo8bZbSwdBCdT0vuNo4UCqHbLCr
    QuwMYShA3XwmZVi1/ylZt4wv6JB7nqOoYNPPhDahCpsGtw9niW8bP5PkxzTorbtjIWV7
    2J3nyh1m65GJNtmUjrWLFGRv2qFgX4Ca2jpzW60dbAq1fxzumWTL9O1Mn0plJBHDUQwX
    0dIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882450;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=siknNDG2uKaEvvTfUJ5bu54jWmwU/odjQQwWHyNERXc=;
    b=EV9v3mvzvNZ+VjzbDn5g0HHFsuBSDFt1L2hMLmr2rObhKlf2NZ8d33mJEpU0K7Jn2T
    EqARWW4VYANn+ZOY40AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8eorWy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:50 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/8] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
Date: Fri, 24 Jul 2026 10:40:42 +0200
Message-ID: <20260724084042.12984-9-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072018-exquisite-pouch-b739@gregkh>
References: <2026072018-exquisite-pouch-b739@gregkh>
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
index 51eade0..ab2eef3 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -116,6 +116,7 @@ struct bcm_op {
 	struct hrtimer timer, thrtimer;
 	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
 	int rx_ifindex;
+	int if_detected; /* first received ifindex in ANYDEV rx_op mode */
 	int cfsiz;
 	u32 count;
 	u32 nframes;
@@ -790,6 +791,33 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			return;
 	}
 
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
 
@@ -824,10 +852,9 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			traffic_flags |= RX_OWN;
 	}
 
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
@@ -1363,6 +1390,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
 			op->kt_lastmsg = 0;
+			op->if_detected = 0; /* reclaim ifindex in ANYDEV mode */
 		}
 		spin_unlock_bh(&op->bcm_rx_update_lock);
 
@@ -1766,10 +1794,21 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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


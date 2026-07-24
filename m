Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F23BCD23
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882298; cv=pass; b=IVKstlwM+lhsdb/GfOtqNsWKv7HRxK/pFwuwJaa2ZQNYQI+zn0kjxP5/rhkfJL6sKffgOC5bSRGF3i0x+1Cj1Y+Pd+vUZmvYiWe2avej9/LObrzC19OnJRKR3hxSjm+Hsumna8nBSCc+KHVZIGeJGeGBDMqsIXRZP7kCpoqI2PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882298; c=relaxed/simple;
	bh=J0Nm0BnIoq3Kxb7VmDO8ZfTTdCZ4BeiJh1f7DsoSBSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlcoyXbbIHATf36KBhwVhgXMBlR8VbtXiLjtNLpkxey0k5FEaBPqt5MW9xN2lCNWzijeYTKEr29NlBvkmX/TIJ1zM4Uvp+mRtCs85fAKD/itRkEGDYZrnII2vzMNvLxQYUZNDk7NyLpb5rWlZnmCxs4fUejqOgNAuZfQQ+WQGPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=EIkmifdR; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TDtp8t23; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EIkmifdR";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TDtp8t23"
ARC-Seal: i=1; a=rsa-sha256; t=1784882288; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sZt8RUUMxkD7mpfbjsJBAXyX+30RZj0+5bao8bkscS8SfvGS8Ip1KQIAW4F17kuz+B
    DwOnG7djFl3ljoWtIe19X1KJjUzcweMnZjdDx1gRnd0W0BQC131zq+3ytmycAhBWQBTM
    UC9awRgfCdqmu775x9V4FX9Gh8HDosETdbgHtGDQdAQ+KpCwVIQMF1MrknFvv2xqklNJ
    VlzRNAg0tMR3/M0LsO2gK7VMlyJc63PhSUtwH3CBe9I4U/vLvweXb7CkwbzB+Nt1yxf1
    kfOXlON+4qIGPQrc8DJqZlMDCwk1j6KS0BuLLSaLwErvRpqjPLNeFKjsezZj80PVXkEP
    qv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882288;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FTWYY8opcNT/Rt6K7f7Mx/+XUi8TuzksODXblWjKZC8=;
    b=fLH2QBkR1arM8WEd8DC69aSp0XmZM6SKnsSoa/XOQudlSTM4NyovW1Cqk62OHKtoTq
    7c4Hs0bTcRDJH+5HBfuH+bxr2R6+58ikzZaWqYP0Ek1XB10zfnpL8pypJhLHL8PfTSWe
    1MSfU/67umIFV2/sJeKKkMzZu5/PuQuIV6EvTKPVrZAhzNR0x4PQ/1vgsEf2+O3pLstJ
    XW+khmlxUlMmbvoq42bfKTwSCtBEdniaicN8HkcRWM2DmcdfKSq7vGv3WZZqPWQC+ghW
    AbTr2b/J/lfyuvbnkmp6meA20xICt6NpALiFG8TE2X9pi2hsKvnkGrEN0e8rOHAJvd5l
    o95g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882288;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FTWYY8opcNT/Rt6K7f7Mx/+XUi8TuzksODXblWjKZC8=;
    b=EIkmifdRzRMb8Lf0i1inewRTy/M6iTStLxGdXqD3XekZNKj/Jjbw/N34QFg3GWJVhC
    YSDuMq9Wt51QBP897P7JyrC5/1VDUAf+PyXpNam2qbltjMljj7KTpp/Zd+Ovgtcf/4qu
    8PERTeUR56FckPwVQxZztfK+tkoOszbt7EKXj/mbHKDs8253npOhTA6LI2OVr0EYU3bR
    c7VRkgZOsFWg0gc6hy+6akpsYP657om/v6o09AZJxm+9j1kELbjho5e04/Eq+enLnNHz
    fU82pSpOpSPPMS+6hoQ8qMXnZ/RTbrwU6gwdDqHHNwjPXukuDGxKpnuOnSKrWicLhLnC
    UxJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882288;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FTWYY8opcNT/Rt6K7f7Mx/+XUi8TuzksODXblWjKZC8=;
    b=TDtp8t2302hUyYv5/3Wh8FgBK4xN/vbHFVzYQR5t02aB9FFnFEcp4Gyd14AkKpHL/w
    7ALV69OStVpyQjzmV1AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8c8rQ9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:38:08 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 9/9] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
Date: Fri, 24 Jul 2026 10:37:56 +0200
Message-ID: <20260724083756.12430-10-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072020-crepe-unworldly-1d53@gregkh>
References: <2026072020-crepe-unworldly-1d53@gregkh>
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
index 0db9c48..8b739fa 100644
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


Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FF3CD8BF
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882585; cv=pass; b=YIkS4GBygx3K27t2tYkw0hA+McY1S6r9d+hILEPcaqQJ6UA61ILNeRHe1IsrvLECgzZx0iqG75McI8/yUA4+m0FRwJYiC7ydbJA04Zq4mZYrBPXCn5yOht0engQLKFyqkR4/olm8IdWyUYrXWWIrLhx2h4pP0QjJaEokHpm+o/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882585; c=relaxed/simple;
	bh=XdbnZh2lZeXpezQcw70YrgHTAnXzI3lbYbbfRtscG+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bs/vdYk8cHCecj1INpUVqtAXCD4DsIfpye26HjWJELZK0uXlquCJS/HO2Jng9932aaSqAiSx1J1I21e/SxcDPB/pDWcGYrzNXQJ8MhQtsoaFlSO1Ya0/eH8wDkB07ox59fNtvDv+xYLhxjrHhC3aLFvtnqpFX1vh+ZemTw5ywZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jTxHF0JC; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KC/jGlv+; arc=pass smtp.client-ip=81.169.146.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jTxHF0JC";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KC/jGlv+"
ARC-Seal: i=1; a=rsa-sha256; t=1784882403; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=buhK4atKI313OAXU1zYFziSwoeDBpqGgguRXqLAV2PRItb+W0Fjpvvn1FrwUE1JUOZ
    4a6sp6DFunhTOnOAYC4TV4Fm7SLug9FmKb8AZuhXF89WfEhcCXHu3ZlbZ2Reg2LNnj4v
    c+x1dmWmHHHF3pkRWA5ttkR26IEp+ImBo1BLIZcfuv1avIe28/UC/nHscJo1G7Qu9IF9
    CWxsKdx0xRfyY7bgJbAXw6XbRHdEZFAZ+iOS7lQgD18gVw7/2k8mp7xPER/MdOe/7DRV
    AKYuV04mdwuMi0U3RJ2499XJ9nB7yuir4l/QZTYApPl2huhZB8Jln9A4pQ2QNmyr9MsI
    b7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882403;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=E3pY/ED8Y4uw3IKFpnPJhjaEs1J3AQfp0FFXWZxRpb4=;
    b=LKVVTfaxM1nGCYi8QjTr/XV9rhrARXANBxbOQH6oPjJGf4R9+eShsHZ1t/7yS7ytBf
    a212LyGyimSnSbAzU/1LwdoQwNaIyJiRBu7acbvJUpQi9OUJNlK+Qrhf0p5f75LFiL1K
    sgNfqbQ7tdJzkIh0Audjv0zl/9llregy2ZZPYNQQ2L231hJJRpeb8Q4hASxETMUgaf4/
    9usfYdzX/WCvF60+VrSYaxSwQa35aT1iYT0X9KBvRFNKONCgSo3h7KYYhjGrraokrpxD
    v/TiDTc9Ge0f0m0BuIa8W/2MIE2Xxoi+sBD+zxoKXUafOry+zYnPFTfr/Gq/yZFauukE
    iYCg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882403;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=E3pY/ED8Y4uw3IKFpnPJhjaEs1J3AQfp0FFXWZxRpb4=;
    b=jTxHF0JC7UdisMw7oqzA7tYqnj/rl++GetWVj9vMm/st2LaKdCMRynS6JPoB6PF3Nk
    bGclZo2jtlBXm6EeTYzNu9fFAGOCpKzUSgDafYZU6zi2JLMG8cMMDeuK4m5kdzrs+yKc
    HxOAqa2IoLICKqraMnrR9nGI+mOUbHGQDWhy1lzTKYusBPXOBi8jXkraosN8yC2PFRZq
    UwwFRYEvqnhY487UtpeDrVaYrFPXAQ95ghQq6bLfGf3mtwnwYi+KwGYg+4Mgjeiq63UN
    dkkX4Yyqx61udFBI9INJhXYTh0o5NQKu/EV4rVREiUUS2cM2goXXFg++gpTNmDwE3ewU
    Xl+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882403;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=E3pY/ED8Y4uw3IKFpnPJhjaEs1J3AQfp0FFXWZxRpb4=;
    b=KC/jGlv+vZAF2ExidpmM3bN734xWLAdGVZ9NrvJ4S5wXryLY0+YMl0akvfCwZWTTmf
    R1+/GHl5jolgyEqpD0Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8e2rVH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:02 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/8] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
Date: Fri, 24 Jul 2026 10:39:54 +0200
Message-ID: <20260724083954.12817-9-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072019-shudder-calorie-6697@gregkh>
References: <2026072019-shudder-calorie-6697@gregkh>
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
index d317531..8511ffb 100644
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
@@ -758,6 +759,33 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
 
@@ -784,10 +812,9 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
@@ -1321,6 +1348,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
 			op->kt_lastmsg = 0;
+			op->if_detected = 0; /* reclaim ifindex in ANYDEV mode */
 		}
 		spin_unlock_bh(&op->bcm_rx_update_lock);
 
@@ -1724,10 +1752,21 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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


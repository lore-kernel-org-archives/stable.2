Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756013C4B72
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882347; cv=pass; b=ffGn1T9Y4gi9NpHjloMDGY9or7OiGxUOJN2uLIMbINqtGNq1psUs51nRgDf/qcZRlTBbmfVkC8lRv/XgCbIZS7Buo1ZbV/oKcp3T7es5pnB4daQOL1jrF2N9hhA9q6UOGpVXL1uGmpsbSupFQuKQSHzkUv3cIc3pzhw7LCKTYjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882347; c=relaxed/simple;
	bh=JopE5qkTN77wZlAGa8TIsYPu5UxD0m4dC2KmR1GBjrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idmGFMKCrKqBHlQfUIKsFonGSl0wC8VaFoCndYkXebXpL5wSK2J6p6pynceUKYC528kaQYlQ5/t3LCVVdr/gEUv2Dvv80E1EkiGY0HZTjvr+HsgIkZdg/JsKFtBrjHil4bg1UbZ39QsNEw4SOF4kRYCCBszl0MCP8l9SipfSw/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eGhjxFT0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YhVIKF+v; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eGhjxFT0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YhVIKF+v"
ARC-Seal: i=1; a=rsa-sha256; t=1784882343; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=amgKWbPfHPUbKuJH6p5HqAdOQPuuW8Lq1pT82udWldlU7u/PrxIk/gclG0BDLxOE/v
    vGBi590Qmt63rq5ZfI7GvzvhTx0kr5K0RXdNXIzsl1jjLSevqZisRCqeGpnb7ufRHgX/
    lwXPLlkEAPpK+Fq+F00DNOMnFl/9sCOQdXiGh/Yhaz0nfsgsnuGgYnmcz1ZagIrDiY8v
    up0uFTlf0xViFbzF2zF8nBov8OnRL/qtTejTGobvv7okmLdQ1i1bqnT3+AMQ8+uQ5jTy
    WkXjzUE3g86atBnwSoEdjVfC0fCl8fHaQsoIsYFxkOHC1w/ydfWXTlxtAxMX+JX/6Z7+
    zmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882343;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OksWpQuDeUvy07osKq/UCKTPf6yA/FLSHbORA/5s91E=;
    b=LbnZz3Gyvar7mVOHGunqae7BNVxU7dRqObpNzDh+zNwflBhnWgosSr8IuRWzqYpc55
    NIbY5LE5dchUsn52h+zZsusbQySa8r5Llygyv2jSxx7pAc/9OgrGm56PBTKgQrDzH+NY
    KrAimBEJEvZkb5E/elC8t/lnfxv1kN0hjn5YjOtObjktiCFvZBx3aYXFpRHWOtJCqzSJ
    ckUTiCLVVXDcVD46Nt9a5jlNvck60znEcm/+OWJ/+HippJeWwcee2Ns0rUzpRsXem+K/
    HoIN+kHt4sFJpv3LOifOC8E88y4SrZTighdPEkKaPz11fNuL0eQt1lJboige53N8ZaoZ
    mhcw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882343;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OksWpQuDeUvy07osKq/UCKTPf6yA/FLSHbORA/5s91E=;
    b=eGhjxFT04/Y8zWjYFPFFyKaIfiVNJMTfuFOmD7qHPJWGQfJokPGqHGgYy7L265s1Fa
    u1gS0qtlFhaDmrfkVVvhtgkHForbJbUiLC5SsfXHYSvwBVBjdQkZQp90YqsbsnCexAf+
    c0tUjViyV+EJiM/+VnJ7Z9n0OHdi99dzJ6u9HR4dY/7nAYjZXXXwA5OyzVOW7JdofXoi
    u66YtrJlI7Tvde8mQ0nfy50HL5TswQO/Pr5r+mSXGcmlE6U6l3Qt66l9v4xTgFmGpue5
    JlW9ki8lLcUHpVz1nziRSRMnwdn0mpB78I0asDxXG5fVElLJMWcDIXtFzcBxu5BQWLJq
    SMcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882343;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OksWpQuDeUvy07osKq/UCKTPf6yA/FLSHbORA/5s91E=;
    b=YhVIKF+v7B5SUECJGMuh4KcO6Gpb8xncpDdrOJkeZE0cLf70ROTc4Quu2QnJHQN1bP
    C5P5FC2VSJwwSB49rQAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8d2rT7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:39:02 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/8] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
Date: Fri, 24 Jul 2026 10:38:51 +0200
Message-ID: <20260724083851.12603-9-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072019-parched-village-5f94@gregkh>
References: <2026072019-parched-village-5f94@gregkh>
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
index 42440e3..be455be 100644
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


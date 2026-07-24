Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05994248C9
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888774; cv=pass; b=IQqfLdqBF6uc2Q6EKeXS5H22w3NSgsroFlUqaue0ho3Dtt3hfxGCli2uT+RPQ6ixtapLaBzjUPTJfxlmbdsKkwtny6UnZND2+42U2CM0wHVb4xO20Bz7jsQSUzKeAylLbu7niU+JKqSWMV+cpSHyPiyR1UbMFTmaJI4wXPvcao0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888774; c=relaxed/simple;
	bh=2rLAWQri+3QKdSPAllCIrU2beGxN7SchfOZDVCf1Jg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEQl9t4nzz/3pudF/LaYhkYlsVqWU3f56gZSX+lqFnphj/vrehSZRGw/X9kYoMkfZ7zKUrpko5HcvH2auNqwfC8fvrOoMv5xs9InMci9rK5XkuI1YNIQ++rdLJLj8suqQO0g4uJQvc3Y1CC56crtz3k6NtihdP5RZOR43OC1vDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VxD1lxeU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mMkFm0ob; arc=pass smtp.client-ip=85.215.255.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VxD1lxeU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mMkFm0ob"
ARC-Seal: i=1; a=rsa-sha256; t=1784888768; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EvfLADUlOncuPpcWag0wQu5yh7yqnv9IckP0Drjkved8zjxJzga0IXlSYrq9r87jeZ
    BZgzboHDDwD9Mxx3bhw720tdWjKNg9y7JbLFFTKyFMvwP7fuZf2UzajeUYC/RyCNB6H2
    WNFbEIwj+afcftjdmb/xSQcpItBZzSX9uFQ8c3Xk4OWq5EAlaKTL9jRoG9jQNFLZ+Yhf
    cSdwnyP/IX+z1Gjbymu/1b0QEYesepSI3RVicPYdYYiYqt8riwrZQQjCXKLw1U9oZ/0W
    KF725dL59SI5O8az5TreNbSNkz47cwKQ8I/c7MTa3urDFXQIPOUDwMaBjMLE2yy2pSUP
    btEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888768;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WENBExdGgXH0Y8EG7CtE8QwByCeIgwV0MfpisqvHjVs=;
    b=C46By/WGWHtxVe10F+69Rvcu5GBBKNfezQTqOf2TB0x/QUTJp5Tt7sZbXWqUV8ZPgo
    1KQ6LAEd49R6gof+Ouru+OEahy5SkjSccnh+6bWXTqDpp/LLgQPf4ZbleNz8ObcG15Sv
    OHklXJW0KESALaZGdpoxLT2f6oXIRHGh8JiINEKEdOA3AY5CzYv2FT/BVvTlS32ZACNz
    4pjL8onSykUFdT2c9ieKJ6BNLvmKAvvr6yEGD26qO3BALM+K/Ixppk2lKxv2SWzC8hTc
    MAe1y1IJZ0TATguDoFJu29TlZLVlmbbh6mQaOJxuwm3ulfa2ygmC9XKW/DSJvTSJQPEX
    MjOw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888768;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WENBExdGgXH0Y8EG7CtE8QwByCeIgwV0MfpisqvHjVs=;
    b=VxD1lxeUajOazHHaAUSe3ZozyrOVg3Pvf42IqI7buiPjrbI0trQV6k1yenoyFSscbT
    6rmSn6Vwt7SIObCxANp9/gCjx25Wmhlbk4PJ1jv7n505NiejgiLFge1BKFcdss8B4FLK
    jrA68zrQHASYRneoWOdTGO/RPDLouqR24GSnhXzZWO889gbU6l0ycGM1l4vb8TvWqpek
    5yyPAoVtEcUzh35XklN/R5/bbABfU+JbXMQgRqAM9wsUXGMk1FBuj3nUcicbRfUTtU/7
    0GssbkTZoUUV/3/MXxHFBUWtQSRiryMBpBp4PVzxi5chVKYHxbbFoM2OKYSOHR59NgYA
    ufBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888768;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WENBExdGgXH0Y8EG7CtE8QwByCeIgwV0MfpisqvHjVs=;
    b=mMkFm0obcVtQvYEjen0nbnOLljde33m0vNtVT+JNzOvqfAvqM9C+RSJysRZdrkx0iH
    FrJ6MQ0z7RqaQyP+tbBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAQ7tJQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:26:07 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.18.y 8/8] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
Date: Fri, 24 Jul 2026 12:25:58 +0200
Message-ID: <20260724102558.17056-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102558.17056-1-socketcan@hartkopp.net>
References: <2026072010-winner-hurried-07df@gregkh>
 <20260724102558.17056-1-socketcan@hartkopp.net>
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
index ef9eafb..455eecb 100644
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
@@ -791,6 +792,33 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
 
@@ -825,10 +853,9 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
 
@@ -1763,10 +1791,21 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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


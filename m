Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6F42049E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888669; cv=pass; b=J1Qt0vuyMeX/NJ6Lup2qOMxmOSeFeTrmihLqZ3Dd7uwB7ffCNTgbqtgVWeZebnsgwypZJjTzgfCcbiwGks7yLzhzF/NX7Hn5QbJbY0GElTewkSHE2ZtvxC8Dxo7A4dUk+Armc7s2uPadsbMsY5IhrTnGcuXl5DF+muLQLbmDaWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888669; c=relaxed/simple;
	bh=XdbnZh2lZeXpezQcw70YrgHTAnXzI3lbYbbfRtscG+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZ1g1Qr/JEp0rZGZSIdUW6pU8K3LpkIOUvbrd8/bjVpfSfZC4e9hejE6p5xj6jJjBycRE3YVYBDc+CsCgzs3qId+EdfGTqMFJfuNCEQv9CTeVzkg7IiO7H+fBdkA4sE6RtinHnjRlwFslt0RZMze9zstdcpSYuoRzDXopLg1pME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QOZS8Ot8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ss7oeYrK; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QOZS8Ot8";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ss7oeYrK"
ARC-Seal: i=1; a=rsa-sha256; t=1784888661; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IjGyMLTW+1lQG93QnTHP0NygLo6UiZxwCLi1ttAyVeDHxwIDQPyyfX2kBmAGbGgAI5
    J5Bh4tvYlXMZcuPL/OhZAJ9PIYJ4V0/3CTk639mXFTZouoFBA2ETBWFbjFy4/xKM+At/
    EyYZBiywbfjQrU1XKCQpUOgtsbzD0fKkl2BmsAXpwCNC3U+ec/sSky0CBJ+gPoR1AY7B
    9nOLxnYJSdGZWjstQKfwZtLknkB4uW26FYmXmVz/JjWVz32o/NDJbr/4SPxmPjsCEmDN
    7AOmiwscnmd0FS59Ht82WH2O0odIBbVe6gvDZCqTQGvP7tbtGdfrcmtWGJNhhlzXK+aY
    jKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888661;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=E3pY/ED8Y4uw3IKFpnPJhjaEs1J3AQfp0FFXWZxRpb4=;
    b=DXsfipcDlBT/N9eWdCJ1RObV68R/4EKigCEdsl9vXvY6mq5u03NKf/2ljAedsmyoqM
    N1B+K1QZ2lFCZl4tqnQmboU2XGAcBoPGudg/nCb+5Ln0swaDga7a2yd8KK9/zqlsOyNf
    FUmh7rVbZvPnm0eknFUE8V7sMQZ440UNhCrFd4Z0o4NuFSw86QMbKasMW7aGsA34qW8M
    2gNKi6MsrSqsUkBcjlS4PkXDabIJ8kmq8V5feaOCTOWGaB18O4IM7GP36z5tEzxWpX9O
    +Lp4MTUf87ghBQsw5tKmV+Rfe2N8F2WkE23/ju4Hl+fLwa5C/ESh5zd6W++URyNM/y6j
    jUAA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888661;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=E3pY/ED8Y4uw3IKFpnPJhjaEs1J3AQfp0FFXWZxRpb4=;
    b=QOZS8Ot8KuRkT9bDhpwQ6MFchIW2hIH5Z5jwN1rZ1Y6AErZ50up23P4orQupuHTcPI
    2fpH5N6XcY/C4IMIfc9ZxxtoEhQfwOGxV5qoHwwaqCE3XWruG4t+eWi8YIN31tkCIJgu
    7c6Yiw4wR3eAF7I0kudJxD3CN2UpOo0MriXoR2MxKgSwIHlSzZNxwWsNGba5bWSziocL
    hcUyKTN0nMhwaT3LT5kiNIEQZ2HV2iVvBIVdnL5kSl7v2uckW6pRP8tZOn3aDlBeiVDA
    udghVq5yDFGGysL27XysmZ2ql44R+ya3+PpM/Z+VTJiU/qp/SS6orsDPF3wAfGf4Vwv0
    M57Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888661;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=E3pY/ED8Y4uw3IKFpnPJhjaEs1J3AQfp0FFXWZxRpb4=;
    b=ss7oeYrKrak3JwsKrq7l7KI3oQQzV1Iik3deRVuvdXDYpaQMVt64wbL7k1fLxkhTz3
    nPOkkCo/5N0thIzAexBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAOLtIf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:24:21 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6.y 8/8] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
Date: Fri, 24 Jul 2026 12:24:10 +0200
Message-ID: <20260724102410.16731-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102410.16731-1-socketcan@hartkopp.net>
References: <2026072011-untruth-wrongly-ed18@gregkh>
 <20260724102410.16731-1-socketcan@hartkopp.net>
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


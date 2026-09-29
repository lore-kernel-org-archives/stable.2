Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84694071E3;
	Tue, 29 Sep 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716038; cv=pass; b=bydvfj36Y6j9fvnl+aBP49VGhGwQ8WtxBbMmBUD761raDxLudcctFYiNORTJPy0Co8snFttRw+eO8mvwh3/iPwqQvF8MNAnXOB+OE76e/gDFP+z+Y5thk7yK/AbmYuvqhSdpCrag6c0RGVl4Cy0otJChAY7NrgICoYKD0vWQKP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716038; c=relaxed/simple;
	bh=EzEaFcpoiFPidHP0iYBdNkXjm3UM2+CcjSsTR4K4F10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEctP7vxoYodkCf2s5WhlcAmV+oFT8j9+JKhEQLcsqeoZfv13y9lD6wi9jhHhHEPQiAjkQ7OAjZqpBCu5IxADJPN/Qmxrct6sMZfaEKfTXlhyZy/b21/JtFhYi+ChheKkPRHA43/vsLLXbhQVRgHf9yitIySbC6s0dOB4J6UOLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=cuu4iu5y; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="cuu4iu5y"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7E070200576;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bq0/T656ezyqsLMi44k7IWeQ+XmYM+YKcRKDTvKWjPY=;
	b=cuu4iu5y7PB3/NeCBUnP18qCDXnKAbL/mq6/zuWSlLWbmYHOx2g4+Ptl0x1MVUkOQWv4rg
	50YIMjNjvM8ATkvLad0dv24HmZdc9+8g5rW7rhnrLnHBuZ3TG9CEfDXx5v0bDTaa+bGSZS
	M+m5fE1vzsPA6ooN2F1kdkN4MuL/91UVU4nBHCz8C6pbjRYQnXo2Jmn7NdQP6XaY9vKJAd
	PEzfP66fLkAF99A+sk5tUrKtY9xs++3Jes5q0vXsyGMFbE/uSCHmWbgWmllWCq03/NYQwK
	wwD2Qd+5Mc7PwGLxjFz+y9daZC4pSfn2lXdQAMd+IFXsrfGIhjiV/ktPttpkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bq0/T656ezyqsLMi44k7IWeQ+XmYM+YKcRKDTvKWjPY=;
	b=bMs4xCEIWcXMylDCVVm1NHyeIjd9VokJA22VlN/s9E+OggrQbXBWB6fOWoeSA6BzfbBM1I
	rwe0CdQ+95sS7teVkOJyhtyfc8ivOfJN+rF6G46hczvN3MXXme0DfgOq0KThNL0KEMneHx
	lpVyze+efsdThOUk3TVVwxEFbezdbalmSkmd7PVAe0HQMgZyVTrUFCMXmKVk5ljhLDoOT/
	wOsupzrLgO0lZQgOJRu1fSwzDYRg7hoCHHvYlo03O8BUJ9eW87rs9EbabTEay6AQqOXKC6
	AuQa8AF4qmFvA9ZCliJphlOvcHTcTZ0HDFJpAFm6OvIdlTFF3MIfopuPNvKBpA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=Jly+0pKSUMYVz6jlwnyW11e1Vr5ksKvee4+Y3Pkn0sNUtYRL/UOslCgcVyex7UqjrQOd/n
	Igm6nfY5PfDMiG0qMxeQuc3fVp4N8scKr7daIXDgB9ydj+tN8es04cdEc0WtNwBg9s34Sv
	mXAIE7AChkgrVsyFodG/jg4Z6i6pkb5gux/2NBXFq4kh5dyM8N1LqVbgA0WFM6m+b3N+tn
	1mq4vJX1aXIJ8NqN6ztQCxkNulwrN2NOhd7SBuAmWkJyBm4jS+E48fVAKLZMll9QAEu1Wy
	wBeLlE/IyBN4LO+zXBPBW6G8Yfn2sWK9Xj+l4Em94EOKiH/tY9eT4z7pMu0A9w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3c-16;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 116FC5B4CD3;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 03/16] can: remove CAN filters independent from namespace
Date: Tue, 29 Sep 2026 22:43:53 +0200
Message-ID: <20260929210700.1183036-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Hartkopp <socketcan@hartkopp.net>

When the devices namespace is changed the socket namespace and the device
namespace might differ. The net_eq(dev_net(dev), sock_net(sk)) check in
the CAN protocols netdev notifiers therefore led to skipping the required
removal of the CAN filters from the (namespace changed) CAN devices.

This patch removes the namespace equality check in the netdev notifiers for
BCM, ISOTP and RAW sockets. Since the struct net_device pointer is globally
unique, the notifier should always process the unregister event and remove
the CAN filters if it matches the original socket's bound device pointer.

In bcm.c netdevice comparisons were performed by checking the interface
index (bo->ifindex and op->ifindex) which is not namespace-safe either.
Introduce tracked netdevice pointers (bo->dev and op->tx_dev) for these
referenced devices to enable namespace-save device comparisons.
Additional put all bo->dev accesses in bcm_notify() under lock_sock().

In isotp.c the two missing can_rx_unregister() calling sites are converted
to use dev_net(dev) instead of sock_net(sk) to get the correct namespace.

Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
Reported-by: Norbert Szetei <norbert@doyensec.com>
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Link: https://patch.msgid.link/20260929163424.16382-2-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c   | 100 ++++++++++++++++++++++++++++++++++++------------
 net/can/isotp.c |   7 +---
 net/can/raw.c   |   3 --
 3 files changed, 78 insertions(+), 32 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..cd3522ec32c0 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -130,6 +130,8 @@ struct bcm_op {
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
 	netdevice_tracker rx_reg_dev_tracker;
+	struct net_device *tx_dev;
+	netdevice_tracker tx_dev_tracker;
 	spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
 	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
@@ -138,6 +140,8 @@ struct bcm_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
 	struct list_head notifier;
 	struct list_head rx_ops;
 	struct list_head tx_ops;
@@ -935,6 +939,9 @@ static void bcm_free_op_work(struct work_struct *work)
 	if ((op->last_frames) && (op->last_frames != &op->last_sframe))
 		kfree(op->last_frames);
 
+	if (op->tx_dev)
+		netdev_put(op->tx_dev, &op->tx_dev_tracker);
+
 	/* the last possible access to op->timer/op->thrtimer has now
 	 * happened above via hrtimer_cancel() - op->sk is no longer
 	 * needed by any pending timer callback, so drop our reference
@@ -1074,6 +1081,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 	struct canfd_frame *cf;
+	struct net_device *tx_dev;
 	bool add_op_to_list = false;
 	unsigned int i;
 	int err;
@@ -1105,6 +1113,22 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (msg_head->nframes > op->nframes)
 			return -E2BIG;
 
+		/* Re-resolve and re-hold the target device if a concurrent
+		 * NETDEV_UNREGISTER already cleared it (see bcm_notify()).
+		 * op->ifindex and sock_net(sk) is unchanged.
+		 */
+		if (!op->tx_dev) {
+			tx_dev = dev_get_by_index(sock_net(sk), ifindex);
+			if (tx_dev) {
+				op->tx_dev = tx_dev;
+				netdev_hold(tx_dev, &op->tx_dev_tracker,
+					    GFP_KERNEL);
+				dev_put(tx_dev);
+			} else {
+				return -ENODEV;
+			}
+		}
+
 		/* get new CAN frames content into a staging buffer before
 		 * locking: validate and normalize the frames there so that
 		 * bcm_can_tx() / bcm_tx_timeout_handler() never observe a
@@ -1171,6 +1195,18 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (!op)
 			return -ENOMEM;
 
+		tx_dev = dev_get_by_index(sock_net(sk), ifindex);
+		if (tx_dev) {
+			op->tx_dev = tx_dev;
+			netdev_hold(tx_dev, &op->tx_dev_tracker, GFP_KERNEL);
+			dev_put(tx_dev);
+		} else {
+			/* prepare op->frames for goto free_op */
+			op->frames = &op->sframe;
+			err = -ENODEV;
+			goto free_op;
+		}
+
 		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
 		op->cfsiz = CFSIZ(msg_head->flags);
@@ -1186,8 +1222,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 						   op->cfsiz,
 						   GFP_KERNEL);
 			if (!op->frames) {
-				kfree(op);
-				return -ENOMEM;
+				/* prepare op->frames for goto free_op */
+				op->frames = &op->sframe;
+				err = -ENOMEM;
+				goto free_op;
 			}
 		} else
 			op->frames = &op->sframe;
@@ -1269,6 +1307,9 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	return msg_head->nframes * op->cfsiz + MHSIZ;
 
 free_op:
+	if (op->tx_dev)
+		netdev_put(op->tx_dev, &op->tx_dev_tracker);
+
 	if (op->frames != &op->sframe)
 		kfree(op->frames);
 	kfree(op);
@@ -1792,15 +1833,13 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 {
 	struct sock *sk = &bo->sk;
 	struct bcm_op *op;
-	int notify_enodev = 0;
+	int sk_err = 0;
 
-	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return;
+	lock_sock(sk);
 
 	switch (msg) {
 
 	case NETDEV_UNREGISTER:
-		lock_sock(sk);
 
 		/* rx_ops: remove device specific receive entries */
 		list_for_each_entry(op, &bo->rx_ops, list) {
@@ -1810,7 +1849,7 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 			/* release an ANYDEV op's claim (see bcm_rx_handler())
 			 * on this now confirmed-gone interface.
 			 */
-			if (!op->ifindex) {
+			if (!op->ifindex && net_eq(dev_net(dev), sock_net(sk))) {
 				spin_lock_bh(&op->bcm_rx_update_lock);
 				if (op->if_detected == dev->ifindex)
 					op->if_detected = 0;
@@ -1819,15 +1858,18 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 		}
 
 		/* tx_ops: stop device specific cyclic transmissions on the
-		 * vanishing ifindex. Cancelling the timer is enough to stop
+		 * vanishing device. Cancelling the timer is enough to stop
 		 * cyclic bcm_can_tx() calls as there is no re-arming.
 		 */
 		list_for_each_entry(op, &bo->tx_ops, list)
-			if (op->ifindex == dev->ifindex)
+			if (op->tx_dev == dev) {
 				hrtimer_cancel(&op->timer);
+				netdev_put(op->tx_dev, &op->tx_dev_tracker);
+				op->tx_dev = NULL;
+			}
 
 		/* remove device reference, if this is our bound device */
-		if (bo->bound && bo->ifindex == dev->ifindex) {
+		if (bo->bound && bo->dev == dev) {
 #if IS_ENABLED(CONFIG_PROC_FS)
 			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
 				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
@@ -1841,24 +1883,23 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 			 */
 			WRITE_ONCE(bo->bound, 0);
 			bo->ifindex = 0;
-			notify_enodev = 1;
-		}
-
-		release_sock(sk);
-
-		if (notify_enodev) {
-			sk->sk_err = ENODEV;
-			if (!sock_flag(sk, SOCK_DEAD))
-				sk_error_report(sk);
+			netdev_put(bo->dev, &bo->dev_tracker);
+			bo->dev = NULL;
+			sk_err = ENODEV;
 		}
 		break;
 
 	case NETDEV_DOWN:
-		if (bo->bound && bo->ifindex == dev->ifindex) {
-			sk->sk_err = ENETDOWN;
-			if (!sock_flag(sk, SOCK_DEAD))
-				sk_error_report(sk);
-		}
+		if (bo->bound && bo->dev == dev)
+			sk_err = ENETDOWN;
+	}
+
+	release_sock(sk);
+
+	if (sk_err) {
+		sk->sk_err = sk_err;
+		if (!sock_flag(sk, SOCK_DEAD))
+			sk_error_report(sk);
 	}
 }
 
@@ -1984,6 +2025,10 @@ static int bcm_release(struct socket *sock)
 	if (bo->bound) {
 		WRITE_ONCE(bo->bound, 0);
 		bo->ifindex = 0;
+		if (bo->dev) {
+			netdev_put(bo->dev, &bo->dev_tracker);
+			bo->dev = NULL;
+		}
 	}
 
 	sock_orphan(sk);
@@ -2031,11 +2076,14 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 		}
 
 		bo->ifindex = dev->ifindex;
+		bo->dev = dev;
+		netdev_hold(dev, &bo->dev_tracker, GFP_KERNEL);
 		dev_put(dev);
 
 	} else {
 		/* no interface reference for ifindex = 0 ('any' CAN device) */
 		bo->ifindex = 0;
+		bo->dev = NULL;
 	}
 
 #if IS_ENABLED(CONFIG_PROC_FS)
@@ -2046,6 +2094,10 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 						     net->can.bcmproc_dir,
 						     bcm_proc_show, sk);
 		if (!bo->bcm_proc_read) {
+			if (bo->dev) {
+				netdev_put(bo->dev, &bo->dev_tracker);
+				bo->dev = NULL;
+			}
 			ret = -ENOMEM;
 			goto fail;
 		}
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 155530aedce2..0835a4758a72 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1492,11 +1492,11 @@ static int isotp_release(struct socket *sock)
 	 */
 	if (so->bound && so->dev) {
 		if (isotp_register_rxid(so))
-			can_rx_unregister(net, so->dev, so->rxid,
+			can_rx_unregister(dev_net(so->dev), so->dev, so->rxid,
 					  SINGLE_MASK(so->rxid),
 					  isotp_rcv, sk);
 
-		can_rx_unregister(net, so->dev, so->txid,
+		can_rx_unregister(dev_net(so->dev), so->dev, so->txid,
 				  SINGLE_MASK(so->txid),
 				  isotp_rcv_echo, sk);
 		netdev_put(so->dev, &so->dev_tracker);
@@ -1848,9 +1848,6 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 {
 	struct sock *sk = &so->sk;
 
-	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return;
-
 	if (so->dev != dev)
 		return;
 
diff --git a/net/can/raw.c b/net/can/raw.c
index 82d9c0499c95..c5596fc9aac5 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -302,9 +302,6 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 {
 	struct sock *sk = &ro->sk;
 
-	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return;
-
 	if (ro->dev != dev)
 		return;
 
-- 
2.53.0


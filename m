Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CFC4F0533;
	Mon, 28 Sep 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614811; cv=pass; b=RalblTWTKdnMLlLSpyxBigDa5M8J+vfqPAlbeFLEKZwRVrCp/EAmUorFVfbB2Szvtzqb2nmYdmn0FjH02op/2pFxRoIu3bDJnTRmMrqtePb9dGEXwnxwB5bJzk4A/GGg4grPuMEMTWNANce32rVY25dXc7zpTckIKYkDWC+vOs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614811; c=relaxed/simple;
	bh=R59KFAtskgMCpeDUJXUtTC3mWc4O99QMiIUVOgCV0sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCKEh4aFshfDiZRGtMGmiGKM8xMZqlHTzwvPdJDSkF724y075sfO1SpZOy/lzdtb9YHO67QPUc70hWOpwtgtVjVT5NBYkVE1pa3HMg7XsKk2+SSxnJB4i7JW1c8jk65+NTBQ0bofjCxs5F9RmzcrYqEkdyoWgEcGuUiVd3TQDbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Chgu7W05; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ml8QNvvp; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Chgu7W05";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ml8QNvvp"
ARC-Seal: i=1; a=rsa-sha256; t=1790614804; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DuSBwdbd3ktGU1Fxf7aMwnlKdoFScsfTqq+th+PL27ApMr5h8KH9iBb9ZGm3pGgk+l
    ujWq/eggaYsIjqYVmpmN1JBs+Exq3rlh2EHObYQQ8gtM7NR8jBLlDZiiRjlsDrOglRQF
    dknbtMnMsJVuhVqRI0S5mMcBIQmvq4WJbX54M/PpYGJ+K5VvMhJiEJ6zuA8H1UE1KSFt
    lPtxpf4j3Qb7cLm+ZKsTsOwp/x09zHsqCQjTd93jHZwtUNE93TKLaHEYDhRJ3pupoqTi
    k5rgmai98w7wndZCaD3XafAF8RvTRvX+G8+DcOEyBaman2JylTvziSB4sQ05viIlEO5X
    fEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790614804;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x41+j2MXyJI/2yK/2r7PEbT8aRSrMIBRFrrZV5PPTDk=;
    b=Iu2EgY4whys5bntAkkITcRwQCRCOCgTHs/9wcSKP8Q/Iow54J9rdPCRNQDd6AXqp4R
    XKQ6ahnwbSd4fAvvclFq04vbI4GcYzYkktEjdMe8JAZvPJhOVhu1Wl8AjganfGa4ttP8
    hqWO9S3IXpftcqQWfw+JGrCxvE77R+d1bXJRWTd2S2Y66vI8CSwccNKkET533DD/EHpK
    d1E4l7yqdIuAOPRweHzEUY1sq5c6cWQSjKk73BAFT4A/dyP5Pb+0Y+FUAJIx5sYG3mdg
    PafNpOtdpLOeAZcjaRbL8kHHn5mDiwUkxZvkohjuNEsqkn37X7/8YpWRvOaRVju/de/R
    uSqw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790614804;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x41+j2MXyJI/2yK/2r7PEbT8aRSrMIBRFrrZV5PPTDk=;
    b=Chgu7W05t9lH0rOwSe2VL30LpVOirCSxGfQugmj1WAHS9Gewvda04br7cH4P5FmO1q
    qRb7aP0KPrZeM7VLomZuElXKlttcx4k3lTa/R/dzAQUA+vo5tS13H0viEDBh7p70ZgE+
    T6b4vXkYKaFPGC71h7eQ3SlaAVWclRq+xW2s1v2iebFZl2GpTX9BgqhBAY/58JDPv9C0
    9LM63T1JueRItyY5sN89Q4NOqRQTSkyuiYA676bWpCs44GlpSiw2jifEW9ycrAdIs1Kc
    fZj10LR6RUL8lxXV8Tkmc/QEjwLNn4UJqr/g8P2OOctCrn/X7AAojueK7efDlVS3Eko2
    02iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790614804;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x41+j2MXyJI/2yK/2r7PEbT8aRSrMIBRFrrZV5PPTDk=;
    b=ml8QNvvpCoyfnUr0NR5M53b8YiSx4Kj1Qk2HXUFjgguKhnA2g1s1ceg+bjtUsDn/xR
    h82SqY+SGuXKHOaEMZBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SH03Ofh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 19:00:03 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] can: remove CAN filters independent from namespace
Date: Mon, 28 Sep 2026 18:59:25 +0200
Message-ID: <20260928165927.31667-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928165927.31667-1-socketcan@hartkopp.net>
References: <20260928165927.31667-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

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
---
 net/can/bcm.c   | 100 ++++++++++++++++++++++++++++++++++++------------
 net/can/isotp.c |   7 +---
 net/can/raw.c   |   3 --
 3 files changed, 78 insertions(+), 32 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..cd3522ec32c0 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -128,18 +128,22 @@ struct bcm_op {
 	struct canfd_frame sframe;
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
 	netdevice_tracker rx_reg_dev_tracker;
+	struct net_device *tx_dev;
+	netdevice_tracker tx_dev_tracker;
 	spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
 	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
 
 struct bcm_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
 	struct list_head notifier;
 	struct list_head rx_ops;
 	struct list_head tx_ops;
 	unsigned long dropped_usr_msgs;
 	struct proc_dir_entry *bcm_proc_read;
@@ -933,10 +937,13 @@ static void bcm_free_op_work(struct work_struct *work)
 		kfree(op->frames);
 
 	if ((op->last_frames) && (op->last_frames != &op->last_sframe))
 		kfree(op->last_frames);
 
+	if (op->tx_dev)
+		netdev_put(op->tx_dev, &op->tx_dev_tracker);
+
 	/* the last possible access to op->timer/op->thrtimer has now
 	 * happened above via hrtimer_cancel() - op->sk is no longer
 	 * needed by any pending timer callback, so drop our reference
 	 */
 	sock_put(op->sk);
@@ -1072,10 +1079,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			int ifindex, struct sock *sk)
 {
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 	struct canfd_frame *cf;
+	struct net_device *tx_dev;
 	bool add_op_to_list = false;
 	unsigned int i;
 	int err;
 
 	/* we need a real device to send frames */
@@ -1103,10 +1111,26 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		 * therefore (complexity / locking) it is not supported.
 		 */
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
 		 * partially updated or unvalidated frame in op->frames
 		 */
@@ -1169,10 +1193,22 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		op = kzalloc(OPSIZ, GFP_KERNEL);
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
 		op->flags = msg_head->flags;
 		op->nframes = msg_head->nframes;
@@ -1184,12 +1220,14 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (msg_head->nframes > 1) {
 			op->frames = kmalloc_array(msg_head->nframes,
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
 
 		for (i = 0; i < msg_head->nframes; i++) {
@@ -1267,10 +1305,13 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		bcm_tx_start_timer(op);
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
 
 free_op:
+	if (op->tx_dev)
+		netdev_put(op->tx_dev, &op->tx_dev_tracker);
+
 	if (op->frames != &op->sframe)
 		kfree(op->frames);
 	kfree(op);
 	return err;
 }
@@ -1790,46 +1831,47 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 		       struct net_device *dev)
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
 			if (op->rx_reg_dev == dev)
 				bcm_rx_unreg(dev, op);
 
 			/* release an ANYDEV op's claim (see bcm_rx_handler())
 			 * on this now confirmed-gone interface.
 			 */
-			if (!op->ifindex) {
+			if (!op->ifindex && net_eq(dev_net(dev), sock_net(sk))) {
 				spin_lock_bh(&op->bcm_rx_update_lock);
 				if (op->if_detected == dev->ifindex)
 					op->if_detected = 0;
 				spin_unlock_bh(&op->bcm_rx_update_lock);
 			}
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
 				bo->bcm_proc_read = NULL;
 			}
@@ -1839,28 +1881,27 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 			 * accessed under lock_sock() so it needs no
 			 * annotation.
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
 
 static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 			void *ptr)
@@ -1982,10 +2023,14 @@ static int bcm_release(struct socket *sock)
 
 	/* remove device reference */
 	if (bo->bound) {
 		WRITE_ONCE(bo->bound, 0);
 		bo->ifindex = 0;
+		if (bo->dev) {
+			netdev_put(bo->dev, &bo->dev_tracker);
+			bo->dev = NULL;
+		}
 	}
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -2029,25 +2074,32 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 			ret = -ENODEV;
 			goto fail;
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
 	if (net->can.bcmproc_dir) {
 		/* unique socket address as filename */
 		sprintf(bo->procname, "%llu", sock_i_ino(sk));
 		bo->bcm_proc_read = proc_create_net_single(bo->procname, 0644,
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
 	}
 #endif /* CONFIG_PROC_FS */
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 155530aedce2..0835a4758a72 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1490,15 +1490,15 @@ static int isotp_release(struct socket *sock)
 	/* remove current filters & unregister
 	 * tracked reference so->dev is taken at bind() time with rtnl_lock
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
 	}
 
@@ -1846,13 +1846,10 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
 static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 			 struct net_device *dev)
 {
 	struct sock *sk = &so->sk;
 
-	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return;
-
 	if (so->dev != dev)
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
diff --git a/net/can/raw.c b/net/can/raw.c
index 82d9c0499c95..c5596fc9aac5 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -300,13 +300,10 @@ static int raw_enable_allfilters(struct net *net, struct net_device *dev,
 static void raw_notify(struct raw_sock *ro, unsigned long msg,
 		       struct net_device *dev)
 {
 	struct sock *sk = &ro->sk;
 
-	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return;
-
 	if (ro->dev != dev)
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
-- 
2.53.0


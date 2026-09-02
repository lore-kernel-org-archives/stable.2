Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006A4A4825;
	Wed,  2 Sep 2026 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373782; cv=pass; b=k90sLJT05PaLyONlXy/3OXe7p4JfXZW56OrsBi4dwn6y8nPnq1aldV61QUO7C4cfEUqLpIWuQi7u3CDEbubBCp48JHGGh/HTF0wYL1DJGc+d35/wc+cpvOZ9cVikb8NkPloKvRR5PHj63pEp/pCPwOgl4kNCR+0MZSXIhjDBYkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373782; c=relaxed/simple;
	bh=0gf50Ie11pYcibMsDu1FYVOo3r71hv2wEzHyXFD5d2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gUECs8SKn+D52WHBt2I78jR8cqrUQ0jAkO1u8HBT1lAkWSsG5gt2FaNbHTFkdlB699VbXP9k8Z0DQOd2l93ETGU+ITkfWKnBvWDH+9qTQn2chBunLNqfLuw6DcVyDfRP40mdCKGtdTlaOXF+x32e5O24LXrw4Bp6y375VUe9kUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pGVDO4/j; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jl59Pgeb; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pGVDO4/j";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jl59Pgeb"
ARC-Seal: i=1; a=rsa-sha256; t=1788373771; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=R4/RiUdvshLLQA46laXHzyIU1toSJBQ6NsauAirqHtcV/NKa5GNCQ1Ut9VMrTQySUZ
    rL2yX3q7nxaMhDWoBw5VTZj8HWj04ByXQntOZqmUnX9xgQZKQ/8xWMXzpFQOgr4Fyvxc
    G2fVYzmfEEZacicNoXA1OC7JV/1ptQV0+y7cK8H1Y5cvl4Ah+ChEcOkrc1ouEu/AZw65
    Qlor5MVTfiscmpGPOYcAfSnwlgXdTgjYv2U4XveEdh61OKWeHzRyyxng16MpdHLMSWSH
    h6SnaK79/AUJbt2i4kid7ycWUCtxe781RZ5/WiefTy8Yaq4X3Gy8UawdBtmLcdemhDUD
    oPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788373771;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=J182XAhFPVeK0c9Uhpuo9qkZC6iiwoP5K+jCESH9oLo=;
    b=ZLUV2NdZVeJyoGGlmATppOGszX/UKkJwr9lVoqbbX7QL32vHtbHf5Uwm3X+aNUAGwF
    UsX3ioPSkOPZSQs8ohonXACDA0HEfHufCyqVjzKkSMK/2fTZxp94C2Nk8GoFgm0hHH5g
    Uwe5H+Q7296Nfp3YoVPHxb86v5bIgmqtH+4m10r77YAGJp1SRGd89IqUO3Q05M40gUUq
    WuCFT+AOSJqa0uBWRiLhNPBWkESUSfBPRkwwbrAhYk983ww89v0n4u6qVPQBUzubBKoz
    dDRz0L6NB2ia3IyPTgRBTPt8Y7eEj5/qxmmbfqLELDpSTZr45znNGs9QqvXyaJVOB7WB
    F/IQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788373771;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=J182XAhFPVeK0c9Uhpuo9qkZC6iiwoP5K+jCESH9oLo=;
    b=pGVDO4/jBk4BRUaP0+i0P9YSsgoWvNh80EUESxjU7kqhk0U8vRQDk1e8pjhTMGBBik
    ZQkah+fdcaUsXMI2QlhB4Mxn19/4tfcnTgi1fJTOobQFA4n30sMw/3/6NtixXLKnFRLT
    W5ol2CpJyFbu9BERsAbV8vlwrvNnOzVzg4r+HUcuJvpdsUc6jr32ecpYWZMgnGtDo5ba
    a9HGo5nGTRT4sPD5IcuZ0hB9SXA2vVnKupV+c1g9UYyIqic1xxOzRsfApheESEPwNo9V
    B2cKpHdfL2y/d25h8txxLCUrncUExrP97a43Ekk5M1LvOV9scLrWsGdLtAJ3UQyvNGus
    3hWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788373771;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=J182XAhFPVeK0c9Uhpuo9qkZC6iiwoP5K+jCESH9oLo=;
    b=jl59PgebtjhpPF0/xvt8pAwoaCpzVj7H5TKmTh7q03w6JMg13guyJrB2xp1vCn54a4
    PiCx4zJCya0vFndwdxAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b7282ITVxe6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 2 Sep 2026 20:29:31 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: remove CAN filters independent from namespace
Date: Wed,  2 Sep 2026 20:29:15 +0200
Message-ID: <20260902182915.19486-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
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

In isotp.c the two missing can_rx_unregister() calling sites are converted
to use dev_net(dev) instead of sock_net(sk) to get the correct namespace.

Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
Reported-by: Norbert Szetei <norbert@doyensec.com>
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c   | 52 ++++++++++++++++++++++++++++++++++++++++++-------
 net/can/isotp.c |  7 ++-----
 net/can/raw.c   |  3 ---
 3 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..42851d37cc9a 100644
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
@@ -1103,10 +1111,25 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		 * therefore (complexity / locking) it is not supported.
 		 */
 		if (msg_head->nframes > op->nframes)
 			return -E2BIG;
 
+		/* Re-resolve and re-hold the target device if a concurrent
+		 * NETDEV_UNREGISTER already cleared it (see bcm_notify()).
+		 * op->ifindex is unchanged - bcm_find_op() above only
+		 * matches ops with this exact ifindex.
+		 */
+		if (!op->tx_dev) {
+			tx_dev = dev_get_by_index(sock_net(sk), ifindex);
+			if (tx_dev) {
+				op->tx_dev = tx_dev;
+				netdev_hold(tx_dev, &op->tx_dev_tracker,
+					    GFP_KERNEL);
+				dev_put(tx_dev);
+			}
+		}
+
 		/* get new CAN frames content into a staging buffer before
 		 * locking: validate and normalize the frames there so that
 		 * bcm_can_tx() / bcm_tx_timeout_handler() never observe a
 		 * partially updated or unvalidated frame in op->frames
 		 */
@@ -1221,10 +1244,16 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
 		op->sk = sk;
 		sock_hold(sk);
 		op->ifindex = ifindex;
+		tx_dev = dev_get_by_index(sock_net(sk), ifindex);
+		if (tx_dev) {
+			op->tx_dev = tx_dev;
+			netdev_hold(tx_dev, &op->tx_dev_tracker, GFP_KERNEL);
+			dev_put(tx_dev);
+		}
 
 		/* initialize uninitialized (kzalloc) structure */
 		hrtimer_setup(&op->timer, bcm_tx_timeout_handler, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 
@@ -1792,13 +1821,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 {
 	struct sock *sk = &bo->sk;
 	struct bcm_op *op;
 	int notify_enodev = 0;
 
-	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return;
-
 	switch (msg) {
 
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 
@@ -1817,19 +1843,22 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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
@@ -1839,10 +1868,12 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 			 * accessed under lock_sock() so it needs no
 			 * annotation.
 			 */
 			WRITE_ONCE(bo->bound, 0);
 			bo->ifindex = 0;
+			netdev_put(bo->dev, &bo->dev_tracker);
+			bo->dev = NULL;
 			notify_enodev = 1;
 		}
 
 		release_sock(sk);
 
@@ -1852,11 +1883,11 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 				sk_error_report(sk);
 		}
 		break;
 
 	case NETDEV_DOWN:
-		if (bo->bound && bo->ifindex == dev->ifindex) {
+		if (bo->bound && bo->dev == dev) {
 			sk->sk_err = ENETDOWN;
 			if (!sock_flag(sk, SOCK_DEAD))
 				sk_error_report(sk);
 		}
 	}
@@ -1982,10 +2013,14 @@ static int bcm_release(struct socket *sock)
 
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
 
@@ -2029,15 +2064,18 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
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


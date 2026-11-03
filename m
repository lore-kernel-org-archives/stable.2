Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738606;
	b=F/BwhZeE9mQK2qyU2lxIBXTVwuafxsPcFc1RNAS8UMDlINzwnPmGNht1nYzSyWmhxAwi
	 QJhg/KHOVkmOHW4p+HGKCZ6TrUb9i7TMOPKn4ZuY1FXlWKNRbmPs/4QxSq6C6Jm4YYaZ3
	 dutA9YuMse26d7KXn38db8h2DRXpUduRHcHS7JmHPNO0+OfNDaCt6YBc/k0eMQnCT1vQm
	 OvX6DXBEFa89kuX9PuBcUsU1z6pf8nMQu3Y8L7K+azyAimO3o6FgQ/Bob0HHvQvrewbMI
	 HC3aQWEoiL/hGyp4eDvWMfcozwoeoE9rbaxFhMqUmzQaOhZB8EG2F1/M8rkKq7bAK0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738606;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xI576zkrlUsnPmJcKGmwa6AOJ3CR5RPHzBmjQx/KU98=;
	b=1kJPa2tzWyQElRUqQN5i+sIXSfUbpIaQOdOx56j7R3QLqH2ojTtn6fSubgVdy+3ubJ4w
	 wcp+XAGHSNWaI0Y4utiwmsI1TqpYVKMMKXRnOhRlV+mkGAxoqoWqsdCRtoLzcjyQdbPv3
	 QLX6++nhIwhs8jvSVVWRb4qM8PfbdLpyn6/JfGlcCosh73tsHjAR5r1NXwiC3VW0SxJZv
	 Xeeqzu25s8oVF5HthJVz162YzWypoom7NNOfukKeb0G/PIVDDZRUzivkfnSkAQVaFOwwq
	 zw98qflu+AhCN9h4LaoWDZ/SiYfJPXo4MXiGyAkHF8S/DmeuSvN/K12seaq2qLQH3PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LNIYKhW5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A20606A31B;
	Tue,  3 Nov 2026 20:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A20606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LNIYKhW5
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B47C1200AD1;
	Tue, 03 Nov 2026 21:43:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI576zkrlUsnPmJcKGmwa6AOJ3CR5RPHzBmjQx/KU98=;
	b=LNIYKhW5hYYWgWZkp2DvbtC5gSSQZ9pqilbZC8eyh8f1NKCvB/NVnWWW0kaob5dcy+J3yi
	CKHRDzdJWiEMdUtvE3rstBX+tDDduICwc/O1qzoJ4A1mLNn/Y22AkQahQwKnfsSIkrtS3P
	iWZiApwBOTVuzkOTQFMM795mjaKTKM93Z9TeUWX/msviRbzhj2TJ9SK5dJl+EA1ORwyktb
	QsbIDkSxlmITVcJqcokfJO/U5k5FDKwuavO/++NStkyfnl1KBZg6Fqxa+ks7gPptY62Vnr
	jFpw8/ZbhhQw6/uI1cZXXP8/BlnRcn+6qRpWGYJ3jBJFxEqc4m2vSPuhXsch1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI576zkrlUsnPmJcKGmwa6AOJ3CR5RPHzBmjQx/KU98=;
	b=FM2NRaaLDekErfGecq1B5efOq3yA57ogf0qNVS5l1Q3EUVFwR2Rmo5klhyfdKyioa+9XOl
	wqPUXQCI/EkCULqaRC77vzymYlwZ7gDbOI5W1C1cjUf5ABOSVUxTwwRfZlNHWsVb8aWaso
	NVUQ7yBICB7jYA7TWDqj/62hRl/INGsG0YW63PUn3xQx7K92PVvd+xJ3vfABm4DmEB6DRM
	VccsAtQHpdLbnJeU5O3STRCuZD/4+HV8XgNYm13IpUyDV/yY8sUaZlfpqmvLHtfTzFnDgZ
	yO7ssATRe5hzINJ2i//5uNIXmS9odMn6foICX75KuWqGj3/UGsJluaS3oBM95A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738599; a=rsa-sha256;
	cv=none;
	b=bIl6Gk15dP9lus/+LF84a8Taer8EfylalNsXbOKu/v1QOcvCWLrg5LrzkpbIZJTv2rVv01
	B9KUqu89aHHnHdrBV1HpXcCj7dewsITjk1v/BPLMyVfHi7GQziNnXLsLbp5GsrFv27ZLwU
	TNjYp+HN3iqDhTmWH88H23wHYgJXrWctoj5vAQbbm98LQG1ls8iKsL7ur7TD7abG7R/Mj3
	VVsd4AxZPwnL4Py7QNtPmlmc/APpyFCJKx9aUgz9VT1AXj/8VksHg6qGSLizDvRtZ6beA+
	OfsR/O+L1YJl9pw9G0JbWQVUTjaX3CHRQFyYccmvtgeaux6Ks2ymaVGWWT5IGw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLj-002V8g-1b;
	Tue, 03 Nov 2026 21:43:19 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0D0C95DDEC3;
	Tue, 03 Nov 2026 20:43:17 +0000 (UTC)
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
Subject: [PATCH net 08/15] can: protect the receive lists with a per-device lock
Date: Tue,  3 Nov 2026 21:30:29 +0100
Message-ID: <20261103204305.3211144-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103204305.3211144-1-mkl@pengutronix.de>
References: <20261103204305.3211144-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Hartkopp <socketcan@hartkopp.net>

The receive lists of a CAN device are located in the device's
can_ml_priv and travel with the device when it is moved to another
network namespace. But they are protected by the per-netns
rcvlists_lock. So can_rx_unregister() needs dev_net(dev) to pick the
right lock and silently returns when the passed namespace does not
match dev_net(dev) anymore.

isotp_release() and bcm_release() leave their notifier list before they
take any lock that serializes against the netdev notifier, which runs
under RTNL. When the bound device is moved to another namespace in this
window, the notifier skips the socket and the release path has to remove
the filters itself. isotp_release() passes the socket's namespace, which
does not match dev_net(dev) anymore. bcm_rx_unreg() passes dev_net(dev),
which can_rx_unregister() reads again for its check, so a namespace
change between both reads makes the check fail as well. In both cases
can_rx_unregister() silently returns. As can_rx_register() stores
rcv->sk without a reference, the remaining receivers point to the freed
socket (isotp) or the freed op (bcm):

  BUG: KASAN: use-after-free in isotp_rcv+0x1570/0x24d0
  Read of size 1 at addr ffff888118130552 by task isotp_ns_uaf/578
   can_rcv_filter+0x4af/0x8c0
   can_receive+0x28d/0x3c0
   can_rcv+0x2a9/0x310
   __netif_receive_skb_one_core+0x21a/0x260
   process_backlog+0x210/0x760

Besides this, the lists of a device are protected by the rcvlists_lock
of the namespace that is passed in. Callers which pass dev_net(dev) read
it at different times, so the same lists may be modified under the locks
of different namespaces while the device is moved.

Taking RTNL in these release paths is no option: raw_bind(),
raw_setsockopt() and raw_release() already hold RTNL while adding and
removing up to CAN_RAW_FILTER_MAX filters per socket, which unprivileged
users can trigger repeatedly and which makes RTNL a global bottleneck.

Instead fix the root cause and add a spinlock to struct
can_dev_rcv_lists, which protects the receive lists of a CAN device or
the 'any' CAN device lists of a namespace. It is initialized in
can_set_ml_priv(), which is used by all CAN network devices. With this,
can_rx_unregister() finds the subscription independently of the
current namespace of the device. The protocols keep the device valid
with their tracked references. The per-netns rcvlists_lock only protects
the receive list statistics anymore, and CAN_RAW, CAN_BCM and CAN_ISOTP
pass the namespace that has been used for can_rx_register().

So isotp_release() and bcm_release() now remove their filters correctly
without RTNL, and raw_release(), raw_setsockopt(), raw_bind() and
isotp_bind() do not need RTNL anymore and add and remove their filters
under lock_sock(). To serialize bind() with NETDEV_UNREGISTER, bind()
publishes the device inside the RCU section of its lookup, and
raw_notify() and isotp_notify() recheck the bound device under lock_sock().
As RTNL does not keep NETDEV_DOWN out of bind() anymore, bind() checks
IFF_UP after publishing the bound device, with a barrier pair against
raw_notify() and isotp_notify(), so a down transition during bind() is
still reported with ENETDOWN.

Fixes: 20bab8b88baa ("can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER")
Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
Reported-by: Norbert Szetei <norbert@doyensec.com>
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261027-can-rx-lock-v12-3-eb5afc2d8b9b@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/can-ml.h |  3 ++
 include/net/netns/can.h    |  2 +-
 net/can/af_can.c           | 41 ++++++++++-------
 net/can/bcm.c              | 43 +++++-------------
 net/can/isotp.c            | 91 +++++++++++++++++++++++---------------
 net/can/raw.c              | 88 ++++++++++++++++++++++++++----------
 6 files changed, 162 insertions(+), 106 deletions(-)

diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
index 1e99fda2b380..cfefa4a385be 100644
--- a/include/linux/can/can-ml.h
+++ b/include/linux/can/can-ml.h
@@ -45,6 +45,7 @@
 #include <linux/can.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
+#include <linux/spinlock.h>
 
 /* exposed CAN device capabilities for network layer */
 #define CAN_CAP_CC BIT(0) /* CAN CC aka Classical CAN */
@@ -59,6 +60,7 @@
 enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
 
 struct can_dev_rcv_lists {
+	spinlock_t lock; /* protects the receive lists and entries */
 	struct hlist_head rx[RX_MAX];
 	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
 	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
@@ -81,6 +83,7 @@ static inline struct can_ml_priv *can_get_ml_priv(struct net_device *dev)
 static inline void can_set_ml_priv(struct net_device *dev,
 				   struct can_ml_priv *ml_priv)
 {
+	spin_lock_init(&ml_priv->dev_rcv_lists.lock);
 	netdev_set_ml_priv(dev, ml_priv, ML_PRIV_CAN);
 }
 
diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index 48b79f7e6236..54f23681e0d4 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -29,7 +29,7 @@ struct netns_can {
 
 	/* receive filters subscribed for 'all' CAN devices */
 	struct can_dev_rcv_lists *rx_alldev_list;
-	spinlock_t rcvlists_lock;
+	spinlock_t rcvlists_lock; /* protects the rcv_entries(_max) stats */
 	struct timer_list stattimer; /* timer for statistics update */
 	struct can_pkg_stats *pkg_stats;
 	struct can_rcv_lists_stats *rcv_lists_stats;
diff --git a/net/can/af_can.c b/net/can/af_can.c
index dc27ace43719..167b2dc40eeb 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -462,9 +462,10 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	if (!rcv)
 		return -ENOMEM;
 
-	spin_lock_bh(&net->can.rcvlists_lock);
-
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
+
+	spin_lock_bh(&dev_rcv_lists->lock);
+
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	rcv->can_id = can_id;
@@ -478,6 +479,9 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	hlist_add_head_rcu(&rcv->list, rcv_list);
 	dev_rcv_lists->entries++;
 
+	spin_unlock_bh(&dev_rcv_lists->lock);
+
+	spin_lock_bh(&net->can.rcvlists_lock);
 	rcv_lists_stats->rcv_entries++;
 	rcv_lists_stats->rcv_entries_max = max(rcv_lists_stats->rcv_entries_max,
 					       rcv_lists_stats->rcv_entries);
@@ -509,6 +513,14 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
  *
  * Description:
  *  Removes subscription entry depending on given (subscription) values.
+ *  The receive lists of a CAN device are protected by a per-device lock,
+ *  so the subscription is found even when the device has been moved to
+ *  another network namespace after can_rx_register(). The caller has to
+ *  ensure that @dev stays valid, e.g. by holding a reference to @dev or
+ *  RTNL. @net should be the namespace that has been used for
+ *  can_rx_register(). It selects the 'any' CAN device lists for
+ *  @dev == NULL and is otherwise only used for the receive list
+ *  statistics, which become imprecise when another namespace is passed.
  */
 void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 		       canid_t mask, void (*func)(struct sk_buff *, void *),
@@ -522,12 +534,10 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	if (dev && !can_get_ml_priv(dev))
 		return;
 
-	if (dev && !net_eq(net, dev_net(dev)))
-		return;
-
-	spin_lock_bh(&net->can.rcvlists_lock);
-
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
+
+	spin_lock_bh(&dev_rcv_lists->lock);
+
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	/* Search the receiver list for the item to delete.  This should
@@ -547,26 +557,26 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	 * a warning here.
 	 */
 	if (!rcv) {
+		spin_unlock_bh(&dev_rcv_lists->lock);
 		pr_warn("can: receive list entry not found for dev %s, id %03X, mask %03X\n",
 			DNAME(dev), can_id, mask);
-		goto out;
+		return;
 	}
 
 	hlist_del_rcu(&rcv->list);
 	dev_rcv_lists->entries--;
 
+	spin_unlock_bh(&dev_rcv_lists->lock);
+
+	spin_lock_bh(&net->can.rcvlists_lock);
 	if (rcv_lists_stats->rcv_entries > 0)
 		rcv_lists_stats->rcv_entries--;
-
- out:
 	spin_unlock_bh(&net->can.rcvlists_lock);
 
 	/* schedule the receiver item for deletion */
-	if (rcv) {
-		if (rcv->sk)
-			sock_hold(rcv->sk);
-		call_rcu(&rcv->rcu, can_rx_delete_receiver);
-	}
+	if (rcv->sk)
+		sock_hold(rcv->sk);
+	call_rcu(&rcv->rcu, can_rx_delete_receiver);
 }
 EXPORT_SYMBOL(can_rx_unregister);
 
@@ -823,6 +833,7 @@ static int can_pernet_init(struct net *net)
 	net->can.rx_alldev_list = kzalloc_obj(*net->can.rx_alldev_list);
 	if (!net->can.rx_alldev_list)
 		goto out;
+	spin_lock_init(&net->can.rx_alldev_list->lock);
 	net->can.pkg_stats = kzalloc_obj(*net->can.pkg_stats);
 	if (!net->can.pkg_stats)
 		goto out_free_rx_alldev_list;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 60406439a13f..9288b96724da 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -964,7 +964,7 @@ static void bcm_remove_op(struct bcm_op *op)
 static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 {
 	if (op->rx_reg_dev == dev) {
-		can_rx_unregister(dev_net(dev), dev, op->can_id,
+		can_rx_unregister(sock_net(op->sk), dev, op->can_id,
 				  REGMASK(op->can_id), bcm_rx_handler, op);
 
 		/* mark as removed subscription */
@@ -990,21 +990,10 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 			/* disable automatic timer on frame reception */
 			op->flags |= RX_NO_AUTOTIMER;
 
-			/*
-			 * Don't care if we're bound or not (due to netdev
-			 * problems) can_rx_unregister() is always a save
-			 * thing to do here.
-			 */
 			if (op->ifindex) {
-				/*
-				 * Only remove subscriptions that had not
-				 * been removed due to NETDEV_UNREGISTER
-				 * in bcm_notifier()
-				 *
-				 * op->rx_reg_dev is a tracked reference taken
-				 * when the subscription was registered, so it
-				 * stays valid here even if a concurrent
-				 * NETDEV_UNREGISTER already unlisted the dev.
+				/* Only remove subscriptions that had not been
+				 * removed in bcm_notify(). op->rx_reg_dev keeps
+				 * the device's receive lists accessible.
 				 */
 				if (op->rx_reg_dev)
 					bcm_rx_unreg(op->rx_reg_dev, op);
@@ -1936,6 +1925,7 @@ static int bcm_release(struct socket *sock)
 	list_del(&bo->notifier);
 	spin_unlock(&bcm_notifier_lock);
 
+	/* bcm_notify() can not access this socket anymore */
 	lock_sock(sk);
 
 #if IS_ENABLED(CONFIG_PROC_FS)
@@ -1949,29 +1939,20 @@ static int bcm_release(struct socket *sock)
 		bcm_remove_op(op);
 	}
 
-	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
-		/*
-		 * Don't care if we're bound or not (due to netdev problems)
-		 * can_rx_unregister() is always a save thing to do here.
-		 */
+	list_for_each_entry(op, &bo->rx_ops, list) {
 		if (op->ifindex) {
-			/*
-			 * Only remove subscriptions that had not
-			 * been removed due to NETDEV_UNREGISTER
-			 * in bcm_notifier()
-			 *
-			 * op->rx_reg_dev is a tracked reference taken
-			 * when the subscription was registered, so it
-			 * stays valid here even if a concurrent
-			 * NETDEV_UNREGISTER already unlisted the device.
+			/* Only remove subscriptions that had not been removed
+			 * in bcm_notify(). op->rx_reg_dev keeps the device's
+			 * receive lists accessible.
 			 */
 			if (op->rx_reg_dev)
 				bcm_rx_unreg(op->rx_reg_dev, op);
-		} else
+		} else {
 			can_rx_unregister(net, NULL, op->can_id,
 					  REGMASK(op->can_id),
 					  bcm_rx_handler, op);
-
+		}
+		cond_resched();
 	}
 
 	synchronize_rcu();
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 28e9d22772fa..1e40825b58cb 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1132,7 +1132,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	int off;
 	int err;
 
-	if (!so->bound || READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
+	if (!READ_ONCE(so->bound) || READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
 	/* claim the socket under so->rx_lock: this serializes the claim
@@ -1177,7 +1177,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	/* so->bound is only checked once above - a wakeup may have
 	 * unbound/rebound the socket meanwhile => recheck
 	 */
-	if (!so->bound) {
+	if (!READ_ONCE(so->bound)) {
 		err = -EADDRNOTAVAIL;
 		goto err_out_drop;
 	}
@@ -1423,7 +1423,7 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
-	if (!so->bound)
+	if (!READ_ONCE(so->bound))
 		return -EADDRNOTAVAIL;
 
 	skb = skb_recv_datagram(sk, flags, &ret);
@@ -1497,11 +1497,11 @@ static int isotp_release(struct socket *sock)
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
-	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister
-	 * tracked reference so->dev is taken at bind() time with rtnl_lock
+	 * the tracked reference so->dev keeps the device's receive lists
+	 * accessible, even after a namespace change
 	 */
 	if (so->bound && so->dev) {
 		if (isotp_register_rxid(so))
@@ -1516,11 +1516,9 @@ static int isotp_release(struct socket *sock)
 	}
 
 	so->ifindex = 0;
-	so->bound = 0;
+	WRITE_ONCE(so->bound, 0);
 	so->dev = NULL;
 
-	rtnl_unlock();
-
 	/* Always wait for a grace period before touching the timers below.
 	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
 	 * filters and cleared so->bound in isotp_notify() without waiting
@@ -1587,7 +1585,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
-	rtnl_lock();
+	/* lock_sock() serializes the binding with isotp_notify() */
 	lock_sock(sk);
 
 	if (so->bound) {
@@ -1613,19 +1611,24 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 		goto out;
 	}
 
-	dev = dev_get_by_index(net, addr->can_ifindex);
-	if (!dev) {
+	/* Publish the device inside the RCU section of the lookup: When it
+	 * is unlisted concurrently, either isotp_notify() sees so->dev after
+	 * synchronize_net() or the lookup fails. Check the device before
+	 * publishing it.
+	 */
+	rcu_read_lock();
+	dev = dev_get_by_index_rcu(net, addr->can_ifindex);
+	if (!dev || !can_get_ml_priv(dev))
 		err = -ENODEV;
-		goto out;
-	}
-	if (!can_get_ml_priv(dev)) {
-		err = -ENODEV;
-		goto out_put_dev;
-	}
-	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
+	else if (READ_ONCE(dev->mtu) < so->ll.mtu)
 		err = -EINVAL;
-		goto out_put_dev;
+	if (!err) {
+		dev_hold(dev);
+		WRITE_ONCE(so->dev, dev);
 	}
+	rcu_read_unlock();
+	if (err)
+		goto out;
 
 	/* switch to new settings */
 	so->ifindex = dev->ifindex;
@@ -1652,35 +1655,39 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 		}
 	}
 
-	/* report a down device only for a successful bind() */
-	if (!(dev->flags & IFF_UP))
-		notify_enetdown = 1;
-
-	so->bound = 1;
+	WRITE_ONCE(so->bound, 1);
 
 	/* bind() ok -> hold a reference for so->dev so that isotp_release()
 	 * can safely reach the device later, even if a concurrent
 	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
 	 */
-	so->dev = dev;
 	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);
 
-out_put_dev:
-	if (err)
-		so->ifindex = 0; /* reset on failed bind() */
+	/* Either isotp_notify() sees so->dev on NETDEV_DOWN or we see the
+	 * cleared IFF_UP, pairs with isotp_notify()
+	 */
+	smp_mb();
+	if (!(READ_ONCE(dev->flags) & IFF_UP))
+		notify_enetdown = 1;
 
-	/* remove potential reference from dev_get_by_index() */
+out_put_dev:
+	/* revert so->ifindex and so->dev on failed bind() */
+	if (err) {
+		so->ifindex = 0;
+		WRITE_ONCE(so->dev, NULL);
+	}
+
+	/* remove reference from the device lookup */
 	dev_put(dev);
 out:
-	release_sock(sk);
-	rtnl_unlock();
-
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 	}
 
+	release_sock(sk);
+
 	return err;
 }
 
@@ -1876,12 +1883,21 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (so->dev != dev)
+	if (msg == NETDEV_DOWN)
+		smp_mb(); /* pairs with isotp_bind(), see raw_notify() */
+
+	/* lockless fast path, see raw_notify() */
+	if (READ_ONCE(so->dev) != dev)
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
+		if (so->dev != dev) {
+			release_sock(sk);
+			break;
+		}
+
 		/* remove current filters & unregister */
 		if (so->bound) {
 			if (isotp_register_rxid(so))
@@ -1896,16 +1912,19 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 		}
 
 		so->ifindex = 0;
-		so->bound  = 0;
-		so->dev = NULL;
-		release_sock(sk);
+		WRITE_ONCE(so->bound, 0);
+		WRITE_ONCE(so->dev, NULL);
 
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
+		release_sock(sk);
 		break;
 
 	case NETDEV_DOWN:
+		if (!READ_ONCE(so->bound))
+			break;
+
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
diff --git a/net/can/raw.c b/net/can/raw.c
index e1d741a25be3..d6517f71cade 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -85,6 +85,7 @@ struct raw_sock {
 	struct sock sk;
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
+	struct net_device *bind_dev; /* hint for raw_notify(), no reference */
 	struct list_head notifier;
 	int ifindex;
 	unsigned int bound:1;
@@ -224,6 +225,7 @@ static int raw_enable_filters(struct net *net, struct net_device *dev,
 	int i;
 
 	for (i = 0; i < count; i++) {
+		cond_resched();
 		err = can_rx_register(net, dev, filter[i].can_id,
 				      filter[i].can_mask,
 				      raw_rcv, sk, "raw", sk);
@@ -258,9 +260,11 @@ static void raw_disable_filters(struct net *net, struct net_device *dev,
 {
 	int i;
 
-	for (i = 0; i < count; i++)
+	for (i = 0; i < count; i++) {
 		can_rx_unregister(net, dev, filter[i].can_id,
 				  filter[i].can_mask, raw_rcv, sk);
+		cond_resched();
+	}
 }
 
 static inline void raw_disable_errfilter(struct net *net,
@@ -305,16 +309,31 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 		       struct net_device *dev)
 {
 	struct sock *sk = &ro->sk;
+	struct net_device *bind_dev;
 
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (ro->dev != dev)
+	if (msg == NETDEV_DOWN)
+		smp_mb(); /* IFF_UP is cleared before, pairs with raw_bind() */
+
+	/* Lockless fast path, ro->bind_dev covers a concurrent bind().
+	 * Read it before ro->dev, pairs with smp_store_release() in
+	 * raw_bind(). A stale ro->bind_dev only costs a lock_sock().
+	 */
+	bind_dev = smp_load_acquire(&ro->bind_dev);
+	if (READ_ONCE(ro->dev) != dev &&
+	    (msg != NETDEV_UNREGISTER || bind_dev != dev))
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
+		if (ro->dev != dev) {
+			release_sock(sk);
+			break;
+		}
+
 		/* remove current filters & unregister */
 		if (ro->bound) {
 			raw_disable_allfilters(dev_net(dev), dev, sk);
@@ -326,13 +345,13 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 
 		ro->ifindex = 0;
 		ro->bound = 0;
-		ro->dev = NULL;
+		WRITE_ONCE(ro->dev, NULL);
 		ro->count = 0;
-		release_sock(sk);
 
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
+		release_sock(sk);
 		break;
 
 	case NETDEV_DOWN:
@@ -381,6 +400,7 @@ static int raw_init(struct sock *sk)
 	ro->bound            = 0;
 	ro->ifindex          = 0;
 	ro->dev              = NULL;
+	ro->bind_dev         = NULL;
 
 	/* set default filter to single entry dfilter */
 	ro->dfilter.can_id   = 0;
@@ -431,13 +451,15 @@ static int raw_release(struct socket *sock)
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
-	rtnl_lock();
 	lock_sock(sk);
 
-	/* remove current filters & unregister */
+	/* remove current filters & unregister
+	 * the tracked reference ro->dev keeps the device's receive lists
+	 * accessible, even after a namespace change
+	 */
 	if (ro->bound) {
 		if (ro->dev) {
-			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
+			raw_disable_allfilters(net, ro->dev, sk);
 			netdev_put(ro->dev, &ro->dev_tracker);
 		} else {
 			raw_disable_allfilters(net, NULL, sk);
@@ -456,7 +478,6 @@ static int raw_release(struct socket *sock)
 	sock->sk = NULL;
 
 	release_sock(sk);
-	rtnl_unlock();
 
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
@@ -479,14 +500,25 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
-	rtnl_lock();
+	/* lock_sock() serializes the binding with raw_notify() */
 	lock_sock(sk);
 
 	if (ro->bound && addr->can_ifindex == ro->ifindex)
 		goto out;
 
 	if (addr->can_ifindex) {
-		dev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
+		/* Publish the device inside the RCU section of the lookup:
+		 * When it is unlisted concurrently, either raw_notify() sees
+		 * ro->bind_dev after synchronize_net() or the lookup fails.
+		 */
+		rcu_read_lock();
+		dev = dev_get_by_index_rcu(sock_net(sk), addr->can_ifindex);
+		if (dev) {
+			dev_hold(dev);
+			/* pairs with smp_load_acquire() in raw_notify() */
+			smp_store_release(&ro->bind_dev, dev);
+		}
+		rcu_read_unlock();
 		if (!dev) {
 			err = -ENODEV;
 			goto out;
@@ -496,9 +528,6 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 			goto out_put_dev;
 		}
 
-		if (!(dev->flags & IFF_UP))
-			notify_enetdown = 1;
-
 		ifindex = dev->ifindex;
 
 		/* filters set by default/setsockopt */
@@ -517,7 +546,7 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 		if (ro->bound) {
 			/* unregister old filters */
 			if (ro->dev) {
-				raw_disable_allfilters(dev_net(ro->dev),
+				raw_disable_allfilters(sock_net(sk),
 						       ro->dev, sk);
 				/* drop reference to old ro->dev */
 				netdev_put(ro->dev, &ro->dev_tracker);
@@ -528,24 +557,32 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 		ro->ifindex = ifindex;
 		ro->bound = 1;
 		/* bind() ok -> hold a reference for new ro->dev */
-		ro->dev = dev;
+		WRITE_ONCE(ro->dev, dev);
 		if (ro->dev)
 			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
+
+		if (dev) {
+			/* Either raw_notify() sees ro->dev on NETDEV_DOWN or
+			 * we see the cleared IFF_UP, pairs with raw_notify()
+			 */
+			smp_mb();
+			if (!(READ_ONCE(dev->flags) & IFF_UP))
+				notify_enetdown = 1;
+		}
 	}
 
 out_put_dev:
-	/* remove potential reference from dev_get_by_index() */
+	/* remove reference from the device lookup */
 	dev_put(dev);
 out:
-	release_sock(sk);
-	rtnl_unlock();
-
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 	}
 
+	release_sock(sk);
+
 	return err;
 }
 
@@ -599,8 +636,13 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 				return -EFAULT;
 		}
 
+		/* The reg_state check is only a shortcut: On a concurrent
+		 * unregistration or namespace change raw_notify() waits for
+		 * lock_sock() and removes the filters set here.
+		 */
 		dev = ro->dev;
-		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED) {
+		if (ro->bound && dev &&
+		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED) {
 			if (count > 1)
 				kfree(filter);
 			return -ENODEV;
@@ -648,8 +690,10 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 
 		err_mask &= CAN_ERR_MASK;
 
+		/* lockless shortcut, see CAN_RAW_FILTER */
 		dev = ro->dev;
-		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED)
+		if (ro->bound && dev &&
+		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED)
 			return -ENODEV;
 
 		/* remove current error mask */
@@ -756,13 +800,11 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
 
-	rtnl_lock();
 	lock_sock(sk);
 
 	err = raw_setsockopt_locked(sock, optname, optval, optlen);
 
 	release_sock(sk);
-	rtnl_unlock();
 
 	return err;
 }
-- 
2.53.0


Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B013D8BD;
	Sat, 17 Oct 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268584; cv=pass; b=bUCp/UeRIz/e2FHJeZ1Gg5uzzliUb9lM1vNsAL/EmNKSpw6QtaNCTDS19MNcJfgQ2NAEA/FGvKFkmDiodQu94u/iXZreuPYP/oQ0GWsJz8exSUZfvwkHjn+TqzfwqrZOnA54TEVLndi0Y5MpmHmc68TFG0A0HDryN3MvdCSOubE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268584; c=relaxed/simple;
	bh=1CxFSV5WpY4A47Gdxhs6Y8+L3yf+OKWOYmvc/GFcKoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJ3koDuqI3MY/K3PydE+c4EZ3uuekhGtb6mz1QnCEfyuD2r9HZIkeFL0hGFSqgSth9CxsqY7xjdkxJL2yKCaGXFDLjE2jfMvKuAvpYAg02pYrr8QTQWi7kuCZ6bn56L/2m8qcW9e8QY/gibDTNYZXZ1qU7FB6fXJD/gcmcfg9D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JmEE0rY6; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JphtT/1f; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JmEE0rY6";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JphtT/1f"
ARC-Seal: i=1; a=rsa-sha256; t=1792268388; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jqPBo2+wtWYXk/K6sgUdA02JqCaJ14+cwpowm8L42UrHGr4wAPLUJmr3KBDJwsJY2W
    Lb7SUUTnCJEdHgpSd8YH9FQByiWnWFJ/qsa2qKMosa0SUNXDVkyA8bGuejrIKsxMcv5c
    i2Mp80XOLy4B3rj+Rl30ST4XBthbguK1lMAM3RtsBf9K7NyUYYvXdtCEe+aQhNOPv33M
    NUQpCQqSxwZmGC/PnVXgDNrrhHsmXhYQSyfceHZzSVnGKmdp13IZX96LVQzAF4yVMUp2
    TXMI2xpDvlfIWbqFnl2PQRwHSwIBGnxiRYVOWLUHm/WlBF7o1kPw9rwjiTx3LPIwK92P
    EiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792268388;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4ejAp574kFVMXd1tvd6V3NwbZIHEtzc4q5GeYB4TYN4=;
    b=qjno6cDhW6bdt2+j1Kg++qhvRS7UypX40O1qX+dkntLadvUrcOXTfsYfG4zx5Ud/mI
    TG5H05y9l/5MlFxqzucRLXib0p8FnqRJmwdLaJibZsqZyDwIEq1fDiiaQ4DfbMeZaP1T
    BWRhgar+gTXbcVDvo1BnEdKMHBDBrphX0gvNBqLC3hjW8weIQKIIcqW2vAMn82IYmkOH
    RtrZ1xMvcs7Agx0RxAPZRwRGarFhdhXg5nLZvSVeJgRf7Z1ko/QkRSt0+szqd4rioa5X
    jJ/Pau7r1C86VWu0JbUE7xvNNfeqYy/TnLxw2asOrzf4XtAebOaPUhq6CW/UTy/zGcQZ
    xeJw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792268388;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4ejAp574kFVMXd1tvd6V3NwbZIHEtzc4q5GeYB4TYN4=;
    b=JmEE0rY6SrxQs4sM43TzRKVRuk1XnooaLFawKfj/4P9gR/2OgsHgwlQuKtcOP2B+I7
    boGvDuxrktig+mTe1JdBYz+axpUnuw+WObenq0XZjHuyO77fRbafM4k2dXuL3xkOr4q7
    ERcipVQWE7lE83iZh27/WXiOyU3aCshXW4dI6uQem0w5V8D+D+gbAvmsWXPnvOVaJWRi
    5vWCC6EyQY8aKv83/PhWEnoQb1W+0qez+iLLekOYxj+A0PP0TuKObBDetEDIw8XAXPxM
    kI2vYKBTAepsLwRVuAd4VbiJzWM1WTTl251F20gOZzvFlBP7CBaaX4HW1S2lha0KxizH
    QoVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792268388;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4ejAp574kFVMXd1tvd6V3NwbZIHEtzc4q5GeYB4TYN4=;
    b=JphtT/1fgqSnJLFi5Z23LARl4QEQjQTJ9P9HljSTgbH8bZT1B4Hm74/2lpv+8Yl37F
    HP9bFykEito48t3G0nCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29HKJmQWg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 17 Oct 2026 22:19:48 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH can-next] can: protect the receive lists with a per-device lock
Date: Sat, 17 Oct 2026 22:19:35 +0200
Message-ID: <20261017201935.399233-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The receive lists of a CAN device are located in the device's
can_ml_priv and travel with the device when it is moved to another
network namespace. But they are protected by the per-netns
rcvlists_lock. So can_rx_unregister() needs dev_net(dev) to pick the
right lock and silently returns when the passed namespace does not
match dev_net(dev) anymore.

isotp_release() and bcm_release() remove the socket from their notifier
list before they take any lock that serializes against the netdev
notifier chain, which runs under RTNL. A socket that leaves the list in
this window is skipped by isotp_notify() / bcm_notify() and has to
remove its CAN filters itself.

This fails when the bound device is moved to another network namespace
in this window: isotp_release() passes sock_net(sk) to
can_rx_unregister() and bcm_rx_unreg() reads dev_net(dev) without
holding RTNL, so can_rx_unregister() does not find the filters. As
can_rx_register() stores rcv->sk without taking a reference, the
remaining receivers point to the freed socket (isotp) or the freed op
(bcm) and travel with the device into the new namespace:

  BUG: KASAN: use-after-free in isotp_rcv+0x1570/0x24d0
  Read of size 1 at addr ffff888118130552 by task isotp_ns_uaf/578
   can_rcv_filter+0x4af/0x8c0
   can_receive+0x28d/0x3c0
   can_rcv+0x2a9/0x310
   __netif_receive_skb_one_core+0x21a/0x260
   process_backlog+0x210/0x760

raw_release() is not affected, as it removes the filters with
dev_net(ro->dev) under RTNL. But raw_release(), raw_setsockopt() and
raw_bind() hold RTNL while removing and adding up to CAN_RAW_FILTER_MAX
filters per socket. As this can be triggered repeatedly by unprivileged
users, e.g. by binding CAN_RAW sockets alternately to different CAN
devices, RTNL becomes a global bottleneck. Extending this RTNL usage to
isotp_release() and bcm_release() is therefore no option.

Instead fix the root cause and add a spinlock to struct
can_dev_rcv_lists, which protects the receive lists of a CAN device or
the 'any' CAN device lists of a namespace. can_rx_unregister() now finds
the subscription independently from the current namespace of the
device. The protocols hold a tracked reference to the device (ro->dev,
so->dev, op->rx_reg_dev), which keeps the device's receive lists
accessible. The per-netns rcvlists_lock only protects the receive list
statistics anymore. The callers pass the namespace that has been used
for can_rx_register() to keep these statistics balanced.

The lock of the CAN device receive lists is initialized in
can_set_ml_priv(), which is used by all CAN network devices to set up
their can_ml_priv.

With this, raw_release(), isotp_release(), bcm_release() and
raw_setsockopt() do not need RTNL anymore. A socket that leaves the
notifier list while its device changes the namespace removes its
filters itself, which now always works. The filters are removed under
lock_sock() only, with cond_resched() between the filters. The
existing busy-wait loops on the *_busy_notifier variables remain
unchanged.

raw_setsockopt() now reads dev->reg_state without RTNL. Use READ_ONCE()
for this check, which is only a shortcut now: When the device is
unregistered concurrently, raw_notify() waits for lock_sock() and
removes the filters that have been set by raw_setsockopt(). The filters
are copied from user space before lock_sock() is taken, so a stalled
copy can not hold lock_sock() and thereby block a concurrent
NETDEV_UNREGISTER that waits for lock_sock() under RTNL in raw_notify().

raw_bind() and isotp_bind() took RTNL to serialize the device lookup
and the binding with NETDEV_UNREGISTER, as raw_notify() and
isotp_notify() checked ro->dev and so->dev without lock_sock(). Now
raw_notify() and isotp_notify() check ro->dev and so->dev under
lock_sock() in the NETDEV_UNREGISTER case, and the device lookup in
raw_bind() and isotp_bind() is done under lock_sock() too. Both on
device unregistration and on a namespace change, unlist_netdevice() and
synchronize_net() are executed before NETDEV_UNREGISTER is sent. So
either the notifier gets lock_sock() first and a subsequent bind() can
not look up the device anymore, or bind() gets lock_sock() first and the
notifier finds the new binding afterwards and removes it. A bind() that
looked up the device just before unlist_netdevice() but takes
lock_sock() only after the notifier has run registers its filters on the
unlisted device; these are removed when netdev_wait_allrefs() rebroadcasts
NETDEV_UNREGISTER while waiting for the tracked device reference. With
this, raw_bind() and isotp_bind() do not need RTNL anymore. raw_bind()
removes the filters of the previously bound device with sock_net(sk),
which has been used for can_rx_register().

raw_notify() and isotp_notify() keep a lockless READ_ONCE() fast path
that skips sockets not bound to the vanishing device, so the notifier
(running under RTNL) only serializes against lock_sock() of the sockets
actually bound to this device, not against every CAN_RAW / CAN_ISOTP
socket in the namespace. ro->dev / so->dev are rechecked under
lock_sock() in the NETDEV_UNREGISTER case; a bind() that sets the
pointer right after the lockless check is caught by the
NETDEV_UNREGISTER rebroadcast described above.

The NETDEV_DOWN case only reports an error to the socket and keeps
checking ro->dev and so->dev locklessly. ro->dev and so->dev are read
with READ_ONCE() and written with WRITE_ONCE() where they are changed
in bind() and in the notifier. dev->flags is read with READ_ONCE() in
bind() as it is read without RTNL now.

Other users of can_rx_unregister() benefit as well: j1939 removes its
filter with dev_net(ndev). When the device has been moved to another
namespace after can_rx_register(), this picked the rcvlists_lock of the
new namespace to protect the device's receive lists. Now the receive
lists are always protected by the per-device lock. The receive list
statistics of the namespaces may still become imprecise in this case,
as before.

Measured with four CAN_RAW sockets each rebinding CAN_RAW_FILTER_MAX
(512) filters between two vcan devices for 15s, on a kernel with lockdep
and CONFIG_LOCK_STAT (which inflates the absolute numbers, so only the
comparison matters). Without this patch raw_bind() is an rtnl_mutex
contention point and the rebind rate is ~32/s; with it raw_bind() no
longer takes rtnl_mutex, the rate rises to ~99/s and the rtnl_mutex
contention from this workload disappears (rtnl_mutex contentions
1621 -> 213, rtnl_mutex.wait_lock 307 -> 0). An unrelated
ip link add/del running in parallel is no longer stalled behind the
filter churn.

Fixes: 20bab8b88baa ("can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER")
Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
Reported-by: Norbert Szetei <norbert@doyensec.com>
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/can-ml.h |   3 +
 include/net/netns/can.h    |   2 +-
 net/can/af_can.c           |  37 ++++++----
 net/can/bcm.c              |  49 +++++--------
 net/can/isotp.c            |  24 ++++---
 net/can/raw.c              | 140 ++++++++++++++++++++++++-------------
 6 files changed, 151 insertions(+), 104 deletions(-)

diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
index 1e99fda2b380..cfefa4a385be 100644
--- a/include/linux/can/can-ml.h
+++ b/include/linux/can/can-ml.h
@@ -43,10 +43,11 @@
 #define CAN_ML_H
 
 #include <linux/can.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
+#include <linux/spinlock.h>
 
 /* exposed CAN device capabilities for network layer */
 #define CAN_CAP_CC BIT(0) /* CAN CC aka Classical CAN */
 #define CAN_CAP_FD BIT(1) /* CAN FD */
 #define CAN_CAP_XL BIT(2) /* CAN XL */
@@ -57,10 +58,11 @@
 #define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
 
 enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
 
 struct can_dev_rcv_lists {
+	spinlock_t lock; /* protects the receive lists and entries */
 	struct hlist_head rx[RX_MAX];
 	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
 	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
 	int entries;
 };
@@ -79,10 +81,11 @@ static inline struct can_ml_priv *can_get_ml_priv(struct net_device *dev)
 }
 
 static inline void can_set_ml_priv(struct net_device *dev,
 				   struct can_ml_priv *ml_priv)
 {
+	spin_lock_init(&ml_priv->dev_rcv_lists.lock);
 	netdev_set_ml_priv(dev, ml_priv, ML_PRIV_CAN);
 }
 
 static inline bool can_cap_enabled(struct net_device *dev, u32 cap)
 {
diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index 48b79f7e6236..ef7aefdf7b23 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -27,11 +27,11 @@ struct netns_can {
 	struct proc_dir_entry *bcmproc_dir;
 #endif
 
 	/* receive filters subscribed for 'all' CAN devices */
 	struct can_dev_rcv_lists *rx_alldev_list;
-	spinlock_t rcvlists_lock;
+	spinlock_t rcvlists_lock; /* protects rcv_lists_stats */
 	struct timer_list stattimer; /* timer for statistics update */
 	struct can_pkg_stats *pkg_stats;
 	struct can_rcv_lists_stats *rcv_lists_stats;
 
 	/* CAN GW per-net gateway jobs */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index d97f85fc3232..e38a5df3d184 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -460,13 +460,14 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	rcv = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
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
 	rcv->mask = mask;
 	atomic_long_set(&rcv->matches, 0);
@@ -476,10 +477,13 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	rcv->sk = sk;
 
 	hlist_add_head_rcu(&rcv->list, rcv_list);
 	dev_rcv_lists->entries++;
 
+	spin_unlock_bh(&dev_rcv_lists->lock);
+
+	spin_lock_bh(&net->can.rcvlists_lock);
 	rcv_lists_stats->rcv_entries++;
 	rcv_lists_stats->rcv_entries_max = max(rcv_lists_stats->rcv_entries_max,
 					       rcv_lists_stats->rcv_entries);
 	spin_unlock_bh(&net->can.rcvlists_lock);
 
@@ -507,10 +511,16 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
  * @func: callback function on filter match
  * @data: returned parameter for callback function
  *
  * Description:
  *  Removes subscription entry depending on given (subscription) values.
+ *  The receive lists of a CAN device are protected by a per-device lock,
+ *  so the subscription is found even when the device has been moved to
+ *  another network namespace after can_rx_register(). The caller has to
+ *  ensure that @dev stays valid, e.g. by holding a reference to @dev or
+ *  RTNL. @net is the namespace that has been used for can_rx_register()
+ *  and is only used for the receive list statistics.
  */
 void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 		       canid_t mask, void (*func)(struct sk_buff *, void *),
 		       void *data)
 {
@@ -520,16 +530,14 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct can_dev_rcv_lists *dev_rcv_lists;
 
 	if (dev && !can_get_ml_priv(dev))
 		return;
 
-	if (dev && !net_eq(net, dev_net(dev)))
-		return;
+	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 
-	spin_lock_bh(&net->can.rcvlists_lock);
+	spin_lock_bh(&dev_rcv_lists->lock);
 
-	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	/* Search the receiver list for the item to delete.  This should
 	 * exist, since no receiver may be unregistered that hasn't
 	 * been registered before.
@@ -545,30 +553,30 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	 * As this case may potentially happen when closing a socket while
 	 * the notifier for removing the CAN netdev is running we just print
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
 
 static inline void deliver(struct sk_buff *skb, struct receiver *rcv)
 {
@@ -821,10 +829,11 @@ static int can_pernet_init(struct net *net)
 {
 	spin_lock_init(&net->can.rcvlists_lock);
 	net->can.rx_alldev_list = kzalloc_obj(*net->can.rx_alldev_list);
 	if (!net->can.rx_alldev_list)
 		goto out;
+	spin_lock_init(&net->can.rx_alldev_list->lock);
 	net->can.pkg_stats = kzalloc_obj(*net->can.pkg_stats);
 	if (!net->can.pkg_stats)
 		goto out_free_rx_alldev_list;
 	net->can.rcv_lists_stats = kzalloc_obj(*net->can.rcv_lists_stats);
 	if (!net->can.rcv_lists_stats)
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 6759662e024c..9853c68f0e2c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -960,11 +960,11 @@ static void bcm_remove_op(struct bcm_op *op)
 }
 
 static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 {
 	if (op->rx_reg_dev == dev) {
-		can_rx_unregister(dev_net(dev), dev, op->can_id,
+		can_rx_unregister(sock_net(op->sk), dev, op->can_id,
 				  REGMASK(op->can_id), bcm_rx_handler, op);
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
 		netdev_put(dev, &op->rx_reg_dev_tracker);
@@ -986,25 +986,18 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
 
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
+				 * removed due to NETDEV_UNREGISTER in
+				 * bcm_notify(). The tracked reference
+				 * op->rx_reg_dev keeps the device's receive
+				 * lists accessible, even when the device has
+				 * been unlisted or moved to another network
+				 * namespace meanwhile.
 				 */
 				if (op->rx_reg_dev)
 					bcm_rx_unreg(op->rx_reg_dev, op);
 			} else
 				can_rx_unregister(sock_net(op->sk), NULL,
@@ -1933,10 +1926,11 @@ static int bcm_release(struct socket *sock)
 		spin_lock(&bcm_notifier_lock);
 	}
 	list_del(&bo->notifier);
 	spin_unlock(&bcm_notifier_lock);
 
+	/* bcm_notify() can not access this socket anymore */
 	lock_sock(sk);
 
 #if IS_ENABLED(CONFIG_PROC_FS)
 	/* remove procfs entry */
 	if (net->can.bcmproc_dir && bo->bcm_proc_read)
@@ -1946,33 +1940,26 @@ static int bcm_release(struct socket *sock)
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list) {
 		list_del_rcu(&op->list);
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
+			 * due to NETDEV_UNREGISTER in bcm_notify(). The tracked
+			 * reference op->rx_reg_dev keeps the device's receive
+			 * lists accessible, even when the device has been
+			 * moved to another network namespace meanwhile.
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
 
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1a272ce6a2bd..fbd92d003f4a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1487,15 +1487,16 @@ static int isotp_release(struct socket *sock)
 		spin_lock(&isotp_notifier_lock);
 	}
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
-	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister
-	 * tracked reference so->dev is taken at bind() time with rtnl_lock
+	 * tracked reference so->dev is taken at bind() time
+	 * and keeps the device's receive lists accessible, even when the
+	 * device has been moved to another network namespace meanwhile
 	 */
 	if (so->bound && so->dev) {
 		if (isotp_register_rxid(so))
 			can_rx_unregister(net, so->dev, so->rxid,
 					  SINGLE_MASK(so->rxid),
@@ -1509,12 +1510,10 @@ static int isotp_release(struct socket *sock)
 
 	so->ifindex = 0;
 	so->bound = 0;
 	so->dev = NULL;
 
-	rtnl_unlock();
-
 	/* Always wait for a grace period before touching the timers below.
 	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
 	 * filters and cleared so->bound in isotp_notify() without waiting
 	 * for in-flight isotp_rcv() callers to finish, so this call must not
 	 * be skipped just because so->bound is already 0 here.
@@ -1578,11 +1577,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	}
 
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
-	rtnl_lock();
+	/* lock_sock() serializes the binding with isotp_notify() */
 	lock_sock(sk);
 
 	if (so->bound) {
 		err = -EINVAL;
 		goto out;
@@ -1617,11 +1616,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	}
 	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
 		err = -EINVAL;
 		goto out_put_dev;
 	}
-	if (!(dev->flags & IFF_UP))
+	if (!(READ_ONCE(dev->flags) & IFF_UP))
 		notify_enetdown = 1;
 
 	ifindex = dev->ifindex;
 
 	if (isotp_register_rxid(so))
@@ -1643,19 +1642,18 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 
 	/* bind() ok -> hold a reference for so->dev so that isotp_release()
 	 * can safely reach the device later, even if a concurrent
 	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
 	 */
-	so->dev = dev;
+	WRITE_ONCE(so->dev, dev);
 	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);
 
 out_put_dev:
 	/* remove potential reference from dev_get_by_index() */
 	dev_put(dev);
 out:
 	release_sock(sk);
-	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
@@ -1854,16 +1852,22 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	struct sock *sk = &so->sk;
 
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (so->dev != dev)
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
 				can_rx_unregister(dev_net(dev), dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
@@ -1875,11 +1879,11 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 			netdev_put(so->dev, &so->dev_tracker);
 		}
 
 		so->ifindex = 0;
 		so->bound  = 0;
-		so->dev = NULL;
+		WRITE_ONCE(so->dev, NULL);
 		release_sock(sk);
 
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
diff --git a/net/can/raw.c b/net/can/raw.c
index 09a5c0275ae6..761d23dae044 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -222,10 +222,11 @@ static int raw_enable_filters(struct net *net, struct net_device *dev,
 {
 	int err = 0;
 	int i;
 
 	for (i = 0; i < count; i++) {
+		cond_resched();
 		err = can_rx_register(net, dev, filter[i].can_id,
 				      filter[i].can_mask,
 				      raw_rcv, sk, sock_i_ino(sk), sk);
 		if (err) {
 			/* clean up successfully registered filters */
@@ -256,13 +257,15 @@ static void raw_disable_filters(struct net *net, struct net_device *dev,
 				struct sock *sk, struct can_filter *filter,
 				int count)
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
 					 struct net_device *dev,
 					 struct sock *sk,
@@ -307,16 +310,28 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 	struct sock *sk = &ro->sk;
 
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (ro->dev != dev)
+	/* Lockless fast path: only a socket bound to this device needs
+	 * handling, so unrelated sockets are not serialized against the
+	 * netdev notifier (which runs under RTNL) via lock_sock(). A bind()
+	 * that sets ro->dev right after this check is caught by the
+	 * NETDEV_UNREGISTER rebroadcast from netdev_wait_allrefs(); ro->dev
+	 * is rechecked under lock_sock() in the NETDEV_UNREGISTER case.
+	 */
+	if (READ_ONCE(ro->dev) != dev)
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
 			netdev_put(dev, &ro->dev_tracker);
 		}
@@ -324,11 +339,11 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 		if (ro->count > 1)
 			kfree(ro->filter);
 
 		ro->ifindex = 0;
 		ro->bound = 0;
-		ro->dev = NULL;
+		WRITE_ONCE(ro->dev, NULL);
 		ro->count = 0;
 		release_sock(sk);
 
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
@@ -429,17 +444,20 @@ static int raw_release(struct socket *sock)
 		spin_lock(&raw_notifier_lock);
 	}
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
-	rtnl_lock();
 	lock_sock(sk);
 
-	/* remove current filters & unregister */
+	/* remove current filters & unregister
+	 * tracked reference ro->dev keeps the device's receive lists
+	 * accessible, even when the device has been moved to another
+	 * network namespace meanwhile
+	 */
 	if (ro->bound) {
 		if (ro->dev) {
-			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
+			raw_disable_allfilters(net, ro->dev, sk);
 			netdev_put(ro->dev, &ro->dev_tracker);
 		} else {
 			raw_disable_allfilters(net, NULL, sk);
 		}
 	}
@@ -454,11 +472,10 @@ static int raw_release(struct socket *sock)
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
-	rtnl_unlock();
 
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
@@ -477,11 +494,11 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 	if (len < RAW_MIN_NAMELEN)
 		return -EINVAL;
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
-	rtnl_lock();
+	/* lock_sock() serializes the binding with raw_notify() */
 	lock_sock(sk);
 
 	if (ro->bound && addr->can_ifindex == ro->ifindex)
 		goto out;
 
@@ -494,11 +511,11 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 		if (!can_get_ml_priv(dev)) {
 			err = -ENODEV;
 			goto out_put_dev;
 		}
 
-		if (!(dev->flags & IFF_UP))
+		if (!(READ_ONCE(dev->flags) & IFF_UP))
 			notify_enetdown = 1;
 
 		ifindex = dev->ifindex;
 
 		/* filters set by default/setsockopt */
@@ -515,32 +532,31 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 
 	if (!err) {
 		if (ro->bound) {
 			/* unregister old filters */
 			if (ro->dev) {
-				raw_disable_allfilters(dev_net(ro->dev),
+				raw_disable_allfilters(sock_net(sk),
 						       ro->dev, sk);
 				/* drop reference to old ro->dev */
 				netdev_put(ro->dev, &ro->dev_tracker);
 			} else {
 				raw_disable_allfilters(sock_net(sk), NULL, sk);
 			}
 		}
 		ro->ifindex = ifindex;
 		ro->bound = 1;
 		/* bind() ok -> hold a reference for new ro->dev */
-		ro->dev = dev;
+		WRITE_ONCE(ro->dev, dev);
 		if (ro->dev)
 			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
 	}
 
 out_put_dev:
 	/* remove potential reference from dev_get_by_index() */
 	dev_put(dev);
 out:
 	release_sock(sk);
-	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
@@ -565,62 +581,49 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 
 	return RAW_MIN_NAMELEN;
 }
 
 static int raw_setsockopt_locked(struct socket *sock, int optname,
-				 sockptr_t optval, unsigned int optlen)
+				 sockptr_t optval, unsigned int optlen,
+				 struct can_filter *filter,
+				 struct can_filter *sfilter, int count)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
-	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
-	struct can_filter sfilter;         /* single filter */
 	struct net_device *dev = NULL;
 	can_err_mask_t err_mask = 0;
-	int count = 0;
 	int flag;
 	int err = 0;
 
 	switch (optname) {
 	case CAN_RAW_FILTER:
-		if (optlen % sizeof(struct can_filter) != 0)
-			return -EINVAL;
-
-		if (optlen > CAN_RAW_FILTER_MAX * sizeof(struct can_filter))
-			return -EINVAL;
-
-		count = optlen / sizeof(struct can_filter);
-
-		if (count > 1) {
-			/* filter does not fit into dfilter => alloc space */
-			filter = memdup_sockptr(optval, optlen);
-			if (IS_ERR(filter))
-				return PTR_ERR(filter);
-		} else if (count == 1) {
-			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
-				return -EFAULT;
-		}
-
+		/* The filters have been copied from user space in
+		 * raw_setsockopt() before lock_sock() was taken, so a stalled
+		 * copy can not hold lock_sock() and thereby block a concurrent
+		 * NETDEV_UNREGISTER waiting for it under RTNL in raw_notify().
+		 * On success @filter is linked to the socket, on error the
+		 * caller frees it.
+		 *
+		 * Without RTNL the reg_state check is only a shortcut. When the
+		 * device is unregistered concurrently, raw_notify() waits for
+		 * lock_sock() and removes the filters set here.
+		 */
 		dev = ro->dev;
-		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED) {
-			if (count > 1)
-				kfree(filter);
+		if (ro->bound && dev &&
+		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED)
 			return -ENODEV;
-		}
 
 		if (ro->bound) {
 			/* (try to) register the new filters */
 			if (count == 1)
 				err = raw_enable_filters(sock_net(sk), dev, sk,
-							 &sfilter, 1);
+							 sfilter, 1);
 			else
 				err = raw_enable_filters(sock_net(sk), dev, sk,
 							 filter, count);
-			if (err) {
-				if (count > 1)
-					kfree(filter);
+			if (err)
 				return err;
-			}
 
 			/* remove old filter registrations */
 			raw_disable_filters(sock_net(sk), dev, sk, ro->filter,
 					    ro->count);
 		}
@@ -630,11 +633,11 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 			kfree(ro->filter);
 
 		/* link new filters to the socket */
 		if (count == 1) {
 			/* copy filter data for single filter */
-			ro->dfilter = sfilter;
+			ro->dfilter = *sfilter;
 			filter = &ro->dfilter;
 		}
 		ro->filter = filter;
 		ro->count  = count;
 		break;
@@ -646,12 +649,14 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 		if (copy_from_sockptr(&err_mask, optval, optlen))
 			return -EFAULT;
 
 		err_mask &= CAN_ERR_MASK;
 
+		/* lockless shortcut, see CAN_RAW_FILTER */
 		dev = ro->dev;
-		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED)
+		if (ro->bound && dev &&
+		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED)
 			return -ENODEV;
 
 		/* remove current error mask */
 		if (ro->bound) {
 			/* (try to) register the new err_mask */
@@ -749,22 +754,61 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 
 static int raw_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
+	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
+	struct can_filter sfilter;         /* single filter */
+	int count = 0;
 	int err;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
 
-	rtnl_lock();
+	if (optname == CAN_RAW_FILTER) {
+		/* Copy the filters from user space before taking lock_sock(),
+		 * so a stalled copy can not hold lock_sock() and thereby block
+		 * a concurrent NETDEV_UNREGISTER that waits for lock_sock()
+		 * under RTNL in raw_notify().
+		 */
+		if (optlen % sizeof(struct can_filter) != 0)
+			return -EINVAL;
+
+		if (optlen > CAN_RAW_FILTER_MAX * sizeof(struct can_filter))
+			return -EINVAL;
+
+		count = optlen / sizeof(struct can_filter);
+
+		if (count > 1) {
+			/* filter does not fit into dfilter => alloc space */
+			filter = memdup_sockptr(optval, optlen);
+			if (IS_ERR(filter))
+				return PTR_ERR(filter);
+		} else if (count == 1) {
+			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
+				return -EFAULT;
+		}
+	}
+
+	/* The filters of a bound socket are changed under lock_sock() only.
+	 * ro->dev is protected by a tracked reference and a concurrent
+	 * NETDEV_UNREGISTER waits in raw_notify() for lock_sock() and then
+	 * removes the current filters.
+	 */
 	lock_sock(sk);
 
-	err = raw_setsockopt_locked(sock, optname, optval, optlen);
+	err = raw_setsockopt_locked(sock, optname, optval, optlen,
+				    filter, &sfilter, count);
 
 	release_sock(sk);
-	rtnl_unlock();
+
+	/* raw_setsockopt_locked() links filter to the socket on success; on
+	 * any error the caller still owns the memdup'ed buffer. count > 1 is
+	 * only reached for CAN_RAW_FILTER, so it unambiguously marks it.
+	 */
+	if (err && count > 1)
+		kfree(filter);
 
 	return err;
 }
 
 static int raw_getsockopt(struct socket *sock, int level, int optname,
-- 
2.53.0


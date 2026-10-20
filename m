Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792528396;
	b=nYHOKZEY2G7sa4SxgVTzORLXGxWVjmmMvDWLadU5E7K94PUbyLeEYVuF9CCS51SMtoFk
	 Lwgvwl4cC+Zp2DDe7rrnfQt+ynSp9ekZ2NWCSkDUG3IVzARox2u0v1lQEC7WVO9TAUrDS
	 R2a3J6Kf5RM2uu0eOVfCu8wMdvFd9Rwmbc/pLVbgcG44iOdLQk7sTUtSIHY8hPBp/09DU
	 OemH9VTHSuItL2mVe5BX0i33QcZReyRzdN/I/4OxDGq7dG25qWJlPNqjmQTVQPlSb3aVm
	 8mtgzCveZDSAFWGQF6MAslq5tF92LbFWWX6Ok3losPT4lXdqMKSJGyoPbKvvsVOFcRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528396;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=ZxZWdCFhaKLW18LTRd+NHSXux/BiTzJAsDPx62rK2O0=;
	b=GIEJMG9SwyXjPGM5mkrLLSXOYc98F11Fp4/BYJY9cszAV/XInVBoAvESwV1gYH6d8k6k
	 mMuJN+fES0w+SBz61d5Ih54dxPC/QRNWFZevsv1ioqGcvDoc2dMnoEfzDY3t46rcT4zcv
	 sEC4NTiReJD37c2yYG427Kj7j10aZUixtX3KtkX8zk5/8YpovPj5IYMa/eH09WvBVhwdJ
	 hSh8aWlWmvUURFgXa2ZoLwd7633zIHuzd7Qdln4EqYNPN/Z/jXdhoh1NqX6wCWMqdUqGe
	 OkoA/jwU+N+Hq8DVn+lShkCqkAow+Notdf0QgEJgX51oVJXzCqwiLsFTKs16r2KnUsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=l44WZ3jB;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Rp2EA7Oe;
	arc=fail smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99C606A31B;
	Tue, 20 Oct 2026 20:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA99C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=l44WZ3jB;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Rp2EA7Oe
ARC-Seal: i=1; a=rsa-sha256; t=1792528386; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jUCKQG7zdGlut87ACfwsoKapVX6nMPfIlFt9DJE3+sK3na4E7G9IKvBuvQTCOAY9Xb
    d8ci+wpUPz7b2HBG8kjCJBGcHEXSsdTwN+j0MmUZ0StS7KENt6Z0iqtRbXEKEWbdjzm0
    dYdGzHFp2TaFDQcUUtbJjgucphRYMLxsw/CtT3CEXDr0/l4i6Pf+7VcPbyF0/feFpbGo
    74LT/JUjCzj/caCEB48U2Bfq3Ss8WN6yhpVlg9h4SwbfGtjkig2tz0YPX+EJgzj0PRlr
    69ySRhe6Ds2P5lkU8Lr/TYCNv15qs0TiI2ceEsksbhVrnQlvGtaUNrTGD5hIZ7DlbUV2
    TRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792528386;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZxZWdCFhaKLW18LTRd+NHSXux/BiTzJAsDPx62rK2O0=;
    b=jILx+oEs/iPz5tXK+1OBFQv0FOFJUsDQxi4voUC4q6dda0Qmy+N7Gtw3u72gwVo4U4
    yf/L7Y1f0axRIaAiygftDe8UJT0d810/SjQsbCuYJM+xf8SRyTn5l1PQFsyh/o9rtd/k
    EXkkzxwKlKBkyXwg6+Y/9WVpUswO4ivGT1EdLuN2RL8QxbDS6QwlWNFEPLCH00KSTBF8
    1cYUHrrINiproAhoPOvSdynNu3yRll2Emtv3XkEvkWAugGe/x4TrDuKUW/LkPEv0cz1k
    yqMpRHWxM33fcd1EREg4bbtmFUjzfUzVpz2ilDt3ANRR94WYygdGrKEXQQBu5PbG/Pkt
    caJQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792528386;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZxZWdCFhaKLW18LTRd+NHSXux/BiTzJAsDPx62rK2O0=;
    b=l44WZ3jBSh/l8jJgFJQcc/Dvo3VddYpJs3mvbnysv57IbxU0Z2yYOmfB7NVCs9B/0U
    RfPfU77GKyhpfrb9y3H1+czDMT/cYHJwNcI4IM56PM1E/Dm/fcjMKKIxnxBZai7Oo9KW
    TABpKr8+yVaxSog0d37zEWcbwvtOuM4oB7jjb5K10iHBspBNj1G3sm+nrfv1lAMOTHIe
    py5l8sQfS3o7Ufr0SpcGPc4Ytwes4U9Ee5pwecmO1EuvgIj5MDErWVY6cRoElh4U/FUW
    TWfANuxU2b7CBurWR+M9SMHomV7DKKycIuO+yCckh2elZj/CYoUQ0CBEJr7CMuqkNrf4
    DgMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792528386;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZxZWdCFhaKLW18LTRd+NHSXux/BiTzJAsDPx62rK2O0=;
    b=Rp2EA7OeGkYq/RQmwXxRrSB7xlFVdOMT4hg0NRJtB2SNlsS07QRxpo42jP9H3sR0sj
    RhNpfkes2kq5yknWv1AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29KKX5dMt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Oct 2026 22:33:05 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [PATCH can-next v5 5/5] can: protect the receive lists with a per-device lock
Date: Tue, 20 Oct 2026 22:32:57 +0200
Message-ID: <20261020203257.230955-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020203257.230955-1-socketcan@hartkopp.net>
References: <20261020203257.230955-1-socketcan@hartkopp.net>
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
Content-Type: text/plain; charset="us-ascii"

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
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v5:
- raw_bind() / isotp_bind(): check IFF_UP after publishing the bound
  device, with an smp_mb() pair against raw_notify() / isotp_notify() for
  NETDEV_DOWN, so a down transition during bind() is reported with
  ENETDOWN again, as with RTNL before (Sashiko review). isotp_bind()
  already published so->dev before the IFF_UP check, but without a
  barrier the load could still pass the store.
- raw_bind() no longer reports ENETDOWN when bind() fails
- rcvlists_lock comment names the rcv_entries(_max) stats (Sashiko review)
- can_rx_unregister() kernel-doc and commit message: @net should be the
  namespace of can_rx_register(), otherwise only the statistics become
  imprecise (j1939, Sashiko review)
- v4: https://lore.kernel.org/linux-can/20261019152741.54854-6-socketcan@hartkopp.net/

Changes in v4:
- rebased on linux-can-next/testing: the context in raw_bind() changed
  with "can: raw: remove redundant NULL check before netdev_hold()",
  which made v3 fail to apply
- added "can: proc: skip stats calculation after reset in
  can_stat_update()" from linux-can-next/testing to the base sequence
- no functional change
- v3: https://lore.kernel.org/linux-can/20261019074244.50391-5-socketcan@hartkopp.net/

Changes in v3:
- not RFC anymore, sent as new series with the patches 1-3 from the
  linux-can-next pull request to build on top of mainline (see cover letter)
- commit message: describe the isotp and bcm cases separately (bcm passes
  dev_net(dev), which can_rx_unregister() reads again for its check) and
  mention that the lists of a device could be modified under the locks of
  different namespaces
- can_rx_unregister() kernel-doc: @net also selects the 'any' CAN device
  lists for @dev == NULL
- v2: https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/

Changes in v2:
- v1 relied on the NETDEV_UNREGISTER rebroadcast in
  netdev_wait_allrefs_any() to catch a bind() racing with the notifier,
  which is not sent on a namespace change. raw_bind() and isotp_bind() now
  publish the device inside the RCU section of dev_get_by_index_rcu()
  (CAN_RAW: new ro->bind_dev hint with smp_store_release() /
  smp_load_acquire(), CAN_ISOTP: so->dev is published early and reset
  when bind() fails)
- moved the implementation details from the commit message to the notes
- shortened the code comments
- replaced the rebind rate measurement with an RTNL latency measurement
- v1: https://lore.kernel.org/linux-can/20261017201935.399233-1-socketcan@hartkopp.net/

Notes:

- bind() vs. NETDEV_UNREGISTER: Both on unregistration and on a
  namespace change, unlist_netdevice() and synchronize_net() precede
  NETDEV_UNREGISTER. bind() publishes the device (ro->bind_dev /
  so->dev) inside the RCU section of dev_get_by_index_rcu(). So either
  the notifier sees it after synchronize_net() and handles the socket
  under lock_sock(), or the lookup does not find the unlisted device and
  bind() fails with -ENODEV. The NETDEV_UNREGISTER rebroadcast in
  netdev_wait_allrefs_any() is not relied on, as it does not happen on a
  namespace change.

- raw_notify() / isotp_notify() keep a lockless READ_ONCE() fast path,
  so RTNL only waits for lock_sock() of sockets that are bound or being
  bound to the vanishing device. CAN_RAW needs the separate
  ro->bind_dev hint, as ro->dev still points to the previously bound
  device until a rebind completes. ro->bind_dev is never dereferenced;
  a stale value only causes a needless lock_sock(). raw_notify() reads
  ro->bind_dev with smp_load_acquire() before ro->dev, paired with
  smp_store_release() in raw_bind(): A later bind() can only overwrite
  ro->bind_dev after the previous bind() has set ro->dev and released
  lock_sock(). Otherwise the notifier could see a stale ro->dev and the
  ro->bind_dev of a subsequent failing rebind to another device, and
  miss the binding. CAN_ISOTP does not support rebinding and publishes
  so->dev directly, which is reset when bind() fails. bcm_notify()
  always takes lock_sock() and bcm_rx_setup() looks up the device under
  lock_sock(), so bcm needs no extra handling.

- raw_setsockopt() copies the filters from user space before
  lock_sock(), so a stalled copy can not block a NETDEV_UNREGISTER that
  waits for lock_sock() under RTNL. The dev->reg_state check is only a
  shortcut now (READ_ONCE()) and does not catch a namespace change.

- NETDEV_DOWN: raw_notify() / isotp_notify() check ro->dev / so->dev
  locklessly. They are written with WRITE_ONCE() in bind() and in the
  notifier. IFF_UP is cleared in __dev_close_many() before
  netif_close_many() or __dev_notify_flags() send NETDEV_DOWN in the
  same context, and bind() checks IFF_UP after publishing the bound
  device. With an smp_mb() on both sides, either the notifier sees the
  binding or bind() sees the cleared IFF_UP. CAN_ISOTP publishes so->dev before its last
  checks, so a failing isotp_bind() may get a needless ENETDOWN.

- j1939 benefits as well: After a namespace change its
  can_rx_unregister() with dev_net(ndev) picked the rcvlists_lock of the
  wrong namespace. The receive list statistics may still become
  imprecise in this case, as before.

- Tested on a lockdep + KASAN kernel:
  - 10 min CAN_RAW / CAN_BCM / CAN_ISOTP traffic and procfs reads in two
    namespaces while moving the CAN device between them (2272 moves)
  - CAN_RAW / CAN_ISOTP bind and CAN_RAW rebind churn (incl. failing
    rebinds to a non-CAN device) against 1007 namespace moves, checking
    that no filters are left on the device in the other namespace, and
    against 611 device deletions
  - bcm_release() with a stalled procfs reader does not block RTNL
  - RTNL latency (no-op SIOCSIFMTU on lo) under CAN_RAW 512 filter
    churn: avg ~1 us, max ~1.2 ms (before: avg ~250 us, max ~24 ms)

 include/linux/can/can-ml.h |   3 +
 include/net/netns/can.h    |   2 +-
 net/can/af_can.c           |  39 ++++++----
 net/can/bcm.c              |  43 +++-------
 net/can/isotp.c            |  48 +++++++++---
 net/can/raw.c              | 155 ++++++++++++++++++++++++-------------
 6 files changed, 180 insertions(+), 110 deletions(-)

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
index 48b79f7e6236..54f23681e0d4 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -27,11 +27,11 @@ struct netns_can {
 	struct proc_dir_entry *bcmproc_dir;
 #endif
 
 	/* receive filters subscribed for 'all' CAN devices */
 	struct can_dev_rcv_lists *rx_alldev_list;
-	spinlock_t rcvlists_lock;
+	spinlock_t rcvlists_lock; /* protects the rcv_entries(_max) stats */
 	struct timer_list stattimer; /* timer for statistics update */
 	struct can_pkg_stats *pkg_stats;
 	struct can_rcv_lists_stats *rcv_lists_stats;
 
 	/* CAN GW per-net gateway jobs */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index d97f85fc3232..0f3051a61aab 100644
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
 
@@ -507,10 +511,18 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
  * @func: callback function on filter match
  * @data: returned parameter for callback function
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
 		       void *data)
 {
@@ -520,16 +532,14 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
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
@@ -545,30 +555,30 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
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
@@ -821,10 +831,11 @@ static int can_pernet_init(struct net *net)
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
index 6759662e024c..7bd2aa39777a 100644
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
@@ -986,25 +986,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
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
+				 * removed in bcm_notify(). op->rx_reg_dev keeps
+				 * the device's receive lists accessible.
 				 */
 				if (op->rx_reg_dev)
 					bcm_rx_unreg(op->rx_reg_dev, op);
 			} else
 				can_rx_unregister(sock_net(op->sk), NULL,
@@ -1933,10 +1922,11 @@ static int bcm_release(struct socket *sock)
 		spin_lock(&bcm_notifier_lock);
 	}
 	list_del(&bo->notifier);
 	spin_unlock(&bcm_notifier_lock);
 
+	/* bcm_notify() can not access this socket anymore */
 	lock_sock(sk);
 
 #if IS_ENABLED(CONFIG_PROC_FS)
 	/* remove procfs entry */
 	if (net->can.bcmproc_dir && bo->bcm_proc_read)
@@ -1946,33 +1936,24 @@ static int bcm_release(struct socket *sock)
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
 
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1a272ce6a2bd..512aff91aa0e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1487,15 +1487,15 @@ static int isotp_release(struct socket *sock)
 		spin_lock(&isotp_notifier_lock);
 	}
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
 			can_rx_unregister(net, so->dev, so->rxid,
 					  SINGLE_MASK(so->rxid),
@@ -1509,12 +1509,10 @@ static int isotp_release(struct socket *sock)
 
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
@@ -1578,11 +1576,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	}
 
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
-	rtnl_lock();
+	/* lock_sock() serializes the binding with isotp_notify() */
 	lock_sock(sk);
 
 	if (so->bound) {
 		err = -EINVAL;
 		goto out;
@@ -1604,11 +1602,21 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	if (isotp_register_rxid(so) && rx_id == tx_id) {
 		err = -EADDRNOTAVAIL;
 		goto out;
 	}
 
-	dev = dev_get_by_index(net, addr->can_ifindex);
+	/* Publish the device inside the RCU section of the lookup: When it
+	 * is unlisted concurrently, either isotp_notify() sees so->dev after
+	 * synchronize_net() or the lookup fails.
+	 */
+	rcu_read_lock();
+	dev = dev_get_by_index_rcu(net, addr->can_ifindex);
+	if (dev) {
+		dev_hold(dev);
+		WRITE_ONCE(so->dev, dev);
+	}
+	rcu_read_unlock();
 	if (!dev) {
 		err = -ENODEV;
 		goto out;
 	}
 	if (!can_get_ml_priv(dev)) {
@@ -1617,11 +1625,16 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	}
 	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
 		err = -EINVAL;
 		goto out_put_dev;
 	}
-	if (!(dev->flags & IFF_UP))
+
+	/* Either isotp_notify() sees so->dev on NETDEV_DOWN or we see the
+	 * cleared IFF_UP, pairs with isotp_notify()
+	 */
+	smp_mb();
+	if (!(READ_ONCE(dev->flags) & IFF_UP))
 		notify_enetdown = 1;
 
 	ifindex = dev->ifindex;
 
 	if (isotp_register_rxid(so))
@@ -1643,19 +1656,21 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 
 	/* bind() ok -> hold a reference for so->dev so that isotp_release()
 	 * can safely reach the device later, even if a concurrent
 	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
 	 */
-	so->dev = dev;
 	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);
 
 out_put_dev:
-	/* remove potential reference from dev_get_by_index() */
+	/* the published so->dev is only valid for a successful bind() */
+	if (err)
+		WRITE_ONCE(so->dev, NULL);
+
+	/* remove reference from the device lookup */
 	dev_put(dev);
 out:
 	release_sock(sk);
-	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
@@ -1854,16 +1869,25 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	struct sock *sk = &so->sk;
 
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
 				can_rx_unregister(dev_net(dev), dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
@@ -1875,11 +1899,11 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
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
index dfea48768b23..d07f3bb68cd5 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -83,10 +83,11 @@ struct uniqframe {
 
 struct raw_sock {
 	struct sock sk;
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
+	struct net_device *bind_dev; /* hint for raw_notify(), no reference */
 	struct list_head notifier;
 	int ifindex;
 	unsigned int bound:1;
 	unsigned int loopback:1;
 	unsigned int recv_own_msgs:1;
@@ -222,10 +223,11 @@ static int raw_enable_filters(struct net *net, struct net_device *dev,
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
@@ -256,13 +258,15 @@ static void raw_disable_filters(struct net *net, struct net_device *dev,
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
@@ -303,20 +307,35 @@ static int raw_enable_allfilters(struct net *net, struct net_device *dev,
 
 static void raw_notify(struct raw_sock *ro, unsigned long msg,
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
 			netdev_put(dev, &ro->dev_tracker);
 		}
@@ -324,11 +343,11 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
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
@@ -379,10 +398,11 @@ static int raw_init(struct sock *sk)
 	struct raw_sock *ro = raw_sk(sk);
 
 	ro->bound            = 0;
 	ro->ifindex          = 0;
 	ro->dev              = NULL;
+	ro->bind_dev         = NULL;
 
 	/* set default filter to single entry dfilter */
 	ro->dfilter.can_id   = 0;
 	ro->dfilter.can_mask = MASK_ALL;
 	ro->filter           = &ro->dfilter;
@@ -429,17 +449,19 @@ static int raw_release(struct socket *sock)
 		spin_lock(&raw_notifier_lock);
 	}
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
 		}
 	}
@@ -454,11 +476,10 @@ static int raw_release(struct socket *sock)
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
-	rtnl_unlock();
 
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
@@ -477,30 +498,38 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 	if (len < RAW_MIN_NAMELEN)
 		return -EINVAL;
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
 		}
 		if (!can_get_ml_priv(dev)) {
 			err = -ENODEV;
 			goto out_put_dev;
 		}
 
-		if (!(dev->flags & IFF_UP))
-			notify_enetdown = 1;
-
 		ifindex = dev->ifindex;
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), dev, sk);
 		if (err)
@@ -515,31 +544,39 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 
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
 	release_sock(sk);
-	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
@@ -564,62 +601,45 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 
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
+		/* @filter has been copied by raw_setsockopt(). It is linked
+		 * to the socket on success and freed by the caller on error.
+		 *
+		 * The reg_state check is only a shortcut: On a concurrent
+		 * unregistration or namespace change raw_notify() waits for
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
@@ -629,11 +649,11 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
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
@@ -645,12 +665,14 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
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
@@ -748,22 +770,51 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 
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
+		/* Copy the filters before lock_sock(), so a stalled copy can
+		 * not block raw_notify() waiting for lock_sock() under RTNL.
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
 	lock_sock(sk);
 
-	err = raw_setsockopt_locked(sock, optname, optval, optlen);
+	err = raw_setsockopt_locked(sock, optname, optval, optlen,
+				    filter, &sfilter, count);
 
 	release_sock(sk);
-	rtnl_unlock();
+
+	/* on error free the filters allocated for CAN_RAW_FILTER above */
+	if (err && count > 1)
+		kfree(filter);
 
 	return err;
 }
 
 static int raw_getsockopt(struct socket *sock, int level, int optname,
-- 
2.43.0


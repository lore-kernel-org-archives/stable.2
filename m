Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C783DAAD9;
	Tue, 29 Sep 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696500; cv=pass; b=a818IgBByFllnFm5NAoFWgjngtO3rXZjLgXy5YUPeOwQdSZMETJgv9wXgWWHIKkqcx2Ntd2J7kH36dPgYZRvKg10o3RN1sJFHZw3EuUQMLcQf+bkQ7qMyrSJHa/r6sEBWnZIb+ImDsGkeevOaXnrqUIZnaW0HV2wCOGV7e9oWHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696500; c=relaxed/simple;
	bh=kQF+jP1rnEzWxhExVK44ZEoOrbkfzEIKpZuiA3dFR0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxZZAQnqpg5Gw7EcoC0tGNGI1VNvv8/Oi1AOp2yVN+7ryfPe86N06W896qq0hYo1nYHAl34PzX6usMbmxIDhND1moOZfL3+2xBYKiCXXBKzsI4Z37+vPUzGDpgJiGI4qs9a0AyYoH4WC81ziG9W6E0qGAIdc/5b6Cj0nN/4XcTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iTBmuphA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=awehtzs+; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iTBmuphA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="awehtzs+"
ARC-Seal: i=1; a=rsa-sha256; t=1790696494; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qtAUFIocWd7UWWfXdMFylpOnVFfPoPC4g9B1zfLtXAImuid4nzMSUTv9VJCT5ep0qa
    6Dr9lbe3xMWCt7/fifapNsj4LIi5ulmxDidpnLWrVH4YZdMLtpS8yhAnK67BlkuVr6uD
    lnDRvamnYWoriHqnD0EGuOcQslkj9QERn1zGUz8zEaaiQ04Pd9zgISjXD7RKea/i/ytU
    /HDhKqVqvG4MqPJwSww81F4lDXyOTQU15vgj1I8+XCGuqsDTOFJzufr0hei+4kp20wHi
    FZgjLJGDreXqZT+3Y1QWHMrWCxTj9ITPZujA6iIfvGvZWkwQE/z/GviMHZ7afBwvCbUc
    mSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790696494;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ju7+jgrLkAFiW6F7eRGwAj9nwzGcAG7TQ6pqIXS1kDI=;
    b=O8zF4RdNWhXMNU9gHd74s2k/JHbI/mNo/Mn5VPW6MmOWg2Pb/BR7HUjxupaOLvw1Wf
    KYGFzsFCExpyWiEFYCEsA7XyfKG95Yo4Y0wGh2IWAVRN+EMAlX5lx6cvLpNOynrXqd04
    tQJZlUYRA+tSm9RvUdHwUBoe3ybl0kkO4oJ0Acwq5eyB78bBpyoaXJqnIVtQkGDWu5y6
    BWzQfzSZ83mMiYBiem0xgZfgiMbsQIzzghEjaLzid1G0kulaMXV0Bg8n+KeG7PZckwRz
    RTNzGmBpVQX72KyYqyP0LtQqS3JsTRcI7n3Ypx7Q3uVQTlBT2kWaYfkQ47dtP3L4PdF2
    8Biw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790696494;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ju7+jgrLkAFiW6F7eRGwAj9nwzGcAG7TQ6pqIXS1kDI=;
    b=iTBmuphAVcCgXVjdWAFJLY80z6D6Y78yN9xpXb+y6oThsVnJ7cP7xYp7khz3OPcd/a
    5//xF3GlJpoW95EpNoAplU1XVNIDRBVcmxv8kxc15bojcjMHXH89ED+gFh1qr3B0gYot
    lKsLtJQqEn3WmPo4p9fOwSvWmw70DdjS/lxL95A7j0ggT4HZlqqJPLJhoaaIwZDL/ArG
    BBuLlSqV6QtdtQTlf/5tKFqJIpN+Rfma9opVNVQmrzkBY8aApsjv96mnJUXJUw62y4M0
    CbHGtYVaq6JbHjHCE0vQkMQJUhJEnjgMJTeuaXNUSk9pFmI8P5cuY0WsBm/lqPQ/YqrU
    Sr6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790696494;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ju7+jgrLkAFiW6F7eRGwAj9nwzGcAG7TQ6pqIXS1kDI=;
    b=awehtzs+wFK5VWpk2CvspB7nbNHoSJVyzaHmigHUqOiIY6tdZ8SX/ImSepLZ3orDZC
    2OMG/MV4/6PAFpXtzEBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28TFfYTeW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 29 Sep 2026 17:41:34 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/3] can: fix unique skb identifier regression under RPS
Date: Tue, 29 Sep 2026 17:41:25 +0200
Message-ID: <20260929154125.3298-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929154125.3298-1-socketcan@hartkopp.net>
References: <20260929154125.3298-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Commit d4fb6514ff8e ("can: use skb hash instead of private variable in
headroom") moved the per-skb unique identifier used for raw_rcv()
duplicate detection into skb->hash.

With RPS enabled, get_rps_cpu() calls skb_get_hash() before the frame
reaches the CAN subsystem. Since CAN skbs have no L3/L4 headers, the
flow dissector assigns every CAN frame the same non-zero software
hash. can_set_skb_uid() only generated a new identifier when
skb->hash was 0, so it kept this constant hash. When the SLAB
allocator later reused the same skb address, raw_rcv() mistook the
next legitimate frame for a duplicate and dropped it.

Fix this by storing the CAN UID in the CAN skb extension
(struct can_skb_ext::can_skb_uid) instead of skb->hash, decoupling it
from any hash the network stack may compute. can_set_skb_uid() keeps
its "assign only if unset" behaviour, which preserves UIDs set before
transmission (e.g. by isotp to identify echo frames) across the local
loopback path.

Frames whose extension is still shared with another clone (e.g. via
tc mirred or netem duplicate) are given a private extension copy
before the UID is assigned, so that independently received clones
never end up with the same UID.

can-gw and vxcan additionally clear the UID of forwarded/duplicated
frames so each newly routed frame gets its own unique identifier.

Fixes: d4fb6514ff8e ("can: use skb hash instead of private variable in headroom")
Reported-by: Joerg Willmann <joe@clnt.de>
Closes: https://lore.kernel.org/linux-can/2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de/
Cc: stable@vger.kernel.org
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---
v2: We need a non-zero UID for the cfecho checks in isotp.c
    So restore the former while (!(skb->hash)) statement
v3: omit the problematic use of skb->hash reported by sashiko bot
v4: address tc mirred or netem duplicate clones suggested by sashiko bot
---
 drivers/net/can/vxcan.c  |  3 +++
 include/linux/can/core.h |  3 ++-
 include/linux/can/skb.h  |  4 ++-
 include/net/can.h        |  2 ++
 net/can/af_can.c         | 57 ++++++++++++++++++++++++++++++----------
 net/can/gw.c             |  3 +++
 net/can/isotp.c          | 16 ++++++-----
 net/can/raw.c            | 10 ++++---
 8 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 9e2e25d02471..51148a81d1d9 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -77,10 +77,13 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
 		goto out_unlock;
 	}
 
 	/* reset CAN GW hop counter */
 	csx->can_gw_hops = 0;
+	/* start with new CAN skb UID in the other namespace */
+	csx->can_skb_uid = 0;
+
 	skb->pkt_type   = PACKET_BROADCAST;
 	skb->dev        = peer;
 	skb->ip_summed  = CHECKSUM_UNNECESSARY;
 
 	len = can_skb_get_data_len(skb);
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 3287232e3cad..2de74c2b78b6 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -15,10 +15,11 @@
 #define _CAN_CORE_H
 
 #include <linux/can.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <net/can.h>
 
 #define DNAME(dev) ((dev) ? (dev)->name : "any")
 
 /**
  * struct can_proto - CAN protocol structure
@@ -56,9 +57,9 @@ extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      canid_t can_id, canid_t mask,
 			      void (*func)(struct sk_buff *, void *),
 			      void *data);
 
 extern int can_send(struct sk_buff *skb, int loop);
-void can_set_skb_uid(struct sk_buff *skb);
+void can_set_skb_uid(struct can_skb_ext *csx);
 void can_sock_destruct(struct sock *sk);
 
 #endif /* !_CAN_CORE_H */
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index a70a02967071..5d27843862fc 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -41,12 +41,14 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
 static inline struct can_skb_ext *can_skb_ext_add(struct sk_buff *skb)
 {
 	struct can_skb_ext *csx = skb_ext_add(skb, SKB_EXT_CAN);
 
 	/* skb_ext_add() returns uninitialized space */
-	if (csx)
+	if (csx) {
 		csx->can_gw_hops = 0;
+		csx->can_skb_uid = 0;
+	}
 
 	return csx;
 }
 
 static inline struct can_skb_ext *can_skb_ext_find(struct sk_buff *skb)
diff --git a/include/net/can.h b/include/net/can.h
index 6db9e826f0e0..2b8af2598732 100644
--- a/include/net/can.h
+++ b/include/net/can.h
@@ -15,14 +15,16 @@
  * struct can_skb_ext - skb extensions for CAN specific content
  * @can_iif: ifindex of the first interface the CAN frame appeared on
  * @can_framelen: cached echo CAN frame length for bql
  * @can_gw_hops: can-gw CAN frame time-to-live counter
  * @can_ext_flags: CAN skb extensions flags
+ * @can_skb_uid: CAN skb UID for raw_rcv and isotp echo handling
  */
 struct can_skb_ext {
 	int	can_iif;
 	u16	can_framelen;
 	u8	can_gw_hops;
 	u8	can_ext_flags;
+	u32	can_skb_uid;
 };
 
 #endif /* _NET_CAN_H */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index ef435f22ac93..4aa233d7e8a1 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -639,17 +639,14 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 	}
 
 	return matches;
 }
 
-void can_set_skb_uid(struct sk_buff *skb)
+void can_set_skb_uid(struct can_skb_ext *csx)
 {
-	/* create non-zero unique skb identifier together with *skb */
-	while (!(skb->hash))
-		skb->hash = atomic_inc_return(&skbcounter);
-
-	skb->sw_hash = 1;
+	while (!(csx->can_skb_uid))
+		csx->can_skb_uid = atomic_inc_return(&skbcounter);
 }
 EXPORT_SYMBOL(can_set_skb_uid);
 
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
@@ -660,12 +657,10 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 
 	/* update statistics */
 	atomic_long_inc(&pkg_stats->rx_frames);
 	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
-	can_set_skb_uid(skb);
-
 	rcu_read_lock();
 
 	/* deliver the packet to sockets listening on all devices */
 	matches = can_rcv_filter(net->can.rx_alldev_list, skb);
 
@@ -682,54 +677,88 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 		atomic_long_inc(&pkg_stats->matches);
 		atomic_long_inc(&pkg_stats->matches_delta);
 	}
 }
 
+static struct can_skb_ext *can_get_unshared_skb_ext(struct sk_buff *skb,
+						    struct can_skb_ext *csx)
+{
+	/* create unshared CAN skb_extension for netem/mirred skb clones */
+	if (unlikely(skb_cloned(skb)))
+		return skb_ext_add(skb, SKB_EXT_CAN);
+	else
+		return csx;
+}
+
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(!can_get_ml_priv(dev) ||
-		     !can_skb_ext_find(skb) || !can_is_can_skb(skb))) {
+	struct can_skb_ext *csx = can_skb_ext_find(skb);
+
+	if (unlikely(!can_get_ml_priv(dev) || !csx || !can_is_can_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CAN_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
+	csx = can_get_unshared_skb_ext(skb, csx);
+	if (unlikely(!csx)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+		return NET_RX_DROP;
+	}
+
+	can_set_skb_uid(csx);
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
 }
 
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(!can_get_ml_priv(dev) ||
-		     !can_skb_ext_find(skb) || !can_is_canfd_skb(skb))) {
+	struct can_skb_ext *csx = can_skb_ext_find(skb);
+
+	if (unlikely(!can_get_ml_priv(dev) || !csx || !can_is_canfd_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CANFD_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
+	csx = can_get_unshared_skb_ext(skb, csx);
+	if (unlikely(!csx)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+		return NET_RX_DROP;
+	}
+
+	can_set_skb_uid(csx);
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
 }
 
 static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(!can_get_ml_priv(dev) ||
-		     !can_skb_ext_find(skb) || !can_is_canxl_skb(skb))) {
+	struct can_skb_ext *csx = can_skb_ext_find(skb);
+
+	if (unlikely(!can_get_ml_priv(dev) || !csx || !can_is_canxl_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CANXL_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
+	csx = can_get_unshared_skb_ext(skb, csx);
+	if (unlikely(!csx)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+		return NET_RX_DROP;
+	}
+
+	can_set_skb_uid(csx);
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
 }
 
 /* af_can protocol functions */
diff --git a/net/can/gw.c b/net/can/gw.c
index d9912dea738b..54bb5bd3242a 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -526,10 +526,13 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	}
 
 	/* put the incremented hop counter in the cloned skb */
 	ncsx->can_gw_hops = csx->can_gw_hops + 1;
 
+	/* force a new CAN UID generation for the routed frame */
+	ncsx->can_skb_uid = 0;
+
 	/* first processing of this CAN frame -> adjust to private hop limit */
 	if (gwj->limit_hops && ncsx->can_gw_hops == 1)
 		ncsx->can_gw_hops = max_hops - gwj->limit_hops + 1;
 
 	nskb->dev = gwj->dst.dev;
diff --git a/net/can/isotp.c b/net/can/isotp.c
index d3f79efc9c1e..860c5221e299 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -890,11 +890,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	}
 
 	csx->can_iif = dev->ifindex;
 
 	/* set uid in tx skb to identify CF echo frames */
-	can_set_skb_uid(skb);
+	can_set_skb_uid(csx);
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* create consecutive frame */
@@ -916,11 +916,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	old_cfecho = READ_ONCE(so->cfecho);
 	if (old_cfecho)
 		pr_notice_once("can-isotp: cfecho is %08X != 0\n", old_cfecho);
 
 	/* set consecutive frame echo tag */
-	WRITE_ONCE(so->cfecho, skb->hash);
+	WRITE_ONCE(so->cfecho, csx->can_skb_uid);
 
 	/* send frame with local echo enabled */
 	can_send_ret = can_send(skb, 1);
 	if (can_send_ret) {
 		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
@@ -968,22 +968,26 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 
 static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 {
 	struct sock *sk = (struct sock *)data;
 	struct isotp_sock *so = isotp_sk(sk);
+	struct can_skb_ext *csx = can_skb_ext_find(skb);
 
 	/* only handle my own local echo CF/SF skb's (no FF!) */
 	if (skb->sk != sk)
 		return;
 
+	if (WARN_ON_ONCE(!csx))
+		return;
+
 	/* unlike isotp_rcv_fc()/isotp_rcv_cf(), not already under so->rx_lock
 	 * (no isotp_rcv() caller here), so take it ourselves
 	 */
 	spin_lock(&so->rx_lock);
 
 	/* so->cfecho may since belong to a new transfer; recheck under lock */
-	if (READ_ONCE(so->cfecho) != skb->hash)
+	if (READ_ONCE(so->cfecho) != csx->can_skb_uid)
 		goto out_unlock;
 
 	/* cancel local echo timeout */
 	hrtimer_cancel(&so->echotimer);
 
@@ -1221,11 +1225,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	csx->can_iif = dev->ifindex;
 
 	/* set uid in tx skb to identify CF echo frames */
-	can_set_skb_uid(skb);
+	can_set_skb_uid(csx);
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
@@ -1260,11 +1264,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			cf->data[SF_PCI_SZ4 + ae] = size;
 		else
 			cf->data[ae] |= size;
 
 		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
-		WRITE_ONCE(so->cfecho, skb->hash);
+		WRITE_ONCE(so->cfecho, csx->can_skb_uid);
 	} else {
 		/* send first frame */
 
 		isotp_create_fframe(cf, so, ae);
 
@@ -1277,11 +1281,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 			/* disable wait for FCs due to activated block size */
 			so->txfc.bs = 0;
 
 			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
-			WRITE_ONCE(so->cfecho, skb->hash);
+			WRITE_ONCE(so->cfecho, csx->can_skb_uid);
 		} else {
 			/* standard flow control check */
 			new_state = ISOTP_WAIT_FIRST_FC;
 
 			/* start timeout for FC */
diff --git a/net/can/raw.c b/net/can/raw.c
index 7c48ff36e6cd..7873bfc584ef 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -75,11 +75,11 @@ MODULE_ALIAS("can-proto-1");
  * storing the single filter in dfilter, to avoid using dynamic memory.
  */
 
 struct uniqframe {
 	const struct sk_buff *skb;
-	u32 hash;
+	u32 can_skb_uid;
 	unsigned int join_rx_count;
 };
 
 struct raw_sock {
 	struct sock sk;
@@ -131,16 +131,20 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	struct sock *sk = (struct sock *)data;
 	struct raw_sock *ro = raw_sk(sk);
 	enum skb_drop_reason reason;
 	struct sockaddr_can *addr;
 	struct sk_buff *skb;
+	struct can_skb_ext *csx = can_skb_ext_find(oskb);
 	unsigned int *pflags;
 
 	/* check the received tx sock reference */
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 
+	if (WARN_ON_ONCE(!csx))
+		return;
+
 	/* make sure to not pass oversized frames to the socket */
 	if (!ro->fd_frames && can_is_canfd_skb(oskb))
 		return;
 
 	if (can_is_canxl_skb(oskb)) {
@@ -163,21 +167,21 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 		}
 	}
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
-	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
+	    this_cpu_ptr(ro->uniq)->can_skb_uid == csx->can_skb_uid) {
 		if (!ro->join_filters)
 			return;
 
 		this_cpu_inc(ro->uniq->join_rx_count);
 		/* drop frame until all enabled filters matched */
 		if (this_cpu_ptr(ro->uniq)->join_rx_count < ro->count)
 			return;
 	} else {
 		this_cpu_ptr(ro->uniq)->skb = oskb;
-		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
+		this_cpu_ptr(ro->uniq)->can_skb_uid = csx->can_skb_uid;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
 		if (ro->join_filters && ro->count > 1)
 			return;
 	}
-- 
2.53.0


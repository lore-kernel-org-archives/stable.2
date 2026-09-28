Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3494D7D2B;
	Mon, 28 Sep 2026 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616679; cv=pass; b=N0px9p9iImrdC+QzrkIontu6CPm3K748Il7hfAxJSFCeaKtJHhIrpYaRCK901i87+ZUtttQL/DzDB8JXdfQpcX0uKcbx++NSFBSgjsc1pewuqD/8K03hrC+0/m2clIGJfvWjVS+kvmbSjkER/U7lEABcC4VEwoLMNfFT3+/DHD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616679; c=relaxed/simple;
	bh=8WyFQwEk2K3TlVtBzp/Ne5hy3KfpHWvSgc0QguESeg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMsK0aZ/OmebzfULae/d0tr9xmvmltYSm6Ad7T/1Yxqa1lUCBoxaIdt3ttWeV9djSDuJhwPZrwwdO4erLWCb+NNPPIDPnphRuzK48V/4yQaLhyuWlNNOIX7/COrhRmY4LUnKMWn5pPMLzEqu4L4D3UjfqAWlDN5q82nbqjlNZIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iWZDYnOd; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+1NteFfB; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iWZDYnOd";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+1NteFfB"
ARC-Seal: i=1; a=rsa-sha256; t=1790616674; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E8ZeJr+pbspz+A40FCgoJzuVSz2JY7FBiTUYS6SocrSBtdoeWGL/QzY+G7520h/UaM
    qsfzptvPYeYW0BOgKFACPbYba2It52sPmp1dbqDpt7NrxQnEXoe80Antb0XncLvk7LbV
    qsjtcZQzBoQL3142dINXGsd+RReqtPZbZ2dNu1L/7DxOw5gi5igbY+WZQWMKtVnH3HFR
    tQxy5m6FREyq8wnIgzFfL85K545AEayrboTwam2PnExWp4gRCllflDpj5stvvY7QdfIT
    BBINH9ckHmRHFg3YX/iU8qkLl3RutCRB1wD9U3TQu8ZkC0KOaDXjy4rMfkwO7NHG4d+B
    aOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790616674;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Y8XabUMxwTMUux2Yz4S/nCNWD8WlSIPoS7VuMAW9SfM=;
    b=LrjTrwbxYUvkYRGRdbp1vgNiS0nipHRrWDnurel6f4mhavZwWZukQI0EXcOWj7+C06
    mYSIWOy2W6zRDc++41sVUCQmvjNAm84+SyjpD3+ol0oajtXj7DqNa1b2roC/ISZk6c7Z
    TbQYlfGRT8HnzMCsyMr/JkvW3NH1KIKDyKaPh1THaUt8y7AFgAd9hh0u98gTRSY8J8Hg
    rzlCEVqbqErgV0nbtqa01cHOzDgg9+9nKgM4MoXHUKao9cdwZu+5uG9UQ6pud231qArS
    YwjWkxTCL2Ebo2AW4M0SJT1r78u/vQA6iZiw/5CPYS/Hwt28PQnHE9hj73tisA5RA5ti
    8gtQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790616674;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Y8XabUMxwTMUux2Yz4S/nCNWD8WlSIPoS7VuMAW9SfM=;
    b=iWZDYnOdGImBYAk3WSaXyagbfzrwBVuAQjFzke/j4tApC+BQGHooQqiODa+b89EsGi
    oSbjSEANRZf8pG0BGCjlnShuceOzHbfIj0BzFM5gds1eww5u/6z41F1f6yVlVvYueWFz
    3W8KLrj+HX4h1XUybR+ma0N/Ks1baI/KbMfISE7XtZaHCRFhz8PdeaaJx3vIL25IMliO
    nOPJPIF+x5Mu1joVWXlU/FL7mb2VqwViVq39YbZNYsWTdn8iqEfh8ZFzvitdiZ52GtQQ
    Jb3LHtJsdmClCBgyav5xaZ11sT1iCy+N+xT5Z2UFEyJOoVI1lxyARb63hEmsXZkjEUD4
    nVlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790616674;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Y8XabUMxwTMUux2Yz4S/nCNWD8WlSIPoS7VuMAW9SfM=;
    b=+1NteFfBfZO3zpHiM8aeL0yK+ZYnFX+KECs/8KyxyKVD6Qy3rQYiQFgpiZJn5Z7kaO
    4tNuYASiKIQWmtJ7amAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SHVEOjs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 19:31:14 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] can: fix unique skb identifier regression under RPS
Date: Mon, 28 Sep 2026 19:31:05 +0200
Message-ID: <20260928173105.51765-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928173105.51765-1-socketcan@hartkopp.net>
References: <20260928173105.51765-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Commit d4fb6514ff8e ("can: use skb hash instead of private variable in
headroom") introduced a regression when Receive Packet Steering (RPS)
is enabled.

When RPS is active, the network stack calculates a software hash via
skb_get_hash() before the frame reaches the CAN subsystem. Because the
flow dissector finds no L3/L4 headers in CAN frames, it generates a static
software hash for every CAN packet and sets skb->sw_hash to 1.

Since can_set_skb_uid() originally skipped generating a unique identifier
if skb->hash was already non-zero, it preserved this colliding RPS hash.
If the SLAB allocator subsequently reused the same memory address for a
different skb pointer, raw_rcv() falsely discarded the new, legitimate
frame as a duplicate.

Fix this by moving the unique identification decision logic into the CAN
skb extension (struct can_skb_ext). Introduce a new flag CAN_EXT_UID in
can_ext_flags to explicitly track whether a unique CAN skb identifier has
been assigned to the frame. can_set_skb_uid() now unconditionally
overwrites any pre-calculated network layer hashes with the unique CAN UID
if the flag is not yet set.

Additionally force the generation of a new CAN UID for CAN skbs routed via
can-gw.

Fixes: d4fb6514ff8e ("can: use skb hash instead of private variable in headroom")
Reported-by: Joerg Willmann <joe@clnt.de>
Closes: https://lore.kernel.org/linux-can/2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de/
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---
v2: We need a non-zero UID for the cfecho checks in isotp.c
    So restore the former while (!(skb->hash)) statement
---
 include/linux/can/core.h |  3 ++-
 include/linux/can/skb.h  |  4 +++-
 include/net/can.h        |  3 +++
 net/can/af_can.c         | 29 +++++++++++++++++++----------
 net/can/gw.c             |  3 +++
 net/can/isotp.c          |  4 ++--
 6 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 3287232e3cad..5c347daaeadd 100644
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
+void can_set_skb_uid(struct sk_buff *skb, struct can_skb_ext *csx);
 void can_sock_destruct(struct sock *sk);
 
 #endif /* !_CAN_CORE_H */
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index a70a02967071..ac633a049481 100644
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
+		csx->can_ext_flags = 0;
+	}
 
 	return csx;
 }
 
 static inline struct can_skb_ext *can_skb_ext_find(struct sk_buff *skb)
diff --git a/include/net/can.h b/include/net/can.h
index 6db9e826f0e0..6ea9dbaf2186 100644
--- a/include/net/can.h
+++ b/include/net/can.h
@@ -9,10 +9,13 @@
  */
 
 #ifndef _NET_CAN_H
 #define _NET_CAN_H
 
+/* flags for struct can_skb_ext::can_ext_flags */
+#define CAN_EXT_UID BIT(0) /* skb->hash contains a valid CAN skb UID */
+
 /**
  * struct can_skb_ext - skb extensions for CAN specific content
  * @can_iif: ifindex of the first interface the CAN frame appeared on
  * @can_framelen: cached echo CAN frame length for bql
  * @can_gw_hops: can-gw CAN frame time-to-live counter
diff --git a/net/can/af_can.c b/net/can/af_can.c
index ef435f22ac93..26ce523693c5 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -639,17 +639,22 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 	}
 
 	return matches;
 }
 
-void can_set_skb_uid(struct sk_buff *skb)
+void can_set_skb_uid(struct sk_buff *skb, struct can_skb_ext *csx)
 {
-	/* create non-zero unique skb identifier together with *skb */
+	if (csx->can_ext_flags & CAN_EXT_UID)
+		return;
+
+	/* Overwrite pre-calculated network hashes with a unique CAN UID */
+	skb->hash = 0;
 	while (!(skb->hash))
 		skb->hash = atomic_inc_return(&skbcounter);
 
 	skb->sw_hash = 1;
+	csx->can_ext_flags |= CAN_EXT_UID;
 }
 EXPORT_SYMBOL(can_set_skb_uid);
 
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
@@ -660,12 +665,10 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 
 	/* update statistics */
 	atomic_long_inc(&pkg_stats->rx_frames);
 	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
-	can_set_skb_uid(skb);
-
 	rcu_read_lock();
 
 	/* deliver the packet to sockets listening on all devices */
 	matches = can_rcv_filter(net->can.rx_alldev_list, skb);
 
@@ -685,51 +688,57 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 }
 
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
 
+	can_set_skb_uid(skb, csx);
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
 
+	can_set_skb_uid(skb, csx);
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
 
+	can_set_skb_uid(skb, csx);
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
 }
 
 /* af_can protocol functions */
diff --git a/net/can/gw.c b/net/can/gw.c
index d9912dea738b..7b49ff6d9c8d 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -526,10 +526,13 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	}
 
 	/* put the incremented hop counter in the cloned skb */
 	ncsx->can_gw_hops = csx->can_gw_hops + 1;
 
+	/* force a new CAN UID generation for the routed frame */
+	ncsx->can_ext_flags = csx->can_ext_flags & ~CAN_EXT_UID;
+
 	/* first processing of this CAN frame -> adjust to private hop limit */
 	if (gwj->limit_hops && ncsx->can_gw_hops == 1)
 		ncsx->can_gw_hops = max_hops - gwj->limit_hops + 1;
 
 	nskb->dev = gwj->dst.dev;
diff --git a/net/can/isotp.c b/net/can/isotp.c
index d3f79efc9c1e..416ca3293efa 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -890,11 +890,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	}
 
 	csx->can_iif = dev->ifindex;
 
 	/* set uid in tx skb to identify CF echo frames */
-	can_set_skb_uid(skb);
+	can_set_skb_uid(skb, csx);
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* create consecutive frame */
@@ -1221,11 +1221,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	csx->can_iif = dev->ifindex;
 
 	/* set uid in tx skb to identify CF echo frames */
-	can_set_skb_uid(skb);
+	can_set_skb_uid(skb, csx);
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
-- 
2.53.0


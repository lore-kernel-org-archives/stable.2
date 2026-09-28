Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB34BCABA;
	Mon, 28 Sep 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614810; cv=pass; b=QA1Jh5LEocsV/+hm+wL1f9edLk2a2bL15+NIbtKkKQx9U4X0BVdQ5/L/RJ0OcQNDWsV1p65WEMXuKZPaXcNyvlEv75Nc4nl0KHAm709oIyJMnJFMpNyRg7Acx63/N/Yp4drTGWGdfSlaBC9NDgZQWWg3rfNciu1XWCHEmZiYLQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614810; c=relaxed/simple;
	bh=HeDKDtxlwf/notYH/NzgDoKkrgZt/Nvxn1gX9XHFuCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gg+V0p7gfjk1WC285Jt7MIoyvN9xLQWn9vQD5edIu2GHSwcbIiUgQEKbMCuEfeTRaFJ0hRSJLgBm4+c8blRUUjH3991KIn1RRVCOQwWJGWTp7eb2JsWwGRdNXOr2HJoimyk4IILb0pO+YRsVwACw0+hyqH15+bgDATlgxEmln5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iJcRB8Q4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/Zi/Bsyt; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iJcRB8Q4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="/Zi/Bsyt"
ARC-Seal: i=1; a=rsa-sha256; t=1790614804; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hWPGWxPvwme4lJG+tyW3ab5n33ghFs3cD3ml53/gEMvfCWqtXLi09s1Pg16Fwjm8Gx
    OY7MsuTdUZ7rwkfmKyEgERR75ksKaniXUwjccjLORP3xqM2RR2El1TO4dwnEIr7PsFjD
    efbbShOxPWZDUp700yVuLFsIxvjNlq7CqaL12oCCTbd/LgUyRATxmNddNfGtTAyR5Kpk
    FWFkiLvNcTpwwC7A8Jyia8BRXj1bxxke30BVYnOwbJoJeVl3oAgeovDHWuMYvFlSXxre
    d7tE6iNiMFM7DpYicAFE75O4xAsfQ8cCL/G4IGtjylLcSh5sZInE4GkLGBLhD0f7N//j
    LTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790614804;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=sz0bKCaKbBn+8dnUTZ+2Tw2ejyOZRB7SLrQ9ntggP9I=;
    b=qu22aPGjy+CJ/8npNUt1plI/HPxBOyCOGIP4stCNqFlMK9+zHwzBeQCdJLykQtVTOm
    V+tMhBbWNIhtfubGhorlhIkTIoZuE2Hji/MlMqlfKTYXbVAmDliQwIrNfcc/GFV7SSPC
    d98FtyaInMFJWmK2Xa5ntsqnvzrGurWi9ZoVrh55aSjy6sFc8SqOh5YNBVnmOuJlgBZF
    DF84xo6LnsluRmxXpI0xM69KTlEAXb/J8OP1ks2AK4qURDnyGVez4DRpzzzQcwSN/dVM
    8vQ7I+kfEem1INqCE/XXqOwOZvhX3ilBOFJjIIBe0XtajFlkOYgyrMxNwofXHz/Ng9S3
    s4oQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790614804;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=sz0bKCaKbBn+8dnUTZ+2Tw2ejyOZRB7SLrQ9ntggP9I=;
    b=iJcRB8Q4/LK5QMxJt14XtzMLf/6gpIUQe4u7qHoGZajI7WX7nbz5D0B1fozPFdmNYf
    InOlN4ycQeFB6CLU8G58SlPMJxigu5Fcv/d3pIkQ7K/XAkKKPp+y5TK4Ftlsn23qs7D5
    PlUflckC89zbknxhrx/a+2U9ojBrIKjc0bAvmlBCjnxoQ/7qQVnWLSXwEFfhuTffj/4q
    xn3lAkaYesTJ6KKxCJwttuh0Hi2eB/n6h5neX5AjGkU4/9WkrAqP9+AxT3Qw4o+xQu62
    sah4zQk1G2zpT/+RPG/CGjE69W8+aqHwkkDRy6ushoM61sdk/7RBsTp8xliR2DoIWSmO
    Ff/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790614804;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=sz0bKCaKbBn+8dnUTZ+2Tw2ejyOZRB7SLrQ9ntggP9I=;
    b=/Zi/Bsyte3KLLgx1Zepv/Ag/TrKLoLZBIEfXaUjYjn/v9WglJINP1qbpTJu6Vb9FMZ
    UHF11OuTh16sQDGj5ZAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SH04Ofj
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 19:00:04 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	=?UTF-8?q?J=C3=B6rg=20Willmann?= <joe@clnt.de>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] can: fix unique skb identifier regression under RPS
Date: Mon, 28 Sep 2026 18:59:27 +0200
Message-ID: <20260928165927.31667-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928165927.31667-1-socketcan@hartkopp.net>
References: <20260928165927.31667-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Reported-by: Jörg Willmann <joe@clnt.de>
Closes: https://lore.kernel.org/linux-can/2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de/
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/core.h |  3 ++-
 include/linux/can/skb.h  |  4 +++-
 include/net/can.h        |  3 +++
 net/can/af_can.c         | 30 ++++++++++++++++++------------
 net/can/gw.c             |  3 +++
 net/can/isotp.c          |  4 ++--
 6 files changed, 31 insertions(+), 16 deletions(-)

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
index ef435f22ac93..f3189206e1c4 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -639,17 +639,19 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 	}
 
 	return matches;
 }
 
-void can_set_skb_uid(struct sk_buff *skb)
+void can_set_skb_uid(struct sk_buff *skb, struct can_skb_ext *csx)
 {
-	/* create non-zero unique skb identifier together with *skb */
-	while (!(skb->hash))
-		skb->hash = atomic_inc_return(&skbcounter);
+	if (csx->can_ext_flags & CAN_EXT_UID)
+		return;
 
+	/* Overwrite pre-calculated network hashes with a unique CAN UID */
+	skb->hash = atomic_inc_return(&skbcounter);
 	skb->sw_hash = 1;
+	csx->can_ext_flags |= CAN_EXT_UID;
 }
 EXPORT_SYMBOL(can_set_skb_uid);
 
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
@@ -660,12 +662,10 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 
 	/* update statistics */
 	atomic_long_inc(&pkg_stats->rx_frames);
 	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
-	can_set_skb_uid(skb);
-
 	rcu_read_lock();
 
 	/* deliver the packet to sockets listening on all devices */
 	matches = can_rcv_filter(net->can.rx_alldev_list, skb);
 
@@ -685,51 +685,57 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
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


Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A65421233;
	Tue, 29 Sep 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716051; cv=pass; b=aMPl7Zp0MG5dcS0JI9R/C7jeny0+7yo/NrG22wqt02N/oM2IVUPbNKNPFIUp//Omb+Uujsa2bntORBN6Yls484fkXVVWOhE4GmpfHpcbnmv60p3eHo73xKK8AbLtGwKr4KkfuGIxGDbRL7iQDM8TteoW9XSlkE9IAP6pRVEVJtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716051; c=relaxed/simple;
	bh=MFbSnacQfYmnpq4SwCoh6cde9xZ2Zn4ytf7dPwlSLHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jufDwW2vMP6kwiivGRphJMRuJgeOEWabRmSlFU47t7XHOESHJeK5UC2MUvuePSz9yK5YWL5Dd65pyuvQ1KND/rKx2KzBe9xhI3u28riZfwmPeNOb3oF7E0v7pu6oKCH3iI6IJUTucR1FhF08nChOzB8bqXXpQAs4oVFAyofteYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=fs0pBzxC; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="fs0pBzxC"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A0B6E2007CD;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqi+HQlYDL1hPbx/zaqO/LMInXL+zmsGbP7fXtBQkVA=;
	b=fs0pBzxCKvo1EKquaJAUqwf80r+zIlyTfX790LYlppXIw3jc2vG/dQzrS4mFZbKuRoMofK
	Vd3DE25RvcNFjbuogK/qI58YNHNvykTtAElFUWa+wAKG9HwBZ8wRqjrQAgeE70AO9SLKTk
	pp2rU7Y8hSAV642JgOieas/grRraju6bWJck7aCc+hbDiFqjXA4VU2p7CgW6ckSKvd1Kav
	LWwlEchVKoDgUxG+ffgkiAr52SHv7YYiSm2ONeoiG/nQlZG5VpzM2ANWzK6o2jM4bw/XFq
	Boopqp9Jq7fUti5dL8QPBO0BSyETVIn3SJPZOG4/QncsKx37q+LH8iMWg2w8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqi+HQlYDL1hPbx/zaqO/LMInXL+zmsGbP7fXtBQkVA=;
	b=J1avBveXI8tHp++v46Ur2X02oLMyFZlZ6Dm6UEuvAk+XwGCxvhEI2h3YN3JYsxcTC9Ccmg
	MzsxOBeaB1X10+kEsSCa/LmQ+B2Ta7VxtFQjdpZDs3Sq9TYRRAGQBOwEonQz5bKSXfhvHA
	minLC6Wcjkq1ybNf27yj0G0uEhIwl6Ea16sGEvu7GS9cgJEhfy4rnsBJaq0yxeFpTBY+vE
	DACq6K14oxe8SZTyn4jfEQyMlJOP6TOh4PdgJFKT2ThdZSoQjqx4qgifzPKh+lbg69t6rI
	36NFIKDQETKAHLZ7kktdnT9powvEnlRbuM3lfTd/kINXKOUM2t5IrNL++Ghe5w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=Fdz9BSdHDD33N+gEI2WKT+P6FQJ4GFCgnqgVOx51dfVdXEp9Q0Q4TdNMLZiCmwvhqJOW53
	BJxdkmhosGwrpgstDoIREUERTFTj7qc2BZujLh0oS7WVZRRDa/wnGZNx2CNN7ybmiJiGHi
	0slxfBYqmln+UyPfWmj1AKyx/fOXAICG71AsTFErtsDQBAGs/cdtRFBVxcseopL/hgdH/4
	gP36vktQbZLS5MdvMsOeHEO0sMIlAM7nlEoXk5Cnx6p31Mjc8O+Sz0cBp5K/vNJESfQA/W
	psmzFZo/Lleh1w6H21UkgGHg9sYmawHo1o6G0mkjs8e1eZCHKtlIubL50m7nQw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3h-1Y;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 38ECC5B4CD5;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 05/16] can: fix unique skb identifier regression under RPS
Date: Tue, 29 Sep 2026 22:43:55 +0200
Message-ID: <20260929210700.1183036-6-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20260929163424.16382-4-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/vxcan.c  |  3 +++
 include/linux/can/core.h |  3 ++-
 include/linux/can/skb.h  |  4 +++-
 include/net/can.h        |  2 ++
 net/can/af_can.c         | 50 +++++++++++++++++++++++++++++-----------
 net/can/gw.c             |  3 +++
 net/can/isotp.c          | 16 ++++++++-----
 net/can/raw.c            | 10 +++++---
 8 files changed, 66 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 9e2e25d02471..51148a81d1d9 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -79,6 +79,9 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
 
 	/* reset CAN GW hop counter */
 	csx->can_gw_hops = 0;
+	/* start with new CAN skb UID in the other namespace */
+	csx->can_skb_uid = 0;
+
 	skb->pkt_type   = PACKET_BROADCAST;
 	skb->dev        = peer;
 	skb->ip_summed  = CHECKSUM_UNNECESSARY;
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 3287232e3cad..2de74c2b78b6 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -17,6 +17,7 @@
 #include <linux/can.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <net/can.h>
 
 #define DNAME(dev) ((dev) ? (dev)->name : "any")
 
@@ -58,7 +59,7 @@ extern void can_rx_unregister(struct net *net, struct net_device *dev,
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
@@ -43,8 +43,10 @@ static inline struct can_skb_ext *can_skb_ext_add(struct sk_buff *skb)
 	struct can_skb_ext *csx = skb_ext_add(skb, SKB_EXT_CAN);
 
 	/* skb_ext_add() returns uninitialized space */
-	if (csx)
+	if (csx) {
 		csx->can_gw_hops = 0;
+		csx->can_skb_uid = 0;
+	}
 
 	return csx;
 }
diff --git a/include/net/can.h b/include/net/can.h
index 6db9e826f0e0..2b8af2598732 100644
--- a/include/net/can.h
+++ b/include/net/can.h
@@ -17,12 +17,14 @@
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
index ef435f22ac93..dc27ace43719 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -641,13 +641,10 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
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
 
@@ -662,8 +659,6 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	atomic_long_inc(&pkg_stats->rx_frames);
 	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
-	can_set_skb_uid(skb);
-
 	rcu_read_lock();
 
 	/* deliver the packet to sockets listening on all devices */
@@ -687,8 +682,9 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
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
 
@@ -696,6 +692,14 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		return NET_RX_DROP;
 	}
 
+	/* create unshared CAN skb_extension for netem/mirred skb clones */
+	csx = skb_ext_add(skb, SKB_EXT_CAN);
+	if (unlikely(!csx)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+		return NET_RX_DROP;
+	}
+
+	can_set_skb_uid(csx);
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
 }
@@ -703,8 +707,9 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
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
 
@@ -712,6 +717,14 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		return NET_RX_DROP;
 	}
 
+	/* create unshared CAN skb_extension for netem/mirred skb clones */
+	csx = skb_ext_add(skb, SKB_EXT_CAN);
+	if (unlikely(!csx)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+		return NET_RX_DROP;
+	}
+
+	can_set_skb_uid(csx);
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
 }
@@ -719,8 +732,9 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
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
 
@@ -728,6 +742,14 @@ static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		return NET_RX_DROP;
 	}
 
+	/* create unshared CAN skb_extension for netem/mirred skb clones */
+	csx = skb_ext_add(skb, SKB_EXT_CAN);
+	if (unlikely(!csx)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+		return NET_RX_DROP;
+	}
+
+	can_set_skb_uid(csx);
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
 }
diff --git a/net/can/gw.c b/net/can/gw.c
index d9912dea738b..54bb5bd3242a 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -528,6 +528,9 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	/* put the incremented hop counter in the cloned skb */
 	ncsx->can_gw_hops = csx->can_gw_hops + 1;
 
+	/* force a new CAN UID generation for the routed frame */
+	ncsx->can_skb_uid = 0;
+
 	/* first processing of this CAN frame -> adjust to private hop limit */
 	if (gwj->limit_hops && ncsx->can_gw_hops == 1)
 		ncsx->can_gw_hops = max_hops - gwj->limit_hops + 1;
diff --git a/net/can/isotp.c b/net/can/isotp.c
index d3f79efc9c1e..860c5221e299 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -892,7 +892,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	csx->can_iif = dev->ifindex;
 
 	/* set uid in tx skb to identify CF echo frames */
-	can_set_skb_uid(skb);
+	can_set_skb_uid(csx);
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
@@ -918,7 +918,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		pr_notice_once("can-isotp: cfecho is %08X != 0\n", old_cfecho);
 
 	/* set consecutive frame echo tag */
-	WRITE_ONCE(so->cfecho, skb->hash);
+	WRITE_ONCE(so->cfecho, csx->can_skb_uid);
 
 	/* send frame with local echo enabled */
 	can_send_ret = can_send(skb, 1);
@@ -970,18 +970,22 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
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
@@ -1223,7 +1227,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	csx->can_iif = dev->ifindex;
 
 	/* set uid in tx skb to identify CF echo frames */
-	can_set_skb_uid(skb);
+	can_set_skb_uid(csx);
 
 	so->tx.len = size;
 	so->tx.idx = 0;
@@ -1262,7 +1266,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			cf->data[ae] |= size;
 
 		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
-		WRITE_ONCE(so->cfecho, skb->hash);
+		WRITE_ONCE(so->cfecho, csx->can_skb_uid);
 	} else {
 		/* send first frame */
 
@@ -1279,7 +1283,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			so->txfc.bs = 0;
 
 			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
-			WRITE_ONCE(so->cfecho, skb->hash);
+			WRITE_ONCE(so->cfecho, csx->can_skb_uid);
 		} else {
 			/* standard flow control check */
 			new_state = ISOTP_WAIT_FIRST_FC;
diff --git a/net/can/raw.c b/net/can/raw.c
index 7c48ff36e6cd..7873bfc584ef 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -77,7 +77,7 @@ MODULE_ALIAS("can-proto-1");
 
 struct uniqframe {
 	const struct sk_buff *skb;
-	u32 hash;
+	u32 can_skb_uid;
 	unsigned int join_rx_count;
 };
 
@@ -133,12 +133,16 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
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
@@ -165,7 +169,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
-	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
+	    this_cpu_ptr(ro->uniq)->can_skb_uid == csx->can_skb_uid) {
 		if (!ro->join_filters)
 			return;
 
@@ -175,7 +179,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 			return;
 	} else {
 		this_cpu_ptr(ro->uniq)->skb = oskb;
-		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
+		this_cpu_ptr(ro->uniq)->can_skb_uid = csx->can_skb_uid;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
 		if (ro->join_filters && ro->count > 1)
-- 
2.53.0


Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09DF3F58CA
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661248; cv=pass; b=cggESnUx0NIsDlavx2PDACb/Bmjrt6QgroVtLlnhZA7j5PuHNPtrfLj+i25l524ZmlLxWet+Fx2yRviGSas13tPrPI5mhcFIZftF9tCSPMHukiPG53b1HMDCIA53nZMDvopQNeJo/AB4z+V7tQz3ln2OUGGC0a7AzjxEIjfL86Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661248; c=relaxed/simple;
	bh=r6kvL+3glWsKWZWgU7uDYFeiMtSqojHGpEVltMjkhJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZlUMWczKm22YXwuGvFKPdD0sVTdTZyfwruSZ47rHCQ+CzXcyhduCF3jqMWroUylPO4qeBE+0ewM6ppwK9GDdgy6xTflvfhMdbacW1WGwwVbjSFzLhWLOcEYshLtPvkqyJY7FcV2JrypM/aM+O9CI8D7DLzqXSftmNgjh004heQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TterVuNG; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=1iAavmM3; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TterVuNG";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1iAavmM3"
ARC-Seal: i=1; a=rsa-sha256; t=1787660873; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=t2Al4ZFkfAiU0xmOQXBgmZGAKvIcK+tMgPq/uf4iH9DOUP1tMgXX3oBWu74F1W8+f1
    SVSDH6pTNi8veJpZwnV3SUOw9dhHjjFfs/hJzVsvbrHrAdRLBlOKkQAzZDmVZxKt7uUt
    PbLsXwzA+UaQwzncDMaKrbisxOpU1H+lVR0yNOcL1O4b9JGNPJKLxwXC8ZMlsabc4ytL
    ufc7G64wdJM1n8dGeMj8jrJcEhGuzmnjsP1jH3cR5oajtT2J0k0FhqQZyeD6Bymgqw/8
    zF8esOrkKsP6yJeQjT2yGqv7PAqYqB140P/YgGl7Q1v97yipAkbW4XkpD8MnKLVleGaA
    cpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787660873;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KdvmskEh0TUJIr3xsG++UMSJYgJgtKLSUWxMfroybPs=;
    b=b/v869nb6GTYxxmbLlH2uylwUaYZPq6ESV59NbEd91unEbmfzKHco+kAsLmh+CoaPV
    /LTDBslSm+QnXGuaJFkSAcKQUAYzdNnf/VFtX58OTssI4U4PS9qKXETfDGvfHgDuxJVY
    lwsjQCLtzGSC6r3E1fZS+KZtvgXe0/rlaaAlWCUzTzqGCR4lOSg0j4Wn1k9ugng15V72
    sJNWVAbHMjE8b+5ls7Ct9mL6j4DKr2f1E/HhvgxM9VXjBXN4QbcfrW/MYzlZkDpG4gDa
    Co89loBGmhopERhkZFtlDz9GyAHSJA3hIdn2XrPXqpFK0Kv/Sck627i3NHBT3Cc+pUGA
    Rtew==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787660873;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KdvmskEh0TUJIr3xsG++UMSJYgJgtKLSUWxMfroybPs=;
    b=TterVuNGkxfuu1Q0rWHmQvr7C5s+b2R2tDiKrqizWT/L+WqPKn2I8jhfUQA0+/Rd8a
    lRyXL4AYADFtq4LXtWhlZaligwPj/rO/2jWeGTRWDoL3RuKw6057jXxxZkF5qn+bl/TV
    Qth+r1N0q8E9FhdMVmLKunvgNGiv63iWxn5eVMkBAQkArRWeNyHD92H1AejUHabvFj1/
    83NgeeO4+KQv+MwehYxOcUIyan6v1QrsdhBVocxQZkGi80+EBtRi2Ns5baJ2kKdX/8QZ
    7mrz2Mdyz+pHDde+FBeGO6gzxsNH7t9Ycuf6/PaAcHh1G9SrBJUq6rQMydAs4O8Kh6mD
    O+nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787660873;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KdvmskEh0TUJIr3xsG++UMSJYgJgtKLSUWxMfroybPs=;
    b=1iAavmM3LJWWWnLYcLyUK6X0LfTYPV3YkAmmmlZ59PkOfTuqyWdLU0HYX4lijCmfOh
    HnkTpDmed6MuYFDcFQDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727PCRrkVb
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Aug 2026 14:27:53 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y 1/2] can: use skb hash instead of private variable in headroom
Date: Tue, 25 Aug 2026 14:27:12 +0200
Message-ID: <20260825122715.3884-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825122715.3884-1-socketcan@hartkopp.net>
References: <202608250013.6e9c30257cf35cff@kernel.org>
 <20260825122715.3884-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit d4fb6514ff8ed6912a71294e6b66a5d59ee88007 upstream.

The can_skb_priv::skbcnt variable is used to identify CAN skbs in the RX
path analogue to the skb->hash.

As the skb hash is not filled in CAN skbs move the private skbcnt value to
skb->hash and set skb->sw_hash accordingly. The skb->hash is a value used
for RPS to identify skbs. Use it as intended.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260201-can_skb_ext-v8-1-3635d790fe8b@hartkopp.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c |  2 --
 drivers/net/can/slcan.c   |  1 -
 include/linux/can/core.h  |  1 +
 include/linux/can/skb.h   |  3 ---
 net/can/af_can.c          | 14 +++++++++++---
 net/can/bcm.c             |  2 --
 net/can/isotp.c           |  3 ---
 net/can/j1939/socket.c    |  1 -
 net/can/j1939/transport.c |  2 --
 net/can/raw.c             |  7 +++----
 10 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index e59d5cbb644a..ec624cfc1b07 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -201,11 +201,10 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
 }
@@ -232,11 +231,10 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
 	return skb;
 }
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index d42ec7d1bc14..2ace2b735c20 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -211,11 +211,10 @@ static void slc_bump(struct slcan *sl)
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, &cf, sizeof(struct can_frame));
 
 	sl->dev->stats.rx_packets++;
 	sl->dev->stats.rx_bytes += cf.len;
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 5fb8d0e3f9c1..3287232e3cad 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -56,8 +56,9 @@ extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      canid_t can_id, canid_t mask,
 			      void (*func)(struct sk_buff *, void *),
 			      void *data);
 
 extern int can_send(struct sk_buff *skb, int loop);
+void can_set_skb_uid(struct sk_buff *skb);
 void can_sock_destruct(struct sock *sk);
 
 #endif /* !_CAN_CORE_H */
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index d311bc369a39..f887eb21e178 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -41,17 +41,15 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev,
  */
 
 /**
  * struct can_skb_priv - private additional data inside CAN sk_buffs
  * @ifindex:	ifindex of the first interface the CAN frame appeared on
- * @skbcnt:	atomic counter to have an unique id together with skb pointer
  * @frame_len:	length of CAN frame in data link layer
  * @cf:		align to the following CAN frame at skb->data
  */
 struct can_skb_priv {
 	int ifindex;
-	int skbcnt;
 	unsigned int frame_len;
 	struct can_frame cf[];
 };
 
 static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
@@ -105,11 +103,10 @@ static inline bool can_skb_headroom_valid(struct net_device *dev,
 
 	/* af_packet does not apply CAN skb specific settings */
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		/* init headroom */
 		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 		/* perform proper loopback on capable devices */
 		if (dev->flags & IFF_ECHO)
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 85b01dea76df..95b7cc548675 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -639,10 +639,20 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 	}
 
 	return matches;
 }
 
+void can_set_skb_uid(struct sk_buff *skb)
+{
+	/* create non-zero unique skb identifier together with *skb */
+	while (!(skb->hash))
+		skb->hash = atomic_inc_return(&skbcounter);
+
+	skb->sw_hash = 1;
+}
+EXPORT_SYMBOL(can_set_skb_uid);
+
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
 	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = dev_net(dev);
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
@@ -650,13 +660,11 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 
 	/* update statistics */
 	atomic_long_inc(&pkg_stats->rx_frames);
 	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
-	/* create non-zero unique skb identifier together with *skb */
-	while (!(can_skb_prv(skb)->skbcnt))
-		can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);
+	can_set_skb_uid(skb);
 
 	rcu_read_lock();
 
 	/* deliver the packet to sockets listening on all devices */
 	matches = can_rcv_filter(net->can.rx_alldev_list, skb);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 2cf63940f6a9..235156223394 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -336,11 +336,10 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 	if (!skb)
 		goto out;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
 	/* send with loopback */
 	skb->dev = dev;
@@ -1575,11 +1574,10 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 		kfree_skb(skb);
 		return -ENODEV;
 	}
 
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 	err = can_send(skb, 1); /* send with loopback */
 	dev_put(dev);
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 34939744dd41..b6b301f54e31 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -216,11 +216,10 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 		return 1;
 	}
 
 	can_skb_reserve(nskb);
 	can_skb_prv(nskb)->ifindex = dev->ifindex;
-	can_skb_prv(nskb)->skbcnt = 0;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
 	skb_put_zero(nskb, so->ll.mtu);
@@ -771,11 +770,10 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		return;
 	}
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* create consecutive frame */
@@ -1067,11 +1065,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index ec2927566cf3..540836c4964d 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -887,11 +887,10 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	if (!skb)
 		goto failure;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret < 0)
 		goto free_skb;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 55bbcf73c873..74638cf04172 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -610,11 +610,10 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 		return ERR_PTR(-ENOMEM);
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	/* skb->cb must be large enough to hold a j1939_sk_buff_cb structure */
 	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(*re_skcb));
@@ -1549,11 +1548,10 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 		return NULL;
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
 	session = j1939_session_new(priv, skb, size);
 	if (!session) {
diff --git a/net/can/raw.c b/net/can/raw.c
index b489689ada33..ffbb622f8842 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -72,12 +72,12 @@ MODULE_ALIAS("can-proto-1");
  * list containing only one item.  This common case is optimized by
  * storing the single filter in dfilter, to avoid using dynamic memory.
  */
 
 struct uniqframe {
-	int skbcnt;
 	const struct sk_buff *skb;
+	u32 hash;
 	unsigned int join_rx_count;
 };
 
 struct raw_sock {
 	struct sock sk;
@@ -134,22 +134,22 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (!ro->fd_frames && oskb->len != CAN_MTU)
 		return;
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
-	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
+	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
 		if (ro->join_filters) {
 			this_cpu_inc(ro->uniq->join_rx_count);
 			/* drop frame until all enabled filters matched */
 			if (this_cpu_ptr(ro->uniq)->join_rx_count < ro->count)
 				return;
 		} else {
 			return;
 		}
 	} else {
 		this_cpu_ptr(ro->uniq)->skb = oskb;
-		this_cpu_ptr(ro->uniq)->skbcnt = can_skb_prv(oskb)->skbcnt;
+		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
 		if (ro->join_filters && ro->count > 1)
 			return;
 	}
@@ -827,11 +827,10 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!skb)
 		goto put_dev;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;
 
-- 
2.53.0


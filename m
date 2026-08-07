Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482D4463B8E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089152; cv=pass; b=b7uLYMgodG8v1nPOYIfrg8FlugY0aIaS4oAY6dpsdEhQcs/GpmCSBNG2RTxE7W4Owpqt2dNQkETOW3ov1m02U2EHnrG3OXYVYbGdTccGmPEX+GK2AvUOIGrpTfeOvhAe32ZTxIpxJn9yBRKpFNe0/J8MY9mOM+q1eGPqNvUP4Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089152; c=relaxed/simple;
	bh=bGhnzJIuibg23XVDf0mBpFpKvV300LF18ajGyx+kKe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGCbYsxjJcBDIl1SpSrTvNoN2R1nOl1h3C/xSdg9xw4Eg+n0fbUGszJmYcOcxMRLC8tESKRCSn5MaEhz6deWZ2nvGN74vlNzvPD1K9gKAW1YqIW0936ReyCxuIJeCcqGa0FVRWSFlF/oyMkLdwTgX9sw2pidxFfDogF8Ib7v9e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CRKuve37; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=EqV5JxLb; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CRKuve37";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EqV5JxLb"
ARC-Seal: i=1; a=rsa-sha256; t=1786089140; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m80LXMPEbuJ9sgUON40eS3NNW13LN82wkxFpJAwHkd7JTE4/TZBFKtrp2eT0wI33ry
    JQ0I2xlREq1sPQCA5ZTBfBItSNc/fibjQjEErOOWyh+VxgGd4cFUamgDfl1X4d2Rp3d8
    2vPu8TBUiI4y15TJqYQHLNkvcTzqNJ9l8Wzs6CZlu4hNvJwaazXnrBYmPD+Bg7BxaRJb
    N/VbQJYah3hsh53uSn+48dAtia5/6SHw6HhW8amfULHnEmAlWFBrpOrxykpTJKXCBYDY
    HXhb7SHwQk/1yQKDxFJxxvCOgoSo9paUwk8x72ENW+2WIg2fKX1A/dnnOUVhY14GTH+4
    8xOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786089140;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WkOubjviqdcAcDpPAtQm+tWziqnRZozDDWAW26oSnp4=;
    b=AwFdltPf6bdaRKBTFPvoKE708KnKnOd9PRgRW/PqOHbra9n7tYcrwI4o9Pdst8tUbw
    mZX01JO4GsAa+9uy3dgQPMZ/AcDNQZUg3ChwQ4aCK15NcRRBNJyZNViwT49anRwIO+ez
    MoeuuCmafMJeo6+p8CPQk+hwTbplxLczH2rJytocCA7367aK4NsvuF+RVL0hVuz3lv65
    vZKIZhYQDviRCzCwqzq6LMBPWuIjvbe1cZt1GSABl1xrLwj4IYY+7/dzBGuXKES5Kunh
    HBvtlgFNfdHEkqssuOK3TPZ+ow/BUrRs8uWw1I+4CjcLYAiwGqYuIufDIx6tAPEmeVxh
    BxEg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786089140;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WkOubjviqdcAcDpPAtQm+tWziqnRZozDDWAW26oSnp4=;
    b=CRKuve37vKmewVen9e3A6jxKudnDfdmwQPTR1rfT0NTgUyUfbtoA5/uKvg8+vp5gt8
    ReltQs43U3Wh+TBWXBtETtMFiJLckCeMc55s5RZDoZJzA6FMBS1Q0RsRlNTiuQI96hLY
    jnn0lppLho1ZRmNqmlxADeHmLFWFVteiDbne6B1gVgibeUcwaYSgJ3SRdWmxwwC/17vP
    OBT4X/MiDKE9SlCMunGUUmbPjxgPIspiGauKhHq3vTrusgfQffRe7Pn+pdSqHBJUCFSs
    +IpwZjq+uEN8F1qPRSUiwzVsfi2jvlZ0MIFIRNLP82hTdfA/pv+1hqbGznC6Q67GuB94
    bxiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786089140;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WkOubjviqdcAcDpPAtQm+tWziqnRZozDDWAW26oSnp4=;
    b=EqV5JxLb8kfclX2/YgRWx8mgWluOWiUXdZ9rVb1PNN/yQfcTgSXvAzve7BOrQ91FQi
    VIIfhG+T9uSuK1jRJpCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K528192777qKFbv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 7 Aug 2026 09:52:20 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.18.y v2 1/2] can: use skb hash instead of private variable in headroom
Date: Fri,  7 Aug 2026 09:52:10 +0200
Message-ID: <20260807075211.104571-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080551-roundworm-petite-bf48@gregkh>
References: <2026080551-roundworm-petite-bf48@gregkh>
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
 include/linux/can/core.h  |  1 +
 include/linux/can/skb.h   |  2 --
 net/can/af_can.c          | 14 +++++++++++---
 net/can/bcm.c             |  2 --
 net/can/isotp.c           |  3 ---
 net/can/j1939/socket.c    |  1 -
 net/can/j1939/transport.c |  2 --
 net/can/raw.c             |  7 +++----
 9 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 3ebd4f779b9b..0da615afa04d 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -200,11 +200,10 @@ static void init_can_skb_reserve(struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->skbcnt = 0;
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
@@ -310,11 +309,10 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 
 	/* af_packet does not apply CAN skb specific settings */
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		/* init headroom */
 		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 		/* perform proper loopback on capable devices */
 		if (dev->flags & IFF_ECHO)
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
index 1abc25a8d144..869ea574a40a 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -47,17 +47,15 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
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
diff --git a/net/can/af_can.c b/net/can/af_can.c
index a624c04ed5c6..7a026f3a70a0 100644
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
index 76bc7f727425..a819872fddef 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -348,11 +348,10 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 	if (!skb)
 		goto out;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
 	/* send with loopback */
 	skb->dev = dev;
@@ -1619,11 +1618,10 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
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
index c21d816a5274..0f635680848f 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -231,11 +231,10 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 		return 1;
 	}
 
 	can_skb_reserve(nskb);
 	can_skb_prv(nskb)->ifindex = dev->ifindex;
-	can_skb_prv(nskb)->skbcnt = 0;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
 	skb_put_zero(nskb, so->ll.mtu);
@@ -798,11 +797,10 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		return;
 	}
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* create consecutive frame */
@@ -1104,11 +1102,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index e3ba2e9fc0e9..e56d8134938e 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -895,11 +895,10 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
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
index 9ec929bc0c0d..cadb3d3756ec 100644
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
@@ -1545,11 +1544,10 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
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
index 365559d19dc3..c397071bfa8b 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -74,11 +74,11 @@ MODULE_ALIAS("can-proto-1");
  * storing the single filter in dfilter, to avoid using dynamic memory.
  */
 
 struct uniqframe {
 	const struct sk_buff *skb;
-	int skbcnt;
+	u32 hash;
 	unsigned int join_rx_count;
 };
 
 struct raw_sock {
 	struct sock sk;
@@ -162,21 +162,21 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 		}
 	}
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
-	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
+	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
 		if (!ro->join_filters)
 			return;
 
 		this_cpu_inc(ro->uniq->join_rx_count);
 		/* drop frame until all enabled filters matched */
 		if (this_cpu_ptr(ro->uniq)->join_rx_count < ro->count)
 			return;
 	} else {
 		this_cpu_ptr(ro->uniq)->skb = oskb;
-		this_cpu_ptr(ro->uniq)->skbcnt = can_skb_prv(oskb)->skbcnt;
+		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
 		if (ro->join_filters && ro->count > 1)
 			return;
 	}
@@ -952,11 +952,10 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!skb)
 		goto put_dev;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;
-- 
2.53.0


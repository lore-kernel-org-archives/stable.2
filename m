Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019CC521890
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911159; cv=pass; b=TxF3p6iciish/ME9JfRupriMPEP+FIIePolfDgU/k9uuAq6U7GUOQn+mL0b10Ka6ePxwNb/YW6pOAPuR9T9QHXfhtu/uN+aAD4RWL6k+sd8iNsye3qI5kWgDwRUTFJJotfTK0UMzmOoqPFOtBLaWWyLWTk6a3UfJMcJmKgvVxZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911159; c=relaxed/simple;
	bh=PZ08nJEwQ+0H/bMQ7PXEMv7iQCs3tpuAL2X70x+lB6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0dFD2jP4jFjT9S2Xp07esuzIYVkesr8RvMHL+G2TbvX37tSkiMWcclq56SXv9LBOd4oKclpSRna5eE/DejJ+p5Fcs+unwk8hu56ybY5SZNzfTex8/hZR2mFpEFozAAuBxrrFsoE2rF00wgEU+cm1fjeN5C5Zi1y2XpnTIZkx9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DOVNKsF3; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3+V0jVVF; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DOVNKsF3";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3+V0jVVF"
ARC-Seal: i=1; a=rsa-sha256; t=1791911144; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dYFFHMrRErP3IAxQhI3gG4hlo9SusUf+P5NbsNChjZcPvKA3dA+HJNSunmQ+dbtxe4
    1IttyjDTGW5mRrVtK7w/kamrnKSvyHlW71EWlqqRhqji1OOVUvoXfktHP4yYXUuQFAKM
    Pfxuj+QAPUmlvURdQ1HsTA6l0+mTMW+6nNgsRc6/ls1q50zXxieMEkZTm4lLNm2qjFoI
    DLAS4JMDtWFsmO3k88Olt9tzaCiBKDFA0Y3MeAxLaOcGH8i8ZcJeCJALAMOIqM17bXga
    Ipnbs7SeIHbBxV8J4+bUydHsJpoFC/Gxvebh6DZeuK4g8vca61EweLyVziWYrMHd6ug8
    aGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791911144;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WOtg3RkxmqzWCkLmHD3A6vDnojnggYt/RmWoh+iVa78=;
    b=dmtuSw1zpuIhyxv74lS59wfOg+UEEJcDmkydRy1OT8RxMLw8LJXfwcXpcttJEpzdUV
    pkIRkzotjsO4//ZBtL07wMPz1iwPa0f+0wdsPjeliONMsgqqj8pYlZLAZUuj5itClLgp
    foA8h0mjSJT14PhLC10hJhCbAPxbN2jkdejomnM9nT7UZ+2DezQbagCf/oVeap2eky0j
    Gzi/gW5i5HTgOEHaI7ox1mecf4oDVG0XADMsgh7Kf+Ujo+DJQKAamdWVY3GkpSc0K/+N
    ecyYZ34zyDeRcVupOqlhLzK1MIvhLPkv3wMFvjw8esTNjug296PA1joLhcPwVRt+ODyQ
    v32Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791911144;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WOtg3RkxmqzWCkLmHD3A6vDnojnggYt/RmWoh+iVa78=;
    b=DOVNKsF3xL7byxHtKE/hZqweSum7OaRik7WMvKM8QFtyPik2eQA9bGzOn5wuDjBl10
    C19jwoBuvDEzB4ZUyAmq/lNmLZgUfqwgeMUrONTJdL/1hqz7zrkCH9IBM0A3vxkCqtbt
    7Ri/WvNj99+Os6vM3D9/DixjnAvYOC8uGD74yLPvHUymaBRmQFuh1ziiusl5oOucv6Ge
    X9FMejQRD5kKFcbTsb39lRQRvDoEkxLDzvWDZXKd4EmibhrXpr7w+m9gfsmghlwVWM+C
    FXKncfDVkx2bYXipEieLCs2Czwcc1OypBD7yNzcMUuoJoMG65cHjKLVkPAUg3ayMYsQv
    QhWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791911144;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WOtg3RkxmqzWCkLmHD3A6vDnojnggYt/RmWoh+iVa78=;
    b=3+V0jVVFxOvxLHAb6dzy7ninevmJia+iOJjZ7XKFddaCbcZdntK2/lAxvy2SyVz2uA
    A1ZtYr9wv5z91zVvPyCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29DH5i7ko
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Oct 2026 19:05:44 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>
Subject: [PATCH 5.10.y] can: fix unique skb identifier regression under RPS
Date: Tue, 13 Oct 2026 19:05:38 +0200
Message-ID: <20261013170538.13296-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101253-guzzler-atom-1993@gregkh>
References: <2026101253-guzzler-atom-1993@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit 7093c3b8314a4ef7405c4066a2521398c455efe7 upstream.

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

Frames whose extension is shared with another clone (e.g. via tc mirred
or netem duplicate) are given a private extension copy before the UID
is assigned, so that independently received skb clones from real CAN
interfaces (skbcnt = 0) don't end up with the same UID.
The limitation that tc mirred/netem skb duplicates might be dropped in
raw_rcv for looped back isotp echo frame skbs is accepted. There is no
valid use-case for tc mirred or netem together with isotp which is not
capable to operate on different CAN interfaces simultaneously.
For routing and modifying CAN frames together with isotp use can-gw.

can-gw and vxcan additionally clear the UID of forwarded/duplicated
frames so each newly routed frame gets its own unique identifier.

[ backport to 5.10: no CAN skb extensions available, so the UID is kept
  in struct can_skb_priv::skbcnt in the headroom (effectively reverting
  d4fb6514ff8e) and isotp is adapted accordingly. As skb clones share
  the headroom, the private extension copy for tc mirred/netem
  duplicates is not applicable. The UID resets in can-gw and vxcan are
  omitted, as writing to the shared headroom of cloned skbs would also
  alter the UID of the original skb. This keeps the pre-d4fb6514ff8e
  behaviour for routed and vxcan forwarded frames. ]

Fixes: d4fb6514ff8e ("can: use skb hash instead of private variable in headroom")
Reported-by: Joerg Willmann <joe@clnt.de>
Closes: https://lore.kernel.org/linux-can/2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/dev.c |  2 ++
 drivers/net/can/slcan.c   |  1 +
 include/linux/can/dev.h   |  1 +
 include/linux/can/skb.h   |  2 ++
 net/can/af_can.c          |  6 ++----
 net/can/bcm.c             |  2 ++
 net/can/isotp.c           | 11 +++++++----
 net/can/j1939/socket.c    |  1 +
 net/can/j1939/transport.c |  2 ++
 net/can/raw.c             |  7 ++++---
 10 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 50fd5befa6f5..b5e79d63d59b 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -692,10 +692,11 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
 }
@@ -719,10 +720,11 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
 	return skb;
 }
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index d1833aafc40c..4f1538186c3e 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -211,10 +211,11 @@ static void slc_bump(struct slcan *sl)
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, &cf, sizeof(struct can_frame));
 
 	sl->dev->stats.rx_packets++;
 	sl->dev->stats.rx_bytes += cf.can_dlc;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 83bcb1b8fa5b..41ff31795320 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -117,10 +117,11 @@ static inline bool can_skb_headroom_valid(struct net_device *dev,
 
 	/* af_packet does not apply CAN skb specific settings */
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		/* init headroom */
 		can_skb_prv(skb)->ifindex = dev->ifindex;
+		can_skb_prv(skb)->skbcnt = 0;
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 		/* perform proper loopback on capable devices */
 		if (dev->flags & IFF_ECHO)
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 6399318832cb..b2c291407d52 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -26,14 +26,16 @@
  */
 
 /**
  * struct can_skb_priv - private additional data inside CAN sk_buffs
  * @ifindex:	ifindex of the first interface the CAN frame appeared on
+ * @skbcnt:	atomic counter to have an unique id together with skb pointer
  * @cf:		align to the following CAN frame at skb->data
  */
 struct can_skb_priv {
 	int ifindex;
+	u32 skbcnt;
 	struct can_frame cf[];
 };
 
 static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
 {
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 5d6022d8c715..05066662279d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -642,14 +642,12 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 }
 
 void can_set_skb_uid(struct sk_buff *skb)
 {
 	/* create non-zero unique skb identifier together with *skb */
-	while (!(skb->hash))
-		skb->hash = atomic_inc_return(&skbcounter);
-
-	skb->sw_hash = 1;
+	while (!(can_skb_prv(skb)->skbcnt))
+		can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);
 }
 EXPORT_SYMBOL(can_set_skb_uid);
 
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
diff --git a/net/can/bcm.c b/net/can/bcm.c
index df81d97e693f..f655764aae83 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -336,10 +336,11 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 	if (!skb)
 		goto out;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
 	/* send with loopback */
 	skb->dev = dev;
@@ -1574,10 +1575,11 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 		kfree_skb(skb);
 		return -ENODEV;
 	}
 
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 	err = can_send(skb, 1); /* send with loopback */
 	dev_put(dev);
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index b79ba8c22b1a..01d5a4603663 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -285,10 +285,11 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 		return 1;
 	}
 
 	can_skb_reserve(nskb);
 	can_skb_prv(nskb)->ifindex = dev->ifindex;
+	can_skb_prv(nskb)->skbcnt = 0;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
 	skb_put_zero(nskb, so->ll.mtu);
@@ -846,10 +847,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		return;
 	}
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	/* set uid in tx skb to identify CF echo frames */
 	can_set_skb_uid(skb);
 
 	cf = (struct canfd_frame *)skb->data;
@@ -874,11 +876,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	old_cfecho = READ_ONCE(so->cfecho);
 	if (old_cfecho)
 		pr_notice_once("can-isotp: cfecho is %08X != 0\n", old_cfecho);
 
 	/* set consecutive frame echo tag */
-	WRITE_ONCE(so->cfecho, skb->hash);
+	WRITE_ONCE(so->cfecho, can_skb_prv(skb)->skbcnt);
 
 	/* send frame with local echo enabled */
 	can_send_ret = can_send(skb, 1);
 	if (can_send_ret) {
 		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
@@ -937,11 +939,11 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	 * (no isotp_rcv() caller here), so take it ourselves
 	 */
 	spin_lock(&so->rx_lock);
 
 	/* so->cfecho may since belong to a new transfer; recheck under lock */
-	if (READ_ONCE(so->cfecho) != skb->hash)
+	if (READ_ONCE(so->cfecho) != can_skb_prv(skb)->skbcnt)
 		goto out_unlock;
 
 	/* cancel local echo timeout */
 	hrtimer_cancel(&so->echotimer);
 
@@ -1159,10 +1161,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	/* set uid in tx skb to identify CF echo frames */
 	can_set_skb_uid(skb);
 
 	so->tx.len = size;
@@ -1200,11 +1203,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			cf->data[SF_PCI_SZ4 + ae] = size;
 		else
 			cf->data[ae] |= size;
 
 		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
-		WRITE_ONCE(so->cfecho, skb->hash);
+		WRITE_ONCE(so->cfecho, can_skb_prv(skb)->skbcnt);
 	} else {
 		/* send first frame */
 
 		isotp_create_fframe(cf, so, ae);
 
@@ -1217,11 +1220,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 			/* disable wait for FCs due to activated block size */
 			so->txfc.bs = 0;
 
 			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
-			WRITE_ONCE(so->cfecho, skb->hash);
+			WRITE_ONCE(so->cfecho, can_skb_prv(skb)->skbcnt);
 		} else {
 			/* standard flow control check */
 			new_state = ISOTP_WAIT_FIRST_FC;
 
 			/* start timeout for FC */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 551617b761ba..34cd4792d5d4 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -887,10 +887,11 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	if (!skb)
 		goto failure;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = ndev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret < 0)
 		goto free_skb;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index ff1a5fee7b0e..4116b5150526 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -606,10 +606,11 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 		return ERR_PTR(-ENOMEM);
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	/* skb->cb must be large enough to hold a j1939_sk_buff_cb structure */
 	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(*re_skcb));
@@ -1532,10 +1533,11 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 		return NULL;
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
 	session = j1939_session_new(priv, skb, size);
 	if (!session) {
diff --git a/net/can/raw.c b/net/can/raw.c
index db10c8758391..8bbbd9092e3a 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -72,12 +72,12 @@ MODULE_ALIAS("can-proto-1");
  * list containing only one item.  This common case is optimized by
  * storing the single filter in dfilter, to avoid using dynamic memory.
  */
 
 struct uniqframe {
+	u32 skbcnt;
 	const struct sk_buff *skb;
-	u32 hash;
 	unsigned int join_rx_count;
 };
 
 struct raw_sock {
 	struct sock sk;
@@ -133,22 +133,22 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (!ro->fd_frames && oskb->len != CAN_MTU)
 		return;
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
-	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
+	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
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
-		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
+		this_cpu_ptr(ro->uniq)->skbcnt = can_skb_prv(oskb)->skbcnt;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
 		if (ro->join_filters && ro->count > 1)
 			return;
 	}
@@ -810,10 +810,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!skb)
 		goto put_dev;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;
 
-- 
2.53.0


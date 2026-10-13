Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBFD3C5826
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911247; cv=pass; b=GX/87Yu7SnJRWk9PdYFIFX49kpZa6VLWfxts4DYuSFLOBnmL3XAU6jTmgIowko6YS3jDJBgUJaUUF7VnOYPYZtdtvSmI3WPRhzePipMt4UOBKtxMYimWH6hbD88S9DITV1iXHE+GJcuaTDmWi9D4a3dZKiB0KQCq7VL/JIYYXf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911247; c=relaxed/simple;
	bh=C0DyEYWTGz+xCLyDBj8NmIVL6aHWHsj3XiNvZ9lpZF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nN8GmuQA9B2G1lqR/ZkfS++4MjKVUEvAD9YlCv4x/30uUYXrYDZXvHf8xpEjzhQKk5YZQwaft8m4hn4z4AwJtaKzTm6ATLGTttubKRUPDP7mZz+miuHOmlrZ1RSCHcyIobZwqlt1S+i9SwyNoF4XGomw2rQIfassUhQ1blUDLbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hkb/M9Y5; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WjgKBOtr; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hkb/M9Y5";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WjgKBOtr"
ARC-Seal: i=1; a=rsa-sha256; t=1791911232; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Dxv4akU0C1NPsehdmPHV1oMLtA7g9qek4AgQUNNtnCS4Tgrw++dIgS3AaVtdgpo68S
    +gCzTHdr/TBLqgNwfcrLSV7rJSqyQZ60OtQuGbSogM74/akMYuIGpP6vmgdt33VyjcsV
    l4i7XQM2j4zJEeyd7qcWjDuWRfVRkRu+oIutfLGM3qwsSwkgO8RIkj47/Wj4ux9nrxiQ
    Ed/edodJkGcJFtfpiZ1WNIsTzr50NNT0SW5prN0QMj/GHzLfWEDTcG2HvBxzBHhCwft1
    fK48GrBuOKw+ShfVb7e+fVLO2ul9RaP2lcSBgwy3oViZRuL2x4iw9k0v3wUj0qliCcka
    OUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791911232;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eN8quXKWNNYq+6io1+FEV0c8l+rKx/m4OAbQLjKpxok=;
    b=F73msaGvurraWMBlAlISpSPVYgpFRAVLSWNHUt/uu4MDyDV4GdtcwTbnUwTIes5ndg
    re2CiUYxcBXZR6/NKI5YdrhneeoaFBcM3Ev6y8sCA4Ib+4/E3Nie6PaRTnsIwCkHrZx/
    fyG3I6WJIz1JJ6rpWzVZ6ezzY61Qd4nW32zHoPHda10IpMeHoYB4Vf/Nc4Ea2BMaq4M0
    AhKHyE/cF0p/tloP68QPFm/FhWk/vuI5xs/ORx3Kq5ikDG1Fef6gEcjdxQnRV6rCEfi9
    FDDnETuJ9Uy3+3pz+KGrVxb1AynRWveGj0b0w6lCLVucjznAueHIMCS6Rjp/3G+iOe+2
    bavA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791911232;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eN8quXKWNNYq+6io1+FEV0c8l+rKx/m4OAbQLjKpxok=;
    b=hkb/M9Y5QPewTB2e/ufom4LnW1DErmpRaFxyg+hJBbOCwq1gT5o/WW95IrObLI8TeR
    N67qFIHQ/ymG1tTDooywc5xE66pP5rzGNdc33aHUu1wDpFSaeu0u7RubKIPm2QBYHL9n
    QZzpEs8na3uDlg/Gn1cUuCa2jwPu8UV3FDISgJa30imA6Yd5DOmk5G9UmXPD90mvTojh
    lKwJ+fnOY1rKJpO3eYdlxeK0w+zT5oc7IswH0CGauqL83e4bPEaw1MSK+x/eHOftuP6y
    BxbO+0pFJmOrOk/o5kZoWUgH69baYBjqWU14Iq5G9U8o0faYohwOjVsFCF6RddjGg58q
    ITDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791911232;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eN8quXKWNNYq+6io1+FEV0c8l+rKx/m4OAbQLjKpxok=;
    b=WjgKBOtrxaP9m7JE4sat4UUgERo+sG+n1RKuG9XMnwG5Ku5nxsqmBQ5P3xiFaKHCfB
    Ul9+iWKcl3+eBCVMO4Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29DH7C7l8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Oct 2026 19:07:12 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>
Subject: [PATCH 6.6.y] can: fix unique skb identifier regression under RPS
Date: Tue, 13 Oct 2026 19:07:06 +0200
Message-ID: <20261013170706.13373-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101251-lying-swept-678d@gregkh>
References: <2026101251-lying-swept-678d@gregkh>
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

[ backport to 6.6: no CAN skb extensions available, so the UID is kept
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
 drivers/net/can/dev/skb.c |  2 ++
 include/linux/can/skb.h   |  2 ++
 net/can/af_can.c          |  6 ++----
 net/can/bcm.c             |  2 ++
 net/can/isotp.c           | 11 +++++++----
 net/can/j1939/socket.c    |  1 +
 net/can/j1939/transport.c |  2 ++
 net/can/raw.c             |  7 ++++---
 8 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 0da615afa04d..3ebd4f779b9b 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -200,10 +200,11 @@ static void init_can_skb_reserve(struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
 
 	can_skb_reserve(skb);
+	can_skb_prv(skb)->skbcnt = 0;
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
@@ -309,10 +310,11 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 
 	/* af_packet does not apply CAN skb specific settings */
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		/* init headroom */
 		can_skb_prv(skb)->ifindex = dev->ifindex;
+		can_skb_prv(skb)->skbcnt = 0;
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 		/* perform proper loopback on capable devices */
 		if (dev->flags & IFF_ECHO)
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 869ea574a40a..27d0ca115c6c 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -47,15 +47,17 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
  */
 
 /**
  * struct can_skb_priv - private additional data inside CAN sk_buffs
  * @ifindex:	ifindex of the first interface the CAN frame appeared on
+ * @skbcnt:	atomic counter to have an unique id together with skb pointer
  * @frame_len:	length of CAN frame in data link layer
  * @cf:		align to the following CAN frame at skb->data
  */
 struct can_skb_priv {
 	int ifindex;
+	u32 skbcnt;
 	unsigned int frame_len;
 	struct can_frame cf[];
 };
 
 static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 54877f06cd78..69f794e82ca6 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -640,14 +640,12 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
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
index 491495803167..fcd923c223f4 100644
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
@@ -1579,10 +1580,11 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
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
index fded419bc34f..e448cfdb1f07 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -298,10 +298,11 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 		return 1;
 	}
 
 	can_skb_reserve(nskb);
 	can_skb_prv(nskb)->ifindex = dev->ifindex;
+	can_skb_prv(nskb)->skbcnt = 0;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
 	skb_put_zero(nskb, so->ll.mtu);
@@ -869,10 +870,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		return;
 	}
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	/* set uid in tx skb to identify CF echo frames */
 	can_set_skb_uid(skb);
 
 	cf = (struct canfd_frame *)skb->data;
@@ -897,11 +899,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
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
@@ -960,11 +962,11 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	 * (no isotp_rcv() caller here), so take it ourselves
 	 */
 	spin_lock(&so->rx_lock);
 
 	/* so->cfecho may since belong to a new transfer; recheck under lock */
-	if (READ_ONCE(so->cfecho) != skb->hash)
+	if (READ_ONCE(so->cfecho) != can_skb_prv(skb)->skbcnt)
 		goto out_unlock;
 
 	/* cancel local echo timeout */
 	hrtimer_cancel(&so->echotimer);
 
@@ -1192,10 +1194,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	/* set uid in tx skb to identify CF echo frames */
 	can_set_skb_uid(skb);
 
 	so->tx.len = size;
@@ -1233,11 +1236,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			cf->data[SF_PCI_SZ4 + ae] = size;
 		else
 			cf->data[ae] |= size;
 
 		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
-		WRITE_ONCE(so->cfecho, skb->hash);
+		WRITE_ONCE(so->cfecho, can_skb_prv(skb)->skbcnt);
 	} else {
 		/* send first frame */
 
 		isotp_create_fframe(cf, so, ae);
 
@@ -1250,11 +1253,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
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
index 4841aae2fcaa..e1d6d57c921b 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -893,10 +893,11 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
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
index a262a58588c2..61f0c6b68138 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -611,10 +611,11 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 		return ERR_PTR(-ENOMEM);
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	/* skb->cb must be large enough to hold a j1939_sk_buff_cb structure */
 	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(*re_skcb));
@@ -1550,10 +1551,11 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
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
index ad4b16476743..517f075a0aec 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -73,12 +73,12 @@ MODULE_ALIAS("can-proto-1");
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
@@ -138,21 +138,21 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	    (!ro->xl_frames && can_is_canxl_skb(oskb)))
 		return;
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
-	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
+	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
 		if (!ro->join_filters)
 			return;
 
 		this_cpu_inc(ro->uniq->join_rx_count);
 		/* drop frame until all enabled filters matched */
 		if (this_cpu_ptr(ro->uniq)->join_rx_count < ro->count)
 			return;
 	} else {
 		this_cpu_ptr(ro->uniq)->skb = oskb;
-		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
+		this_cpu_ptr(ro->uniq)->skbcnt = can_skb_prv(oskb)->skbcnt;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
 		if (ro->join_filters && ro->count > 1)
 			return;
 	}
@@ -869,10 +869,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!skb)
 		goto put_dev;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;
-- 
2.53.0


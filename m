Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.163
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794333470;
	b=ePSiT9GA2VEBNEhiVYh3cVh7GGZW/bIiCJPMRnCXDhAxHQbnx1d/KY1ZCmFpQ0Egc02/
	 fnetPDR1Z1GeFFJRrECCs8U6/9tArz8MZ0V4gBWFbkyEXGtbt0s49rTgiPwJm3ytcZnAq
	 Oj0tvuqOHz57v1AX0SwDgLITu/TgfjuPv/EEE04XsjJXKDkAQLuIUO85kFM1dskCd6Yfo
	 SfPhcskREttcW1Jy9XUA++LD+2I6h+SIlZFf0ZJLbTk74PF23C9G6Nw7/sqG5GW3stoCY
	 uIkCYC9xfrQTOhE5lFRKO/V1S6BxqACvt2I++Fcos8uwg2e28tWBnz+jkZpNMWPfiWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333470;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=u/y5BOgYw8S2/ncwOjF/uSlfrUE9POplcq9NJ+UkR/E=;
	b=aiCLqoYriDkc7BBMWIXCVkgiDFbZa3DT82VNN600WlAwtbgMeNMe3DpouaEgx+2Yri6S
	 kBYaCNz4GveP2pv5+kXdHH2BM4Hgu+EzXtBahrIQD6hBB31Rkt1vWkBx6mjIXKQpQe1Dj
	 rLxr2Vgy+68yGVGxT8vXihmNgmtLVYrn/+2F0tdurx9NxO+YCmKXxswXenzx3wzbf6fZ/
	 xoa7puUrh7NgJroEDYznosnLflYIdovVdpvA293H5rzEFpISqqubMp5o+j78eqbOuTa/1
	 UeN6BXo8hPfPjQZw3QMR94CFfDlKcwwsn1v8muTiVzh5FTEwrytyqi9y3irVC2uZsUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LLJOj2qN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3xO5GHXE;
	arc=fail smtp.remote-ip=81.169.146.163
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4800606A202
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4800606A202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LLJOj2qN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3xO5GHXE
ARC-Seal: i=1; a=rsa-sha256; t=1794333446; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ahblBdlFtyFva/cLerizE61t7obXx79IKbVg7VPjfjS91hTzz70iDL5lFJNUkXhIDY
    zSRez/hmzSwqT/tTE11Dt9Y1kOu2G9gcKSRPJfVWGepBuZlAbNusIRpNRj3VLYMe/4pU
    Pq3IPbvNHE67aNsV+Izqn986sDyJo5FUPAXNHi9PBCmTUnKb4vrpXBvLyTafa4+jNLXd
    WC5XpLFG0N2ce9iq/qBKzXTyBinar0tuhEeOrXkz2AcxOcQSZYoCqdOmi0nls3aW42Yf
    ll8xSzFdRIyyYdEkbcfAwx/euAbEGsyFJnWX+TlK9nQ11AXXIDGAzQn3mUD9YajYFfOn
    qGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333446;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=u/y5BOgYw8S2/ncwOjF/uSlfrUE9POplcq9NJ+UkR/E=;
    b=n14pwqA9vIvFeCWLx59FflQ+I2rVZ3W2I/q/8o/lUsUBPEyRbLivBGf1tCzPqsVCsg
    wIPVGlz+4Mo9CWMd8uOn1s79VAUabwhZQq84lu4zWQrUx/uyRXZMsR5g6jEtKsG2W1g4
    KUd98TgsR04bcT8qZfnIKcdKj5kwDnGe79QOueUUPVFDEj9GEQQ26VaNV8n72v0IR0NT
    TWVvGHHWknL5ivB+XC1ctyW6P73IuUBdaLcv95p1MVbs830uJvj6qd2GlzqjbJu1FyDE
    qV1owz/X6WHsdzf32YievH3Zu3MsutXerdwbUnYWNdBYc106q7aQ37GggE2X4eV5NDQ/
    UqWw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333446;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=u/y5BOgYw8S2/ncwOjF/uSlfrUE9POplcq9NJ+UkR/E=;
    b=LLJOj2qNuAQ1sTBvC5J27kGaWTsaVHQ1Sp5UkEA1xVSIrtKvJAD8lHH4ciumk1ODEv
    JLZGYfPkRZu+sCaJVMH7FxpH1cQyl1GtP8+0+Xe/g9lCirOLdZddJZDMtY5Fyiu6h8us
    uLSAsVaKtg/17R8a5hWreJ/j+k0G+ghe/TjSf1F0I8pe/Sq2zok52uhw7eSozSP7gJvq
    e94biFRbwtW6q1kYoG39vqSKmE694y7I7P6rTUPgY5kJGQztPu4wAwGZktlWWmVFoBee
    CFbK4IfKWF8+wTwkpz7CCsgVBCsjnyx63hk7qdDq6PoZes4P8KlEmSwgQ1D3DauU0ejk
    oFeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333446;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=u/y5BOgYw8S2/ncwOjF/uSlfrUE9POplcq9NJ+UkR/E=;
    b=3xO5GHXEP41GtBMY6TSfnN+5HoEVc/c3OqWrJaNnYegC+WYYolcqk9UevfEYB405tC
    gui1NRzN9xnE4J1FURDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAHvQ1cI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 18:57:26 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 6.18.y] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
Date: Tue, 10 Nov 2026 18:57:14 +0100
Message-ID: <20261110175714.791740-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200450-failed-6.18-962947b69589@kernel.org>
References: <20261109200450-failed-6.18-962947b69589@kernel.org>
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

commit 962947b69589881167054bae5accc8abfd5aa4b6 upstream.

Commit 4e096a18867a ("net: introduce CAN specific pointer in the struct
net_device") introduced an explicit way to assign the midlayer private
pointer (dev->ml_priv) to named users like ML_PRIV_CAN. A valid pointer
returned by can_get_ml_priv() therefore identifies a real CAN device.

The referenced commit only converted the j1939 and proc code to this
check, while the other parts of the CAN subsystem still rely on
dev->type == ARPHRD_CAN.

The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
netdevice passes the ARPHRD_CAN checks.

Commit 8aa59e355949 ("can: af_can: fix NULL pointer dereference in
can_rx_register()") already made can_rx_register() reject such devices.
But can_rx_unregister() still only checks dev->type and dereferences
the NULL ml_priv when it walks the receive lists of the device.

CAN_ISOTP reaches this path: isotp_bind() ignores the return values of
can_rx_register() and binds the socket anyway. When the socket is
released or the device is unregistered, isotp_release() and
isotp_notify() remove the filters that have never been registered and
trigger the NULL pointer dereference in can_rx_unregister(). This only
requires owning a TUN/TAP device or CAP_NET_ADMIN in an unprivileged
user namespace.

Convert the remaining ARPHRD_CAN checks in af_can, bcm, gw, isotp and
raw to can_get_ml_priv().

Fixes: 4e096a18867a ("net: introduce CAN specific pointer in the struct net_device")
Cc: stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261027-can-rx-lock-v12-1-eb5afc2d8b9b@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[ backport to 6.18: This tree has no can_skb_ext, so only the ARPHRD_CAN
  check is removed from the conditions in can_rcv(), canfd_rcv() and
  canxl_rcv(). Add the <linux/can/can-ml.h> include to raw.c, which
  upstream got with commit faba5860fcf9 ("can: raw: instantly reject
  disabled CAN frames"). ]
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.c | 12 ++++++------
 net/can/bcm.c    |  7 ++++---
 net/can/gw.c     |  7 ++++---
 net/can/isotp.c  |  5 +++--
 net/can/raw.c    |  5 +++--
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 52d72d56f2dd..539e9ba06ccc 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -226,7 +226,7 @@ int can_send(struct sk_buff *skb, int loop)
 		goto inval_skb;
 	}
 
-	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
+	if (unlikely(!can_get_ml_priv(skb->dev))) {
 		err = -EPERM;
 		goto inval_skb;
 	}
@@ -452,7 +452,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
 
-	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
+	if (dev && !can_get_ml_priv(dev))
 		return -ENODEV;
 
 	if (dev && !net_eq(net, dev_net(dev)))
@@ -519,7 +519,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 
-	if (dev && dev->type != ARPHRD_CAN)
+	if (dev && !can_get_ml_priv(dev))
 		return;
 
 	if (dev && !net_eq(net, dev_net(dev)))
@@ -685,7 +685,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_can_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !can_is_can_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
@@ -700,7 +700,7 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
@@ -715,7 +715,7 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canxl_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !can_is_canxl_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 6d67af0a3b14..5f3321ede520 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -54,6 +54,7 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
@@ -1706,7 +1707,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 				goto out_release;
 			}
 
-			if (dev->type != ARPHRD_CAN) {
+			if (!can_get_ml_priv(dev)) {
 				dev_put(dev);
 				ret = -ENODEV;
 				goto out_release;
@@ -1854,7 +1855,7 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -2011,7 +2012,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
 			ret = -ENODEV;
 			goto fail;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			dev_put(dev);
 			ret = -ENODEV;
 			goto fail;
diff --git a/net/can/gw.c b/net/can/gw.c
index 79fa58cb232e..de222fa93d6c 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -52,6 +52,7 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/gw.h>
@@ -603,7 +604,7 @@ static int cgw_notifier(struct notifier_block *nb,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 
 	if (msg == NETDEV_UNREGISTER) {
@@ -1154,7 +1155,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!gwj->src.dev)
 		goto out;
 
-	if (gwj->src.dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(gwj->src.dev))
 		goto out;
 
 	gwj->dst.dev = __dev_get_by_index(net, gwj->ccgw.dst_idx);
@@ -1162,7 +1163,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!gwj->dst.dev)
 		goto out;
 
-	if (gwj->dst.dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(gwj->dst.dev))
 		goto out;
 
 	/* is sending the skb back to the incoming interface intended? */
diff --git a/net/can/isotp.c b/net/can/isotp.c
index e3261fb4663a..dfe3fd47e220 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -65,6 +65,7 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/isotp.h>
@@ -1595,7 +1596,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		err = -ENODEV;
 		goto out;
 	}
-	if (dev->type != ARPHRD_CAN) {
+	if (!can_get_ml_priv(dev)) {
 		err = -ENODEV;
 		goto out_put_dev;
 	}
@@ -1895,7 +1896,7 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
diff --git a/net/can/raw.c b/net/can/raw.c
index 9f0fa8baff85..26c8cf15d60e 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -49,6 +49,7 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/dev.h> /* for can_is_canxl_dev_mtu() */
 #include <linux/can/skb.h>
@@ -343,7 +344,7 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -486,7 +487,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			err = -ENODEV;
 			goto out;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			err = -ENODEV;
 			goto out_put_dev;
 		}

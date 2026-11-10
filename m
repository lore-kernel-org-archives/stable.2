Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333758;
	b=1Bdwkk/NS1LZM2vNKB/rk+vksf80AbFQXEtB7Iru8K7RNn0hYkWbHmdJ5V096TzFGv6q
	 yvF+P1mX3GaF/FvdWwKUPEApkMJwaKLymi4x5JafSJCaNF8L1yGzAVdqWoO8XXPTXjn1I
	 pwLquUtPuIg2rfyFUzxuF1ZU/BaHTsDHG63sxoMHo3oC6j0mhPKgbIOj+V647pKdBSs4V
	 huX+TxzXjYc9WfLrGRs4/KggwAzu5I3JJUvHObL8vGQGhkB5Ml5p/zUoCud85wRkcq3iz
	 +N+/kMXvX+quuW9BxvGSImdt/QacZXkvDhuWlK3Y7kEZi2MxMdGWH+brEaIHsoOyrgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333758;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=M0HFJPhZ8m5qC6S4PoW5noQyZG9bLPwZ3c4SHon88X4=;
	b=QKX8WHGFCEOa6EoEiHzjUE+htfYlcgJxlEJ+3Kshkn/V1DzwUnWkSRraMy2o5NXUgTgI
	 f0o8Z7sxCU3+6chhoyHQklMtqoALoF6gqRxPwwZtz5iVDjx7nUiAcfAQwGn147n0Y6J0K
	 fnIQQZmjs5tg1rQqn3LEI6AuPu2Xnbt4vu/hY5TA4FFR8uAReR4pW5XRJAjWMdYEM7hhF
	 cCEAy1vqzhxb60GCZRh7sWgPeQZcSQrayhiaoq60cJ92sY2VB5FIEx68ErmchMNZiDGl3
	 GYKQWCJKThUAgYOlOYCk9zvN1+KPJgBD/51dJNm2SQ92bk+ywagWMCtd1hCILvlzcoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cyCegXx1;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=LJ2vK7Ya;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.169
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6B8B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cyCegXx1;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=LJ2vK7Ya
ARC-Seal: i=1; a=rsa-sha256; t=1794333742; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MrPKvUaS7TknEQIKZwSpxrFgUpkpgrXkwTsBqhH8C9MRNsPjqt34PUyIYGJfQYE8vq
    j7oOrWo4zInApVSULVvUT42F+pjInPRUieAkQ0Tgw+9od99vt2GDp5dIL5HM1uiapA1f
    h8Hka0adBBOFCbLcRpqffsLi3+1PRhff3zSk5jaZdjghAegeJJY7yhC6Pj6soyIuRASS
    Q9ODZt5fL5e1P11pvbQFZPnuZZJJutfUvGwUfmzeAMGlbe7aXS1VIjn6vNAchijPO+uS
    2W1Xu8ViQSlfAZccauFlwom5C06iz5+88PEo/uzhgZ1vblBhJbK2u7/6Z+yne64InQrh
    P9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333742;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=M0HFJPhZ8m5qC6S4PoW5noQyZG9bLPwZ3c4SHon88X4=;
    b=AjMB9nj/iTGEHuzRjwrm2J21UerKIC7UcNv3uj4wqtRIfwLr17BgpmvgK846xjQg3v
    amO4nBd6lBXmy4go1SKutVO5uaYrIiNgo8W8BhZU9hJ2j3K4uwBtvU+sdaoCvOqnz6bN
    m4h61Y86CCNnjY/UGxCxvG4hZGLxyjme4FV7pMpbxCMNEblvJMQ97ca0ECc+C+mFszVT
    S4eygyirl0Y9j0F7BT6AkCVE2DJqSpfjC8diJlVxP6PxEY6rgVYevJ9Z2l3FLrAGgEpi
    y67oc1FIl9jElPckE7HK4wtBRNkeLgzE5a0ieKqnd2yvRyqWXGfI16jZrAQZBiCP6ZN6
    rxrw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333742;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=M0HFJPhZ8m5qC6S4PoW5noQyZG9bLPwZ3c4SHon88X4=;
    b=cyCegXx1atazmQJ/g5KYyCKH5s+rmMYQbaSNU8DMiWQ/7Y3QFJec+ENPqtsrzDnoIE
    tYu9b3ww3ZoOKjVQR+MyAYwkO7APN1zqHM7DJavmh1OnJuAAKaRUSYzMkkxgZgXyLBr5
    +Tlm3W94XZg7SoLGeVzgMeUxaq72dcWTCRrCPCU/EUZg4Au49PmRaUIzwAxaMCdmd2zr
    okv8bKcp9kj2NulgvuGckaObv4TMkzBHY626TUalTJCH1xmq8sftZfY7dZQvBwwRuOvt
    RzkNtBaf2ClseJpixQKXbu/ZL/PpuRyC9RkZdI0zw6E+5t5Bpprei+dDG/WI+J14Dcym
    NJIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333742;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=M0HFJPhZ8m5qC6S4PoW5noQyZG9bLPwZ3c4SHon88X4=;
    b=LJ2vK7Ya2SKIowR6TX+dluT94ewW2i4la6W+7yVx9VZHgeOGPHeQwTmlmaoQWwTgGZ
    vaVexXEVPyl8dbKffUAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI2M1d1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:02:22 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 6.1.y] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
Date: Tue, 10 Nov 2026 19:02:15 +0100
Message-ID: <20261110180215.792102-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201808-failed-6.1-962947b69589@kernel.org>
References: <20261109201808-failed-6.1-962947b69589@kernel.org>
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
[ backport to 6.1: This tree has no can_skb_ext, so only the ARPHRD_CAN
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
index de6bb3484843..44e500c5f3d9 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -224,7 +224,7 @@ int can_send(struct sk_buff *skb, int loop)
 		goto inval_skb;
 	}
 
-	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
+	if (unlikely(!can_get_ml_priv(skb->dev))) {
 		err = -EPERM;
 		goto inval_skb;
 	}
@@ -451,7 +451,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
 
-	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
+	if (dev && !can_get_ml_priv(dev))
 		return -ENODEV;
 
 	if (dev && !net_eq(net, dev_net(dev)))
@@ -518,7 +518,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 
-	if (dev && dev->type != ARPHRD_CAN)
+	if (dev && !can_get_ml_priv(dev))
 		return;
 
 	if (dev && !net_eq(net, dev_net(dev)))
@@ -684,7 +684,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_can_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !can_is_can_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
@@ -699,7 +699,7 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
@@ -714,7 +714,7 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canxl_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !can_is_canxl_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 16640650c433..11ee2cdb52b7 100644
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
@@ -1668,7 +1669,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 				goto out_release;
 			}
 
-			if (dev->type != ARPHRD_CAN) {
+			if (!can_get_ml_priv(dev)) {
 				dev_put(dev);
 				ret = -ENODEV;
 				goto out_release;
@@ -1816,7 +1817,7 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -1972,7 +1973,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
 			ret = -ENODEV;
 			goto fail;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			dev_put(dev);
 			ret = -ENODEV;
 			goto fail;
diff --git a/net/can/gw.c b/net/can/gw.c
index 67189a6c2bba..e7bc457bdd65 100644
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
 
 	ASSERT_RTNL();
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 6547a82930eb..fa9d3c362dda 100644
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
@@ -1556,7 +1557,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		err = -ENODEV;
 		goto out;
 	}
-	if (dev->type != ARPHRD_CAN) {
+	if (!can_get_ml_priv(dev)) {
 		err = -ENODEV;
 		goto out_put_dev;
 	}
@@ -1856,7 +1857,7 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
diff --git a/net/can/raw.c b/net/can/raw.c
index 6d957f1e0fc6..cb2d19f9f7ef 100644
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
@@ -318,7 +319,7 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -458,7 +459,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			err = -ENODEV;
 			goto out;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			err = -ENODEV;
 			goto out_put_dev;
 		}

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333838;
	b=RhkHm+dDnduIxbTMu0MGO4q/F1KkkCNo+9ZzgJu7K+wt+0uSylaDJu3A9MSeIj/PMUBS
	 eh9Q3ZE0l6usrHgvRJKfvisxzPdWSVUYBSF6HqJuBDC6w9flwBs00o7svK9hQHhZCCdzi
	 aupa+Lv1IUk84Wi6yTo4sJK+qvNNgpOCfI9st/PCh2UvYJl7wyS29tAinsP44YQcOdbME
	 K/x3kb1TCD8LGK1YWKJSOXtd8mldLvrKPgf9tpJxSgsqUyvS2LkNDglRaLC/JVygGThvU
	 IoBR/r8kbwX3ldKLWdlzdjB8bVrCJ/ruBoBkRcQvOF8oTdoJHiHej2LcXZgL3B9VT6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333838;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=sAPOZgf6dfSvsWIZR5lJZHd/uagmKaj1XyZ/y9CpVNI=;
	b=pFAUCVkFypG3nTBEqtbuinwDrdG84+sDvr3BJoCqzwZBMPuZTyWfiJqYAvA3xd3e7AMY
	 ECGyZ0L0/Mq33MIG5wOy4Vr6wh6UnbJ46/X6HAsHBFVUr99etrtsV8H8CR4wKzNZ0s+0y
	 6ssvNx/8A15bkvRkShuC5jB0L+MWyoqdDhJhdZBsNpb4UEd4+g34/ot3Qa3jyz7wTxpAv
	 TBn+uYAxsoNm7BaZrdfjiPVWotC6Cpa+JqJKX5b9jhJj5AvLIeh+lzzIVZlnUZrRdFVRn
	 3KRdngQf6tfV4UqmlvbCzbv1srSnaJlqKfp4Rz6Xc+TFJQfkmNYdLHa6IQtc4Wdoesg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=qRmEe6J7;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=NkAaJt1k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C1606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C45C1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=qRmEe6J7;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=NkAaJt1k
ARC-Seal: i=1; a=rsa-sha256; t=1794333827; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jDSzs9a21whftoMHWv+Hp4+EMqN3+rJ+vGpTR4o9QA+RXVcHrvdm84rMwAm2p+s0uA
    RYzpLOw1ZLAR1ZeyVzW3ErYkqTHL2sr5F1SR//A9x2+ZLB3rJKpXQFoHbFT/eswCI1i4
    NGAdvMllocTkvItdDmlj7yOCszKsWw9VtOBLX0IkbxPaKys7gyCjGiQxVMI22K0Wgckw
    UaRYuOFdHEViFV/NzY5kCvS8VlVu63WdSvjrGfoT1Hwr10Fw9DBVCV0HJrx49zL9rid+
    hk1uGH5jFH+8dR+CBCKiaAf3Bw7KLBzOnyOHOXS8++wgHlR6pb1GP26GUo6CqGQpUbOP
    Apdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333827;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=sAPOZgf6dfSvsWIZR5lJZHd/uagmKaj1XyZ/y9CpVNI=;
    b=ccJd/+1v8GpNtqzw8gQPHbhtVc9SG5xXzhIVNNsgo20N5qgtwAz1iQWJAOc+eI48H6
    C9Xb9IjMHXUwLKT8UfVhYl0xrNhepCmHie90aRx7SLgdvfKS2nXWfXXzxBzLx1EPHfPd
    Htydjfe4+PaXGJ+q378ExUuNUFMXqQlaGvNbHVmU1ETApWjJha2V6rqiXMcWFAxh+iER
    Q4osrFRXDiZsS/+9MpV125rv1g6RqD1jaYBPNtSEpQpKeHeeMU0hJMHqHduggwacmvS5
    fmzVgWYVuvvakGqvd4er0OkwlRIzNQTTL8CloDAPx3DZZ223bb/chbCmlE+k9s+an9Qc
    fTQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333827;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=sAPOZgf6dfSvsWIZR5lJZHd/uagmKaj1XyZ/y9CpVNI=;
    b=qRmEe6J7QDvhCSXHQunm3bD3d4TFLmUVW116gZDuCKBv91Z3xnL2z3BLKcYr1vFqO4
    oInympGsdk+aLap+BQXMT7zdzE6NXfK7anAoiC7IgClbQBtiFmfGZAqDaiTdJE6NwZw5
    6IDlRTCXISycMSNlBuAUYbShfJgD/9h05iQa9mFCPWwCUZYpM4PmU+UkTqVtucfQDjW3
    1YFWKB7otSmpi+nuzQRnZtjV/J+dSYNLLJ9m+ydTkn9APFCoz/sBpODPe0JGRSNDiKjH
    ruh1UkgN+Kdu8uGNl5gl+3gPHT1R16CLQynTF3pWK4r1u1foUH2Amiu2PiA00dIzy1hd
    T8hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333827;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=sAPOZgf6dfSvsWIZR5lJZHd/uagmKaj1XyZ/y9CpVNI=;
    b=NkAaJt1kLmXmfqcAsWBra1+8ExAqK1l2BuzUCjzDhzB4lDMKAEwP89i/DDQkW9JnYP
    PLXIBaQVnEtFhP7Q28AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI3l1dD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:03:47 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.15.y] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
Date: Tue, 10 Nov 2026 19:03:41 +0100
Message-ID: <20261110180341.792187-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202308-failed-5.15-962947b69589@kernel.org>
References: <20261109202308-failed-5.15-962947b69589@kernel.org>
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
[ backport to 5.15: This tree has no can_skb_ext, so only the ARPHRD_CAN
  check is removed from the conditions in can_rcv() and canfd_rcv().
  There is no canxl_rcv() in this tree. Add the <linux/can/can-ml.h>
  include to raw.c, which upstream got with commit faba5860fcf9 ("can:
  raw: instantly reject disabled CAN frames"). ]
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.c | 10 +++++-----
 net/can/bcm.c    |  7 ++++---
 net/can/gw.c     |  7 ++++---
 net/can/isotp.c  |  5 +++--
 net/can/raw.c    |  5 +++--
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index cd31c4e014d1..5943543284b5 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -225,7 +225,7 @@ int can_send(struct sk_buff *skb, int loop)
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
@@ -687,7 +687,7 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || skb->len != CAN_MTU)) {
+	if (unlikely(!can_get_ml_priv(dev) || skb->len != CAN_MTU)) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 		goto free_skb;
@@ -713,7 +713,7 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || skb->len != CANFD_MTU)) {
+	if (unlikely(!can_get_ml_priv(dev) || skb->len != CANFD_MTU)) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 		goto free_skb;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 2cf63940f6a9..266faffd8400 100644
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
@@ -1663,7 +1664,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 				goto out_release;
 			}
 
-			if (dev->type != ARPHRD_CAN) {
+			if (!can_get_ml_priv(dev)) {
 				dev_put(dev);
 				ret = -ENODEV;
 				goto out_release;
@@ -1811,7 +1812,7 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -1967,7 +1968,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
 			ret = -ENODEV;
 			goto fail;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			dev_put(dev);
 			ret = -ENODEV;
 			goto fail;
diff --git a/net/can/gw.c b/net/can/gw.c
index db5cfe64e9ad..584b26a6b483 100644
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
index 883276119363..4caf83d694a0 100644
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
@@ -1550,7 +1551,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		err = -ENODEV;
 		goto out;
 	}
-	if (dev->type != ARPHRD_CAN) {
+	if (!can_get_ml_priv(dev)) {
 		err = -ENODEV;
 		goto out_put_dev;
 	}
@@ -1850,7 +1851,7 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
diff --git a/net/can/raw.c b/net/can/raw.c
index fccc2904bb18..6e515f3460f7 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -49,6 +49,7 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/raw.h>
@@ -315,7 +316,7 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -454,7 +455,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			err = -ENODEV;
 			goto out;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			err = -ENODEV;
 			goto out_put_dev;
 		}

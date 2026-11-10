Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794333575;
	b=JEuBqlQ4gOFi9dguo4KLTiw5Ug/aJdNSZPNJ10AM2tbDxwN+zIcenLIFVfmNMX1MvLeo
	 gTgAP8Tiye1UJVBgK9FF3H6qVrl7M7uJtsDxjIxN8YaVMMrYv6A9S9WHyr3C3S7D3vunT
	 XeH7OfAvjI0IoDeJY1Cm/mhT5krjPHFMyV1hpHscdKqjTFkprYb9QI+NjzV1VlfNmIsI1
	 652dAItQHKrwbWaWVQSbLnSgEVK5SqohHJhUT7xcd9MbYzWi/lw/w7rFxlT0T13u6Pjjy
	 KDbkAWyLqR0lQ71uTyL9XNdUv3zC/DSFAd+aFKSTEmkzqyTL+v1OwCxpSX9J3we7Yvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333575;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=uzCc5TcX6LY/JlsGNq2cic9/IpnT8rajrL9pFD76z0U=;
	b=4TguczlEcghnQdBvjlHCcEhT29bZOfWfnTGqDHdXZZ6hcTvOm5q3p1Ru3U9LAPu68l3V
	 bQ0hzF9ygkoPpH3HdO6oFvVdtw3W0aWARMHsAYxib/RO9m6LFrL1i1QG/GADkMpn/tqFm
	 RKsFD4ntd7W4foTusO4x6i5l0kQG4TUlGDbkC0gOCOR1GjfA53JrdXLB/i9deJ3X+sWVr
	 B3J51vtZ3Lx+Jhxp8xBtx15PsEOmVBFrFO+26E49zGHQf+NwKxlogN8G29Ad6njqaDo/H
	 wtG7li8MLwkZZe7ROE49MtW2r2sFb/McPMByJyBoqXTcT4saYuEWz0Dv/z/Kcs7hCpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mBgcXRm3;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="SBdpF/Qu";
	arc=fail smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F32606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41F32606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mBgcXRm3;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=SBdpF/Qu
ARC-Seal: i=1; a=rsa-sha256; t=1794333564; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NGDJEpU3bImk7ZQIaB1pO/1TCtAlrIYfSAl2q+k771I+tmQb3mIjEO+MvG+xM07VAO
    RWVOLx9NW5VSYK2xIIKh3eOxKK3Op0b1nq3IqVOWdX8JduItz8SFmlob3QTTsYYQkidy
    jdnFx/MlEMlCYDarrmKki5o3ZlHwtNVWebMFMAygAndOnczLmiwl8zt4gEIsdkOGJdNi
    W6+K76mNNULilmS/pgx3X13lUvbnhHd2ukz3e0FrtI7R32fnFJG1FMlyyatpOCt1DHt0
    UhY++0ZB1rAwM3XQGibxYVsv+/UjosHmkmxEkupOA+HDP5gu4SsQaV3mOTphsa2V/JJK
    SpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333564;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=uzCc5TcX6LY/JlsGNq2cic9/IpnT8rajrL9pFD76z0U=;
    b=o99RxnF1bGOff4i31KpefJ/mkApG9SMUO18B3Ioko2U/CngzzlYjcEPW7u6/GRuYiA
    VfYjB5QSKmog0WZEi0kBUW5O3KHaJ8HTGTdw6/dsHKukDFf8lEx6lctGDJaLJFobupkW
    LXEUtePE7vPVvt9idCIRIUoJuFy3x8z97PyORCq0ixY6jIsGsD9r+p0gnRVhB9kefLWp
    B/No5TtgoUDJgblACzps1zVoRbHmE/d1G+Pe0d8HxMmt/D821qO1HRj1Usgq+OiPXCbU
    WSqSriXJw6v+9cNz13BrCZ9hRnPElQhG4dD/LYTLe6bBeScxuNSsf4eW5N2mZJ5wVpDw
    GVPQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333564;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=uzCc5TcX6LY/JlsGNq2cic9/IpnT8rajrL9pFD76z0U=;
    b=mBgcXRm3Ld8Pv5xSCwf/c9sH23M5Mg7Spm7tPLnZLisQJOWM/hIZ9+9LGmucZbcEq5
    KBDTlwl9ZGjhJheeDKtf79roz2/9Y1/T9GqmI8rvFXug7d4FjDasG1fFD9SpbU+FsGvh
    UuJhMQq7TX+7NIEw4xZdu08erqZ7G/iC2R0NzS0MsehLKFmO9lbhR60UtHcAQctGXjVf
    uJw0m763dHUeNpJjlm0PFcQ8+jZadDKutEdBYKjoyBfzd6WtJZUIcrjgRcAtv2o/fgDv
    2b6enpTI3E5DBH2KDCWFlm2T1YniKofr6iYiyBD8yVzuwF4eFeQvOD5WoF5+MZxg1w5l
    6fWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333564;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=uzCc5TcX6LY/JlsGNq2cic9/IpnT8rajrL9pFD76z0U=;
    b=SBdpF/QubcR5uyVkHcV+8Iz6aO/OFIQGCXpkhnt+zWKQ1G2OLFwMn+cUPADNxWR7Mx
    Ydf0zyMIH2s7VScRW5CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAHxN1cX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 18:59:23 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 6.12.y] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
Date: Tue, 10 Nov 2026 18:59:16 +0100
Message-ID: <20261110175916.791884-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200845-failed-6.12-962947b69589@kernel.org>
References: <20261109200845-failed-6.12-962947b69589@kernel.org>
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
[ backport to 6.12: This tree has no can_skb_ext, so only the ARPHRD_CAN
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
index 1172073499d2..bc9fa9058617 100644
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
@@ -450,7 +450,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
 
-	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
+	if (dev && !can_get_ml_priv(dev))
 		return -ENODEV;
 
 	if (dev && !net_eq(net, dev_net(dev)))
@@ -517,7 +517,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 
-	if (dev && dev->type != ARPHRD_CAN)
+	if (dev && !can_get_ml_priv(dev))
 		return;
 
 	if (dev && !net_eq(net, dev_net(dev)))
@@ -683,7 +683,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_can_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !can_is_can_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
@@ -698,7 +698,7 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
@@ -713,7 +713,7 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canxl_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !can_is_canxl_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 0c7e6203eb44..5db1b4e9c9ac 100644
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
@@ -1710,7 +1711,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 				goto out_release;
 			}
 
-			if (dev->type != ARPHRD_CAN) {
+			if (!can_get_ml_priv(dev)) {
 				dev_put(dev);
 				ret = -ENODEV;
 				goto out_release;
@@ -1858,7 +1859,7 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -2014,7 +2015,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
 			ret = -ENODEV;
 			goto fail;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			dev_put(dev);
 			ret = -ENODEV;
 			goto fail;
diff --git a/net/can/gw.c b/net/can/gw.c
index 676af9a0b659..1fff84d8e4e1 100644
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
index 25badeaa0f4a..d1fb1c126026 100644
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
@@ -1591,7 +1592,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		err = -ENODEV;
 		goto out;
 	}
-	if (dev->type != ARPHRD_CAN) {
+	if (!can_get_ml_priv(dev)) {
 		err = -ENODEV;
 		goto out_put_dev;
 	}
@@ -1891,7 +1892,7 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
diff --git a/net/can/raw.c b/net/can/raw.c
index a5a0f69cd7ae..c83bd7b5fafb 100644
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
@@ -341,7 +342,7 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -481,7 +482,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			err = -ENODEV;
 			goto out;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			err = -ENODEV;
 			goto out_put_dev;
 		}

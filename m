Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333928;
	b=29pvsGjw8SbXOyhXNgJWanGj3PuP+03SMzbefyDQkCYScHhm4D3zSPAh6XwEAxaySAdD
	 5wGXCNzOlWqk2iII1zCTw7dXB7nIILVLXGAg/pvKEnNYUSxu7SJaOK4iAGClVYydwW4BK
	 sqvvpprJJH1/9beRMmSiIF8CiwP0g2omBu4qfNrlVUi799x/qpO0S7HRaciku6uZvZLWN
	 9NosuYsuJUZa89/nCy/MVctU2+m35PpUoNpyNAYtLpGzR9l1KYEtvhaf8j84tVxn3CToN
	 wgM9SRT7Z0UvpWORIISiyPLobgsj30wP/n85MsnJni6GTlrqLN/bwgge9o5ZgWt4wow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333928;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=IcT9bEFQcCXGi0Yg9aoleYkfvUyKLbSL2CRn6eKdIWI=;
	b=J6nt6FjpgmI+bdWBcJNPJ1NA+VAJ7TsFFX0c/HT2uCy1ZAl0byJY//6GML1XUapkqi3A
	 74RXH965Vk5duvDecJViPsGotd4DiWwXXwwSAht6K2zHMUFsBMJRw0yHn2Vv2mY7W+HKt
	 hTkbM+96NO46pmtktFe0IK2KmlzbbBjD25L88ixxTDgJJnk5Jyl5U/PHh8VXpScoqKYhW
	 ABi8IA5ZgK8eQLiradljAdfS61dnZk821jWzaBz0rHVU9CuLZktapzFh2J/HiQX8K3XQ/
	 FWXtcUu7kwAyfv553eDTk2gILDoUo/bGQepXC5U0XBV/H6IZKUvmIAODCP6Q9xS5JhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cmShsZj0;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="BTKP/wIJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A37606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91A37606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cmShsZj0;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=BTKP/wIJ
ARC-Seal: i=1; a=rsa-sha256; t=1794333911; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oVo5Ea5HesIu5wdgCezWylePFiM9o9MnnKoThLErtnlyPBV6kjyQmpZPSfLWRdA8gu
    R+XgdAwhWSSlfuEBhCg3tT9UfWCh8r1Pi14nlecQyfYyFqdatU9iDAnXOaeVU+bbvWZm
    TjC12lz5mnnOrkYQFdGc76QtV/yzf5gIi4nzTYciCaV4dz5blQ9kJ7Ad7WvNxm/opLcx
    ydZ5YoNSKt9C9cr2yXruZo43R6S7otLtlTV/3vsx5WAzwZug4mQ45fFD7K1SRuMJ+7Rd
    3y3lGGkH+vDVhPGe8U2pWgw+JNi3HYqmY+w4OJIg8NLGXWz2xfFF8e9oLzIx+EnHz/0K
    yV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333911;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=IcT9bEFQcCXGi0Yg9aoleYkfvUyKLbSL2CRn6eKdIWI=;
    b=YSn4FfRmjJpgKvddBUdQIlo0A6yQpdDAQadb+yN/9CnAebY+sSEgqnSh/ZAI4NPeRV
    ufAPnCt2jFqIMJQWhMEtkjDz18cicRKz7bgU1uho+iIqEMMFU51N3WSUYVG+NW53v25Y
    DqZAQN2shbDhokP77QEFnXwiWF5Ylx6dL06xBj+raWDUuDalM0tfEG7U6U6rAOfGwx5T
    KelCD+Ak6p+tN1tawh63Nph2uAz9UW47GU/swY+ppwwirkUZxBMvu/MNtnycHNv0kYpG
    iFlY2FooZVBtiqRacYG+QLmyFYJsJ9T4Ne6yGXUgWvfks4TX9B34EVw7RaV4L054EGNd
    META==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333911;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=IcT9bEFQcCXGi0Yg9aoleYkfvUyKLbSL2CRn6eKdIWI=;
    b=cmShsZj03FGolp/LRQqNLyCbv60NS35UrrsYGeExC5Vpwx8/sHYpTv8xf1NozTjBg3
    zxYvwm77Gl9oZ/mH2rD0Z/jKYI1eoGFq7d3/k9JBdkqco1c6guW/ULHIrN/mrG+P0Qks
    XepG6eD/JHmjF+IiKAJ5Y9mcrq4soq/MoQz77xjU8gAdXWiCIF6nqqp4mYu8oLr3CvPE
    qCR3crjbSXEkZ9qJ1WT0dOc/jGCpCrJu5UdPB6trBrPMXF9Y3npi02qICG5gOkTFVKsZ
    PaPQxYGOqGLBDX5frMI7h01J9I14Z6tnAfYeVv2ghns55uEbts6f+A/l8Q0uAB4Mtmrj
    SfIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333911;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=IcT9bEFQcCXGi0Yg9aoleYkfvUyKLbSL2CRn6eKdIWI=;
    b=BTKP/wIJjBU6I+3kNpgbctj+fRAllm2yyeaqINVneho9+sOYr93325AYUfWgKFd30z
    FO3nd/YxTjxGPAZg0IBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI5B1dd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:05:11 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.10.y 4/4] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
Date: Tue, 10 Nov 2026 19:04:56 +0100
Message-ID: <20261110180456.792270-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110180456.792270-1-socketcan@hartkopp.net>
References: <20261109202741-failed-5.10-962947b69589@kernel.org>
 <20261110180456.792270-1-socketcan@hartkopp.net>
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
[ backport to 5.10: This tree has no can_skb_ext, so only the ARPHRD_CAN
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
index 05066662279d..8131992809bb 100644
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
index f655764aae83..99abdd11f107 100644
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
index c6efa4830ce9..55605135ca58 100644
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
@@ -541,7 +542,7 @@ static int cgw_notifier(struct notifier_block *nb,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 
 	if (msg == NETDEV_UNREGISTER) {
@@ -1092,7 +1093,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!gwj->src.dev)
 		goto out;
 
-	if (gwj->src.dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(gwj->src.dev))
 		goto out;
 
 	gwj->dst.dev = __dev_get_by_index(net, gwj->ccgw.dst_idx);
@@ -1100,7 +1101,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!gwj->dst.dev)
 		goto out;
 
-	if (gwj->dst.dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(gwj->dst.dev))
 		goto out;
 
 	ASSERT_RTNL();
diff --git a/net/can/isotp.c b/net/can/isotp.c
index d06a99ce8413..e4542fdf8431 100644
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
index 3e2822707ed8..293e79aadd32 100644
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

Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA4435EDE
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888622; cv=pass; b=OLnI/k7IMBlwCWk+ZxlkRXm8VnusV3Qcm1jZ/d79m5hoUs3roUtXeIyS8YpVYhaQSUd1pePiolJFCw0qX87rvKkGbrGRGZBPo2L0YiGWFmHFk3JUU28bDaefwVBiSYv9ZDGZX57HYy6Snn10vA9PV9IQfTDNb/rB9iuCYkYz3es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888622; c=relaxed/simple;
	bh=xExtmjr/eczfCNapZi8boNt1voZaYejWd0+UgrhkdD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8TXNvhwZMh9CN3XshglrwEr8V0RE3wv6fh/jTUUV54e+EgUqpE1Koz734ECKw3JlTau3rysSBjEnHgBi+Gg7AfagMzvDOpWeYAWoLk2EgahAUfq3i7DT8kpv3JAdGhahkwAs9pxgSWJg4J3WgIiKiqxWXUkFptz6qwMaJzBV+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sqDi63XU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=9y3nm6mo; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sqDi63XU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="9y3nm6mo"
ARC-Seal: i=1; a=rsa-sha256; t=1784888616; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=c8b7hyEhfdGYmRCm5knyFCCiHQ56GwKI/ZX80Zy8ruTTYSRRM3cs23GBxmydQiPefI
    LiqRhv0GlZQJkNOpJ/HuXobQ4AUnpA6Y9zNqgIGExZFvi6Wx817lrCxOJO/tI+UaDo5L
    4NokTQHVd8Qum8z5Cx3nNfJHPtiYLa4Q/Eh9oyr9lEAeaeZ10jXq1BBnwbyXnhREOsCA
    xqX6uxqhuWJY3yL60i7Ud6mEiccHGIURBRg1PBUy1zPygHa1o+Zr5kGxYS7T9pH7v4w2
    jYm1HMifob9lMJslt+/TrWRpIF2aB16fgi01s9q5m9OT1RBpW7d5nCy4tuICeOmC/blI
    j0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888616;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wBlRCUhK4GHnTPGFhH0J/e7zpoRJ6AEmC27WnPwo4nQ=;
    b=ktA1pNKRkrbwhGJ96yZONgQzXCURn3GimZzdklZ2v8MqyI880jk7xOTiVbPZOJToqV
    B+M8WGnkeg9qgrXQAVUsvcYrntpewNaUbxZVJ3ZaVGehX2LK5WNnY+Sx2tI8tQuj7fmQ
    oBhymUOldIjXCk//3DgFVr13D8IVgFG3cdyzlwlWE3yOIneYJEyvBMa/BkYHFiSRb8WQ
    SjUeB5nThULVAraDi2PxROuxr3k+96bcoYMXz3pTN4CeOce+E6/HUrYWd4YvHMAOnl9P
    TiUNNAzpja0BJFFK0sEzp3mxLKeRl9IRwlwt5aruyrxREMzcEVOvFcsHu9N2ISv5zxEb
    5pOQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888616;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wBlRCUhK4GHnTPGFhH0J/e7zpoRJ6AEmC27WnPwo4nQ=;
    b=sqDi63XUdETwsNX22fBqE8uTMxnWi5Q6wIndnEIXMw8InLh3FOjqTVNAhD9XLlHwjI
    E+VgDF7MVsIlhbdz9mDz311Jv7NrYNoPaVtTlMhLJq22+DgskFMGo7GGSWnUFdEqD4yi
    bwirI54ellsztJErIGw6/Zx0pwCJbmY7DSK7jClmvCxWvfVOzjywIxQSQ+op/p2fZCCE
    TwSZTDkz7cQj2ma97OiA/oWy0eZmCeEgH7MrTxZ52UfgEY4AXlEqX9VpW1s6JO8M3icU
    mAHuUc2VPOInuNe0VTimcQeyDy1Y2bcoBkSGYKJh4rf4R107KJjLpSjIevqAes4VUvLd
    QXJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888616;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wBlRCUhK4GHnTPGFhH0J/e7zpoRJ6AEmC27WnPwo4nQ=;
    b=9y3nm6moBYETG6K9rAnuWVe/q7SoekurKG39MBRyCWkGkMOat2elrGLkDUh0QRdt9+
    4tbxuiwqS4/wCMcfmeCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OANatII
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:23:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1.y 5/8] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 12:23:26 +0200
Message-ID: <20260724102329.16572-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102329.16572-1-socketcan@hartkopp.net>
References: <2026072012-repair-flip-109e@gregkh>
 <20260724102329.16572-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit d59948293ea34b6337ce2b5febab8510de70048c upstream.

sashiko-bot remarked a problem with a concurrent device unregistration
in isotp.c which also is present in the bcm.c code. A former fix for raw.c
commit c275a176e4b6 ("can: raw: add missing refcount for memory leak fix")
introduced a netdevice_tracker which solves the issue for bcm.c too.

bcm_release(), bcm_delete_rx_op() and bcm_notifier() relied on
dev_get_by_index(ifindex) to re-find the device for an rx_op before
unregistering its filter. If a concurrent NETDEV_UNREGISTER has already
unlisted the device from the ifindex table, that lookup fails and
can_rx_unregister() is silently skipped, leaving a stale CAN filter
pointing at the soon-to-be-freed bcm_op/socket.

Hold a netdev_hold()/netdev_put() tracked reference on op->rx_reg_dev
from the moment the rx filter is registered in bcm_rx_setup() until it
is unregistered in bcm_rx_unreg(), and use that reference directly in
bcm_release() and bcm_delete_rx_op() instead of re-looking the device
up by ifindex.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260707094716.63578-1-socketcan@hartkopp.net
Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-8-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3e84f4b..05fad88 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -889,6 +889,7 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
+		dev_put(dev);
 	} else
 		printk(KERN_ERR "can-bcm: bcm_rx_unreg: registered device "
 		       "mismatch %p %p\n", op->rx_reg_dev, dev);
@@ -919,17 +920,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 				 * Only remove subscriptions that had not
 				 * been removed due to NETDEV_UNREGISTER
 				 * in bcm_notifier()
+				 *
+				 * op->rx_reg_dev is a tracked reference taken
+				 * when the subscription was registered, so it
+				 * stays valid here even if a concurrent
+				 * NETDEV_UNREGISTER already unlisted the dev.
 				 */
-				if (op->rx_reg_dev) {
-					struct net_device *dev;
-
-					dev = dev_get_by_index(sock_net(op->sk),
-							       op->ifindex);
-					if (dev) {
-						bcm_rx_unreg(dev, op);
-						dev_put(dev);
-					}
-				}
+				if (op->rx_reg_dev)
+					bcm_rx_unreg(op->rx_reg_dev, op);
 			} else
 				can_rx_unregister(sock_net(op->sk), NULL,
 						  op->can_id,
@@ -1452,7 +1450,15 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 						      bcm_rx_handler, op,
 						      "bcm", sk);
 
-				op->rx_reg_dev = dev;
+				/* keep a reference so that a later
+				 * unregister can safely reach the device even
+				 * if a concurrent NETDEV_UNREGISTER has
+				 * already unlisted it by ifindex
+				 */
+				if (!err) {
+					op->rx_reg_dev = dev;
+					dev_hold(dev);
+				}
 				dev_put(dev);
 			} else {
 				/* the requested device is gone - do not
@@ -1825,16 +1831,14 @@ static int bcm_release(struct socket *sock)
 			 * Only remove subscriptions that had not
 			 * been removed due to NETDEV_UNREGISTER
 			 * in bcm_notifier()
+			 *
+			 * op->rx_reg_dev is a tracked reference taken
+			 * when the subscription was registered, so it
+			 * stays valid here even if a concurrent
+			 * NETDEV_UNREGISTER already unlisted the device.
 			 */
-			if (op->rx_reg_dev) {
-				struct net_device *dev;
-
-				dev = dev_get_by_index(net, op->ifindex);
-				if (dev) {
-					bcm_rx_unreg(dev, op);
-					dev_put(dev);
-				}
-			}
+			if (op->rx_reg_dev)
+				bcm_rx_unreg(op->rx_reg_dev, op);
 		} else
 			can_rx_unregister(net, NULL, op->can_id,
 					  REGMASK(op->can_id),
-- 
2.43.0


Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E8381E88
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882721; cv=pass; b=PuYgWaotOdaCvhQ/2iubbcYIv1QUppsVBZfIUYGkvDwYpp1Jfzoqdjvr0vV82SK7xMLgclXJdy6vAG+rVvqJqKbA1TR72cdByb9X6zXpWDSQ8gZ1au8LUxxQeHF3e23FQ5a6+vA/Aq6Qo1dlWOUakY65LiTnNmue3mAvqX+viN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882721; c=relaxed/simple;
	bh=zoHClvKuscEdp6UzhLoX1RarT1CP+sv0Af8u6jwKEic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfaSvWIprW2tZUTp8iatgDH/8OAKozr7CwmuVWkw2jRZ8FiRWhs5B+TfDHZgQaSGwsexDIy94fhWkt5v8W40km9lp9dLM8fFARIsGDbMaL3DIZRYoB1NO5TmTpGiDRCpV9PD4JoGbsi/nH2QieK3CRFoEIDvGU3y4+mOPYcE4Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Xwo/Z29u; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eC/rfesJ; arc=pass smtp.client-ip=85.215.255.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Xwo/Z29u";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eC/rfesJ"
ARC-Seal: i=1; a=rsa-sha256; t=1784882532; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AzFPMy/+retkKQsrZibG78f0cCbpiXKgmaQAqE4zADGw492mMXT/8Lz+1nYaKnXtwc
    LTokPuKid0HjXadt7iATk+vcw07xiYGMwgcUSfcdHuQPGpTdoqn4rhWmSlVWLrSgkpyk
    RNkFK2eINQtpFziM2gjdVLwx5ytdw7riHrsv+HBkhDeJklTwcNeJwEyDSyZNthcWBnW+
    3slbPBvMzWO35y8y7je1Ak19xyk5C14dpMdCvpGoxAO4CyU8yp0PoLf/iL1ouLIxFviS
    +HA3MahizH0pRmnXKgF4YfPdy5IgtVYzE+1HyBHPKAPs1nwkARySEBEwWvuzCkQp/prS
    vOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882532;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BsM02ENHl1Ek2EfMzXFCuPVI1uLSJ2IXMgR6UVC81yY=;
    b=WNNsuSn1DndtPLKbrDtcQOvB9R9G11T7VgN4qBryRxhvYYwOSx2nlRVNj4V4CfKrKb
    9S8h+932Sf8DWLwHA8EZv5dtE76rMj0JJtDUY+29yQWkXOhx1EEZY0sC+q5BFj0kx4VN
    +1i7vBCwfxelMJ3WU3go69iy5NpiemFD4zBJUU0suv4iXr35RBL5Jgb2UoRYFih9HH40
    pkmkIu/1IHGSFZ0qb96nqgY1fv1CvrnM5134S1sKnq+0EK750TEmWm4R3sKcWYdp/RMa
    2TDhWLuzxYC6iw6xJjtfokrWIGsAfsarDaRn5XlgFVeqPprX8DmVFQt/glMA4JfJtKyU
    drdA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882532;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BsM02ENHl1Ek2EfMzXFCuPVI1uLSJ2IXMgR6UVC81yY=;
    b=Xwo/Z29uLjNAcTVC+S0aiMCagFJ61pqvK7ei4H7+R3caS6uew9kWTcP6AqDJqutiQ5
    J51PErWAgFFl+POZhB678xx7SRx8ACQ9bY4rAAUimoKzzJwaHWvdzGMFxjdn2nOL973V
    PnwRvionAxcs12QSmHCXRmJu3njOCeSU36QQu3DSaGuwEOZsxDA0eBfBBQ+3Pag1LioT
    3jQz4ywduDZIgucxgoamDkxJgNbICeuInrlKXveyL+bbSIWiT6uYgUmbB71bh0fJxmF4
    oacUJQ+PwZ4zs8JYk29Td2DT2RtrVfwGaTn41Pcu4Y1Rd0AHfjmx6Ahf8fzHDEVicGGQ
    P4Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882532;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BsM02ENHl1Ek2EfMzXFCuPVI1uLSJ2IXMgR6UVC81yY=;
    b=eC/rfesJxutn3wivO1B/dorxYX7V12YUHicL4KuMIWIXAyek3lPQ9imbMz6MZ83FAz
    pvTAPP+RCE2KUZSYacBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8gCrXQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:42:12 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/8] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 10:42:01 +0200
Message-ID: <20260724084204.13169-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072037-gumdrop-line-b054@gregkh>
References: <2026072037-gumdrop-line-b054@gregkh>
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
index 0283c8f..adc176f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -932,6 +932,7 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
+		dev_put(dev);
 	} else
 		printk(KERN_ERR "can-bcm: bcm_rx_unreg: registered device "
 		       "mismatch %p %p\n", op->rx_reg_dev, dev);
@@ -962,17 +963,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
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
@@ -1491,7 +1489,15 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1864,16 +1870,14 @@ static int bcm_release(struct socket *sock)
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


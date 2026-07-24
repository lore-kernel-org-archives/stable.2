Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D943909A3
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882470; cv=pass; b=XOkCjD9cKXbH9Ec0NYehwT/am0OpPLpLGR24bZ6TqzrI2D4ec1abf4UCyEvXMvpun+i2Myb5iP2L/2lq6L6tT5Aj7r7xOO2Y0KUgbeWLbbrJaAh0XCq12WKjoFgIN7GwcY5NlEiNQZbZ987QVY/o+T3uHD8M5sJr7BVP0iEwqyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882470; c=relaxed/simple;
	bh=qzM8GUXCgxZajg79iEdmDxseMT4fA+4rVbXp6LUCbdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbwkcDWGjNHRDdkCMYbqJKhYHQt4Cq1xbaHEI2QFsZb5IJZTzrYsLPuUza6orOCfKj9d5Vk3MDoxu0yLA1MuSmTwZ8Tf3PFNZwIrHZSneJEg+rkYpJdchGJej95KFQMuR95BE0YXNSkhg3JN6v7BdB8tRzNupok20Exc5PzR3Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=HEuE81fO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=juKDQn51; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="HEuE81fO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="juKDQn51"
ARC-Seal: i=1; a=rsa-sha256; t=1784882288; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jMNrGs36QTiP56CS0cS9J+5iOyArANuZ+bjueapb9rzHCreYAc1CARKIMKezt0IwoY
    4usaqtLu6JzjeniEyJYAjdG9BYq017xFRVjIl2VYTfyoYIXdsExkOh96orsF8BkGy/72
    4SPpvAP/O2rWuNWmJXj7IHwFIt1BPj26tH1jMlB91EynD4FXSeGer3spc98AtJfXzxtI
    k1r9uI8h4ElHrVPz1pPwA+8t56hTaR4d0pIOxGHvjsUFz2vSLqaercKPlIJjbDjdmNG3
    kkTE2yaONakUDyYcC7RT8hOAQmw2rnooKY3WDOlVYekhXPf+E8qLpFuMM3BCyZYKvUvN
    7sCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882288;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iX/goZ4SF0ZzpCX26cB8C7oGVPF623lKcob8dClrWN4=;
    b=VlXC7sndpYfxnC+Pxewlm8h/ewulvkxOErEKTmlm0diCbCgeDO9c+CjiaiSHs6PXD+
    6vFnyXfU7sJEnvEPMnToDmlsUK3S9abOXOHauSHcDDKpThgOsxoop5AjSy9YJqF24azb
    sOwrLseR/nSZwDNkajFYJkro4aV47ELiij5kEX6SwrkZf1gH6qtHDEn3qDNk5FYkc5MP
    zgIBIBKER/PDCiJQUWnp8e1OmQluVfXON5aHQM0Mo6FR58jH8EJeArIPMyJC1/w94qvW
    Z62zqjkG19tsjVkEb5uw03mWsEn0VOXNvTSvCaz1cPucQXcx1wK/TsJYgSnUl56sQ8Pz
    Azzg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882288;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iX/goZ4SF0ZzpCX26cB8C7oGVPF623lKcob8dClrWN4=;
    b=HEuE81fOujmWiU0xK6OG9y133680avjy9ZSh/Ir7cMJ/6Y5u68jt+mfcZbjFl8/P63
    wQJhAJlgPV3q9vQPoc//O//NmjteqZQ+4toR6d211PRQjRFlrvoLHlV2QhNhdQ3QJDJV
    E95PmfpSC2omHv1LCrlM6c2vtRWkcDx0zO8/z9yIZvPUEXI7ytSfOvRAx9nIkgJMDRXU
    Ph5hOhksSgijJ49j2eqNC9cSFIKcoqXkGOSHwBgGKRu0GfwyJFQX+6fYoQItYYYclwOw
    n44NsS1KkkSbCaxXFu8KbUPN7J/Q0QPKuDsmksYAmNr3n7TUjixMfLsxa/lrbygyW9Lv
    A8NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882288;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iX/goZ4SF0ZzpCX26cB8C7oGVPF623lKcob8dClrWN4=;
    b=juKDQn51hUZ+ooNBTD/FjpEsqiZdYOvzTi4Io2VO5OSYlyFSwyTavxP09//Py9PeMj
    nTTVc3IQYrR4PKvgdODQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8c7rQ5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:38:07 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/9] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 10:37:53 +0200
Message-ID: <20260724083756.12430-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072039-residue-friction-b0c4@gregkh>
References: <2026072039-residue-friction-b0c4@gregkh>
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
index 1263822..eb09818 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -884,6 +884,7 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
+		dev_put(dev);
 	} else
 		printk(KERN_ERR "can-bcm: bcm_rx_unreg: registered device "
 		       "mismatch %p %p\n", op->rx_reg_dev, dev);
@@ -914,17 +915,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
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
@@ -1447,7 +1445,15 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1820,16 +1826,14 @@ static int bcm_release(struct socket *sock)
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


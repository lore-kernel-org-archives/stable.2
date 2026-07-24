Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0090421232
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888775; cv=pass; b=Ot9W7gZuA0rcE+p+UKn7UiP4wM/8VVdcBwgW6TiLbUPC0+mdF4EdjoPt3pa2KQ1BBkT0DpsvRIKZhqpXEvmzxWHkjh8XJsySDgG6FfUd35aTl8lEZJvpk8UwNA3oJTzjK3ZodzXCBP8DRiNC2Hi58U8E+QcgMkewS1UeUrunep0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888775; c=relaxed/simple;
	bh=zoHClvKuscEdp6UzhLoX1RarT1CP+sv0Af8u6jwKEic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1aa+M0DFxBtGCUlDnOzLPFddGDYL/AGW6C91ZFhUD6FvY3bni2Qa1K54l0z20uEhGaY60Oe8GqzhHfJmSgDaAczEt2mN9S7QS03uU/sHvVgjoEcyBIm55IaONFp/1yLfhybruBL/hdL4YskxHN7iLrwLRwSlxrfingRZfdBegY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=E6LTEmRU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=7lFpvMXw; arc=pass smtp.client-ip=85.215.255.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="E6LTEmRU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="7lFpvMXw"
ARC-Seal: i=1; a=rsa-sha256; t=1784888767; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TuTADGzQshOwebEpTWB9CkZyqle3g2E1inXe5HLVxyYo7esCyNKuLVuoOkl7wWooqP
    DWptmEQcCqbybBPWEP87xOqLEApi3cnUpxnQ/Gkh29xnDKBB7h2p+Ce8H6qYul6f+p0B
    ziFecE9b2y022PPDYCNB1bzoL+Oe9GT+Xt/YnkgKHxfZtaj+bGPc/PClndZZAMmohnba
    CQQtIcVKV6LWV6KE7r1n3svKiFHfy43Sqe7tD8Z+ObYAbm5dI5z9R1a6o1DSlJ8DlsCU
    cxkWMZO44t23gXXsmiNphOqVdTO2dV5aNSvYZa64OIs424Rm3n7KUTu1NCcY5PNl8eg5
    43dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888767;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BsM02ENHl1Ek2EfMzXFCuPVI1uLSJ2IXMgR6UVC81yY=;
    b=d8expQWYOZatT8K4JLeRAdhkMOZDGGq2p7u/kpZjjfDmLANvOcEOp+nxCjiFAWTLFg
    IxrLKi3hCBJDAhhbdE5W5k1A4p6cHg3toMt9CYftHQ8vyBu1/V8JnI7ZBwsg6qih3Yz8
    WV6MyqcvCx9pNZ5xchMXK58ExyO/oqs5abpON3XyqL0XFGlsZ/7zkJJltiEKAvdIXe7R
    TW2hw13yaN+giOGUsWZ49qNKcQy854XikkkEuXk/RPd/Ew2qrRYd4Vc2F/Ai3wWLRcW9
    pI6plXjfO5vNVu94fQDOx7/MSrMUxykHhn7WFWd3ZUShQjMfx/WX1kOiozTEUdDZj1B3
    PDmw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888767;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BsM02ENHl1Ek2EfMzXFCuPVI1uLSJ2IXMgR6UVC81yY=;
    b=E6LTEmRUnZVzb76VhXeNJihQOyEGdVv1kU/Qvf0OyiEstOuQv7f5bzOcyJm9iO65yd
    BHI+AdcYo1GWApwlAfTdsxtwBO0ipW51xRM5hqAX+8n4PE7QHnhJhmZCqyD7PZOlg8kz
    1WwWzq+PMkL1jSuorOlMehBo+drQ9OD/ag42l284g4SFQetTK0HZsByucUo2WoUrX/r6
    gLHkq2mMAqWLEWlGD0G1pK3EIZbTDR0gwlWrtYo1KZ3Vl0qiIjymVeg+7TUruFh+3IAi
    8S6Ls6h/Q74wbCkMhDGFTST7vHiMqCyyIpDw6bGVrxsEF2wfcd1t7HtaLQzs9ZMyWASu
    vmEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888767;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BsM02ENHl1Ek2EfMzXFCuPVI1uLSJ2IXMgR6UVC81yY=;
    b=7lFpvMXwFCpF89anHSd0GxGOUppOBUfp1GvZqVP0n8lId1GcIdC0oHI0xPO0koOVjb
    CRgcbu3to+7v8ZoVHgBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAQ7tJN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:26:07 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.18.y 5/8] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 12:25:55 +0200
Message-ID: <20260724102558.17056-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102558.17056-1-socketcan@hartkopp.net>
References: <2026072010-winner-hurried-07df@gregkh>
 <20260724102558.17056-1-socketcan@hartkopp.net>
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


Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A9429014
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888667; cv=pass; b=inIaNbgvfJZeHCiFnNv5ceA0Rq8qz94PnKnurUJ2Ul8KpuOz1LtVqpgyfPvIiEsnTLB27J+anHTBL77KH0LSARSMRKRX7bZzLrYIg81An8WsvK8KBpwIp0OhvwyPU0cxPNo5I9MG4SfoTx5s1QmS592cQpoDSpU/E7G/IY0I96M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888667; c=relaxed/simple;
	bh=q2xzxUGh0+Y23WVnwmkYiM1oZ9u4WfOjbldMB8j+ERU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYHwenCZ3jRm28MZRH4afuDaviBNDNfmVBWpERE9+5f2EDdUyrGeGt4lq0zV+x5Z8OcvHW9bd1ZBFe72YrmThEHV+GJgwK0sVJvaWjnMk2Z0QunPJQSamkSyCFp/JSXfLBsAn2jQlLzM8pCyhtwl6Hout6XYFt7AnuPPnPdKoaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jZn2asa6; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=1DFmMZ9o; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jZn2asa6";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1DFmMZ9o"
ARC-Seal: i=1; a=rsa-sha256; t=1784888661; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gk0kbA66T5DY07mBVEursMAIb73WGwR05erpd+cGwik7nRURfuow+a5lXW98kHADgv
    PupGPsyeRYlr/mcDMDsQ/Rg/W2M9zyuYBWsBX31fvlGW6nKoXiScghgxzO5grAIQSm20
    joOtq9SAoAdHd65/rqiMTyM+WSC7iDvH//ypezlBBfBAKVZzgBXgIU9AYIenT3zHRCbQ
    ksJXZO3QX3s7CEdWUnKNrTjpGAJ2IO2ONBEazAQ6fUSn+wo7eN339vDnH/rZJOXrhamP
    YSXFqaM/QVDm0liwqBebYSdz7Rq+BiwAt/Drr12rT2Ql/hw28LeDu2FD1pY0jRwu7bvs
    pTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888661;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vBReU3ShT/ZCzKy27sfwRtNF8oxxicSuRCLFyVOwTtg=;
    b=cs+et+Peeyb65PpH7XBmXkHg1FO9S7gpGYpJI2tf7b0CiEyZQgiBY+B6K4e7KZdRBG
    bgcvaMzcO8IJ18OTbhK5txcCI4RE9iwWjGqJQU7Olag04llB41Sfh58bSRApFnRHoYWu
    WveSt4N1YOrJKj6uyQWo4phBldLstonjUTq6+pJZLBIxkNvg2HL3uUCaikoeKVqSt2t4
    G1QX2ndfvhEU/pgWy+P2r+0s8lN2BOEVL9ZLwMb9FiKTeoo9spb0yUU6Xs7KNr0inRXa
    Bv2qMWCGDhpFMSVpp63t/cmvR+IYvX1ZhEeNv+UyInMpIqMjaMc8ApHO5Y36Vfu5/7FC
    DJuw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888661;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vBReU3ShT/ZCzKy27sfwRtNF8oxxicSuRCLFyVOwTtg=;
    b=jZn2asa6Ck2dNhZTVE27fW8rWw2JqGJc25w7zMHR8CYraykqu6vWc79Q0V7uQGxObQ
    3u0R72uLNERaXEyheWXANxB8+PBnpFTn0NYvvcQ42itxus3e5RjnQC+fujkEdXzoJ+Hm
    5CF4seMJMiz3fd7sjR4jZcuuWbsbt22+nlORfzEnX13H9nmK2Lsir5yzaCfQHOZ/3Lh7
    r2KS8OyOkrnnkvGfU1vAFC//ezMfhirk0Oowu80at38F83Dd1MHo0e33+KtHaqtbgpAi
    UifcW6Ia+JG9dunxrW+xqgaNiX4Nr1ku1wK3Hrm+QcNdvrZUUGwnXDMCdA06xybzU4So
    vEag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888661;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vBReU3ShT/ZCzKy27sfwRtNF8oxxicSuRCLFyVOwTtg=;
    b=1DFmMZ9oLrBVafwD06NakIm1X67C5MnikGRM2sN4a/OAkdAzYwL2U2CBEfIt1nrhD4
    +uLKm96vmV4WwbvTeeAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAOLtIc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:24:21 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6.y 5/8] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 12:24:07 +0200
Message-ID: <20260724102410.16731-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102410.16731-1-socketcan@hartkopp.net>
References: <2026072011-untruth-wrongly-ed18@gregkh>
 <20260724102410.16731-1-socketcan@hartkopp.net>
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
index 01773cb..4b6accb 100644
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


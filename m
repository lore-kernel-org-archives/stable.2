Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58603C76A6
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882407; cv=pass; b=qUIdcSQzI/uEHwcCuFlNU9FJ72Xo51qu8IcS2gZ+8i2lkbOnIAfQCUe5pGz9MLzmeGHbiozwSPd9RFKPTd7Ju8/0w4g2S39xjCiD0IDiW9FhWWA70cORT9w+z1W0/4s9TWpZnWUbv775fbYtFY1vc4ea9Q9jySWO1E/ixnQ+V+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882407; c=relaxed/simple;
	bh=q2xzxUGh0+Y23WVnwmkYiM1oZ9u4WfOjbldMB8j+ERU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4Li16vstpslMmHwwMvgn3U4dTIry+T+luRUcEcN3DT3EOZ9HRMZ1oUsJJIgDLdTduKD2s0rvD1HNoUuIYMmZ3OY87BUCisT+CHWGM9LYWen3qXFeO/lm1M1cv5D1+NLGGCwO/bjmWhYCQ0YwB4yDYkudhSMsOPWVTBOVLxcxPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pBXFMKB7; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cka7hKRH; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pBXFMKB7";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cka7hKRH"
ARC-Seal: i=1; a=rsa-sha256; t=1784882402; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a50dL2P8PgBWs43PUQA4oE1OQ5iyS+9QaNK7G5PRrR+jQ5sFVmXfq+BW+6Q4Qe2xqV
    ELczjpRDQQg18JQTZpwFiVtXMgTDJELfChEdI0yQhK6Q7X1B8qaloKV1TEnmj1Fte2l+
    ofdAQybuOI7S4Y4GDm3QUEAIEd5EE5liLSsdX5pdfa2bwtNtjSMCaZTKkFEALquc2Z5S
    j5VLNa+AtU8wob8NKv9551Pkcm5oPvAgHmY3aAFmX/4jgYUj3Nghn3rTQa2LcgikUF01
    nuBPagDJiV+rd5MJJCAp3MZvidPEDUDhz9jXufYunHO1FIc467M167zSQuqdVOmB8tUB
    /kcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882402;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vBReU3ShT/ZCzKy27sfwRtNF8oxxicSuRCLFyVOwTtg=;
    b=JiUkuu9GIaEWmz1tMUPmRI+6SQxjhK6zDVGvvDAJE0tX72sre+IQ16CBBRfaZWJ8OC
    5fnwwnvAdx6nF8uaMmLda1ND5NAqMVfyMJCvFELTl7YzWz0y5JLHcm6M/92v7XyE2ri/
    +B8wFx5ugQ53pOXDKyVEg9/ibKINLGsz3ushT26wXybjcqddDwfDclMowfxm3XjX5ecA
    xiHw+gqLP7ZPFwdbfC6TeDSI5Fd66zrXC2bO/PELPPl9DCpu+90GFrbqqnzxxKnorTsu
    6WAoPT/vyTC/XiTR0sk+UBNFP2Bgb166M6MLloAJSthd/cxSlXlRAYO5NWfrSy58xD+m
    gpEw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882402;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vBReU3ShT/ZCzKy27sfwRtNF8oxxicSuRCLFyVOwTtg=;
    b=pBXFMKB7FUi8BE/lvz63cKFMpJVJfJadk8R2/D2q3UskfsnlHmowzUSZiRw1qit8aF
    bHXgOaVJytatx39Yyw7Zp3vNEDlQ/GYX0MFthsTVZ6z6jZFmLzVRYMvHa5gA8DYLJxzd
    OoHvZy4LA19bz+Zrw2sr/Oty98A23/06zaGjyOIOgTMrZzr1MzbDphK8A42fNlXPG/Yz
    71uoatfDS7bqrI39B7U2t45aSC/OJL4GqQ/730NAYs5VSBOfR3NgYr2BDJR3fXNDFsM8
    QtTdxQTKcCa1SmMsphEj8XRVwkH3O7vxQ8tJUzkiRsqbJlMoQNUXVR/LEAT2BrPy0vDk
    ptKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882402;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vBReU3ShT/ZCzKy27sfwRtNF8oxxicSuRCLFyVOwTtg=;
    b=cka7hKRHy01lPZrR01VQsa39qjtBK94xzjBnCThO3e5jHOK3ypn/ePY7YvlXAC3b/O
    b9vV0etzLb8VwD283LAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8e2rVC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:02 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/8] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 10:39:51 +0200
Message-ID: <20260724083954.12817-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072038-cosmos-bulge-2f0e@gregkh>
References: <2026072038-cosmos-bulge-2f0e@gregkh>
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


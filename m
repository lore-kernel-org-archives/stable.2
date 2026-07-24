Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA8279DAF
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882346; cv=pass; b=RfzgCXtzVRkkgfscFX6SKW+ceuZ1khwlXjXIGJKcpmWN6/XuZTehRBUlEFYdiRt/DCu7EElTYQh4DAo2sP4Uif+O1iNoOuT3KEtSdBSPL2L7b5zaKRM4y7XFDBy0ZfCIwZhML/z0wdRcJkEOyLIADKGTqb/BgPIgPnDP/Ltjj74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882346; c=relaxed/simple;
	bh=xExtmjr/eczfCNapZi8boNt1voZaYejWd0+UgrhkdD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9ewLf10+CFNYVN5ibmq5wpLpzOmEiFPx77mrAo96vd1aMIeQTHvnhhk6x21bbUUsnkejyiCDRUeEBgIrKGSxYzSAHfpR+mrUq55CnqNwAD+mcmo4kWYmgXQvD7KjoA+yD0NjJ6z1AlJDk8zJs+2qBah/rNaCkbtNmnA0eXUtm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BjdiGEGn; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=5Vx1N+vo; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BjdiGEGn";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="5Vx1N+vo"
ARC-Seal: i=1; a=rsa-sha256; t=1784882342; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Vef1wLYQPbj02cWJpP06LbQzGzle66teSKt8VP4zYeYWp/PymTWZg9IYG/RrZGcW2D
    VXBVtPSGGuYPmAS7YHRHWVnUhKAPGn+x3duJdrX3mF3RncCZGeUhOPzygmJ7qAnYJxVt
    6chmJvBkIf1Vfv6friMLVjo2XqxTSMFQmnqprUvFXXJCd/PBz+m7IwBZK5fne8VQVsgq
    tJ541qlXRu8yIp+yQzB7txSORfJ8SvJ0rcvpfWxISLjYp89CAofjhFmtsu7OFJKZKAoZ
    BXlZ/lWSLJ/GZV3xuiPyu45YyEGoDtCw0+n33Z6UXxJQAS8Z4SJLponKkS37dcqIYJvL
    1vWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882342;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wBlRCUhK4GHnTPGFhH0J/e7zpoRJ6AEmC27WnPwo4nQ=;
    b=FchbnZGJSk17tBToIl5MWZ/5MkRfTiPn8NyVyHpfNsmYPFANt1U1ejgw1kpS/lH+qf
    Vote0CHBpIveL60J/fq2neSAfjNWLytPsZ0a0s2cK13HFY57zNMHvQ0RDKp/8sMMh/5t
    HiWPuIGLECJNdFKbDhTjRt97S4/c+zF6XLkcvohMYmqELliCIYzENObAW+7lo+Zeh7by
    QHHAIPbOv8R2a7og145/jDQCXfiWX1o2vEHIJVKFMy4FX0sjZgK4fQyWYiUZHuesvDG+
    kz7xzLXgfaikJzDqx9fAj+dxqy7WLsfybqSjosULRyIgB0AGfBldwllb6e3KOFYHTeb0
    HlyA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882342;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wBlRCUhK4GHnTPGFhH0J/e7zpoRJ6AEmC27WnPwo4nQ=;
    b=BjdiGEGnUf/6GI+pG/OZG/A+HiEjl9gGwnlHAEmx0r6seX3Y10Zy15+oIQgwRgrH34
    54iJkqFDSsV8SwN4QclVJeheqz3SoqBEQCUI7KRYiausrbxTxjEYJqoRP9FKS23u+XsW
    Mw1dFVjwXBCL0IBlN82aIotmn3QTFP6FjaIE4Xls8fdyT9bKJPGk7jpxthvQU18EhxZL
    rsxEm/MRo7ubgQF9xMrOrMbgQWYkICh+DXWMkOVG5fXTonnEduEFkzMggLfY+Qi/6D5A
    BgMyp+eB+RMCne/8JsIfhYMyEXZxHR23wEnbzic0HrUAnbB0+3FsI5WnEaledliPycn6
    zw3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882342;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wBlRCUhK4GHnTPGFhH0J/e7zpoRJ6AEmC27WnPwo4nQ=;
    b=5Vx1N+voC1+a1kaDiWEDjdkO3xLqVF9Yely171GMlE9o3Ct0i7bDs9urQ40DRed4rP
    tE86WJ6gv7w26Wm35QAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8d2rT4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:39:02 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/8] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 10:38:48 +0200
Message-ID: <20260724083851.12603-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072038-arrest-crowbar-f910@gregkh>
References: <2026072038-arrest-crowbar-f910@gregkh>
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


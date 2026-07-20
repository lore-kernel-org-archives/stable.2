Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7322D839C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560539; cv=none; b=iQkEA/ui2VGDvIyi/xpToxCRzm9/nNoTr+towJZeFFtCzS14iyRZkl51ygyKEtpXi/1wkU9uszID+ftmWa2HuLaE+zZ/xmD7Mo7X/rv5o7yZx3pzbpVhvoYvM1oPQws7VTlsxnYqPmF/wyUOdpfT6RDfDDYNUCl9powjH6OEZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560539; c=relaxed/simple;
	bh=OrcrrPhjia7OqVX7s2P/FjTVPKk51bSo7JCmjwhS4dw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FvMwHEyhzh31AhlTS44iRlYc7keOJJmxkRJJ0cwqdAfyCtLO884QNig5gwDryI1F5+eWGDGAWCJg/ptXaS8rCHg2vFl7VPZNE0E2RopVPmb6Hy6KdCIZVH3mPcrqBoUQALDO8kXdw5OY1ong2V+cI4Qk7YAtYlzdtgseclT3BQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PMFHPHJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PMFHPHJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94781F000E9;
	Mon, 20 Jul 2026 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560538;
	bh=oxQgU+wgb6vYYF9yzTPsDhvT8chg6ejs9M6pwazJO2E=;
	h=Subject:To:Cc:From:Date;
	b=PMFHPHJc1soWFQY514bnERYu4ycbMUC5SUUUdXTysWdayTLiiv7W4TMU9wdKDWpMx
	 kCJ6WRHe0CRkCeBF7IFjnMWebipf4eknh83FzEi/o9CoeDuUnYo9be46LkT8NfkQjT
	 QqzUre0mLNWyQGW5bclrBenr7RkI6clWnrhVEzrA=
Subject: FAILED: patch "[PATCH] can: bcm: add missing device refcount for CAN filter removal" failed to apply to 5.10-stable tree
To: socketcan@hartkopp.net,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:14:41 +0200
Message-ID: <2026072041-silica-outing-8bb2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d59948293ea34b6337ce2b5febab8510de70048c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072041-silica-outing-8bb2@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d59948293ea34b6337ce2b5febab8510de70048c Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 14 Jul 2026 18:55:30 +0200
Subject: [PATCH] can: bcm: add missing device refcount for CAN filter removal

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

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 2d9c9cd74536..25842061800b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -128,6 +128,7 @@ struct bcm_op {
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
+	netdevice_tracker rx_reg_dev_tracker;
 	spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
 	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
@@ -937,6 +938,7 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
+		netdev_put(dev, &op->rx_reg_dev_tracker);
 	} else
 		printk(KERN_ERR "can-bcm: bcm_rx_unreg: registered device "
 		       "mismatch %p %p\n", op->rx_reg_dev, dev);
@@ -967,17 +969,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
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
@@ -1496,7 +1495,17 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 						      bcm_rx_handler, op,
 						      "bcm", sk);
 
-				op->rx_reg_dev = dev;
+				/* keep a tracked reference so that a later
+				 * unregister can safely reach the device even
+				 * if a concurrent NETDEV_UNREGISTER has
+				 * already unlisted it by ifindex
+				 */
+				if (!err) {
+					op->rx_reg_dev = dev;
+					netdev_hold(dev,
+						    &op->rx_reg_dev_tracker,
+						    GFP_KERNEL);
+				}
 				dev_put(dev);
 			} else {
 				/* the requested device is gone - do not
@@ -1873,16 +1882,14 @@ static int bcm_release(struct socket *sock)
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


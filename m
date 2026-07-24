Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F6342EEA3
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888726; cv=pass; b=FHYZRas2HVLWIejf9RPTuXRCYkYqVtW6sr7qwEzh6BGoWD5TzdXG270iIOwklxm9dw9leLXBzFgPsmFYfHC3kqMW7XOzcCxPe/ba42txqHAf1ooShMrvBAfYvIC+VRkwC7UewwYrL1guOhz3q5A0HRvevsVT/T9vYBrJqZYBaYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888726; c=relaxed/simple;
	bh=K9Da0SMw3oefERuJjPB9kB+rhJ7eJuSmAioI4H7vV2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssnhQb44rWyDKa3LNcyCTSK0RaK6YbNqmA8oNqo8zBcrBzZuytdNHbpcqzdSngnI3XoYWnRBMbetgTQvkYKX39Wivwn/VPmSzsl2VY2w0OYfTx1OmTAB2357M0pSTNGWcATmDE2a2pHr7PZySTDe/o5eqPG3tI9/18O0NW+Gckk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hcle2DFL; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=W8YIgHgA; arc=pass smtp.client-ip=81.169.146.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hcle2DFL";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="W8YIgHgA"
ARC-Seal: i=1; a=rsa-sha256; t=1784888720; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qqEhk15J7UrI64DPrzniJR5hW9ZeiRli3MGe4bQBf9gmkg3Tet9rYk/+0zmCJs8vP1
    9lO9MC8S0LSA0DqKdPVibFaLIgkbLiD54fbJmM6Dk2gsxnNpiizRON90yaj3+eWrCaYZ
    A8bW4HoCFpb7J44q3LIrB+JeFCoF7nTiMZPdMXoo2oQNO9FcKeOLmQX+yPma8xOYCuiq
    6UsDQehqcf9mi5DIH3kz4Aj0hSGbpHY5m3cqIyZwxlx2MS+f4zz4CoHANbuS0d/Ju98f
    tl/JsOuVU9UgOM9AdhNU4hGnxH2UIVBkkaCq4OL4poUWLBqKcj3XeRpcPmDQiPVn3W5c
    /3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888720;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=S97pZa/smBNsYM1nI4/jmomwY13qtEbYy07XuyS9uF8=;
    b=ikxZsAn6hsnIhXrjwdo8K0Q4i7ljRp0J0WudqU1TjpWBrebwIat+efv7SQ/EJM39Py
    gna2YdA1EE5PhFXLYiS+qbUvqyymUd9QFWr36AIOo3DOzTKhE5h5PNf7knL6D8KAUwFa
    rLGVt+Il34bVLWZ21nr/iYiMskBZWi16YD4VeNhey0G4UVZbLFoOsCfFp+9V+9285qPM
    l5nZ5VzTVv0Z1wAbsGyd7Eul5QBefp0Krwsska3GQOeE6i87IB4OQfvhATySFPmBrRxf
    4wwfbKNAbLvPaZm0hR5CrbT5q2fSKSrwZLn6prhgUWF3BCzdjRO8W8JtL1FBh45t+OhI
    7kjg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888720;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=S97pZa/smBNsYM1nI4/jmomwY13qtEbYy07XuyS9uF8=;
    b=hcle2DFLjK367llv/GvALf6kg1bmGVjD3BTUoofTxoVTZ+sibdOX9gRXT3zX2FYKeK
    vuYdPKCZ7GEOsV7eUpXdmO/xctiU2qMjOm1XqkXoo0ALFmr0tan1M/j2A4S+YHrECzJq
    ZYz3T7LS9bwCZI+h4VaG4VTlZcU97W8AXmv9lyRkHx+HGAGQIFhUHOIpXUEcH1LAMneD
    yLtiSDjPJtEa4rfgC6On65xEgjnun2tNE8ev4Ds1BsCMSWDLrTXhjrWlkiTnlfTziyVG
    +TPN7SXadvAE5Gf5EsYazkPgwABT4ILxbUhjHLnaxZaUJ0C5urZ47/pdZv4unWwxi4rT
    JvHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888720;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=S97pZa/smBNsYM1nI4/jmomwY13qtEbYy07XuyS9uF8=;
    b=W8YIgHgA86CKYEArNhTwMW5rpV4o85V6S5l9WDZkV/rMZiNVuecuffaSgzeIqt+pbE
    GUjbGi5rxynDizKeKmBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAPKtIx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:25:20 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12.y 5/8] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 12:25:10 +0200
Message-ID: <20260724102513.16898-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102513.16898-1-socketcan@hartkopp.net>
References: <2026072011-atypical-tapping-9d9e@gregkh>
 <20260724102513.16898-1-socketcan@hartkopp.net>
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
index 80fa80d..819c7cf 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -931,6 +931,7 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
+		dev_put(dev);
 	} else
 		printk(KERN_ERR "can-bcm: bcm_rx_unreg: registered device "
 		       "mismatch %p %p\n", op->rx_reg_dev, dev);
@@ -961,17 +962,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
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
@@ -1494,7 +1492,15 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1867,16 +1873,14 @@ static int bcm_release(struct socket *sock)
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


Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3993CE4B6
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882632; cv=pass; b=ITZX60JgSuOfuP63sT+1bKd9waYngtPiLHYWuOTTKrlnr3FN/xi8/Q4xk8p3eV/7zDtVbp7+ushZalAhV6Ow3uvuf70gRAi+xx8TQyScWcrd9Bgpr3iXLRCrCrp5J2LokuJcNT3NEeLPQWMrY+bjhC4q5yoJ6PImDgHTuOCQ/9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882632; c=relaxed/simple;
	bh=K9Da0SMw3oefERuJjPB9kB+rhJ7eJuSmAioI4H7vV2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPcDrZTQDGwhCGQ9ycaPYcFHPqwEnqN5TojmKND5T3+8gkVQzJXI31qumzMzKw2vFqR1Qj305aOTe8hSLgSIbY1b21jaePdOCHpsUGrTD20V3abYK9dnJvommWpzCxw44enzbPjmHdfn078bwS7elJLTCxApRzAx5hFKA7hujmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iNwjIOK1; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YRsh/CdS; arc=pass smtp.client-ip=81.169.146.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iNwjIOK1";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YRsh/CdS"
ARC-Seal: i=1; a=rsa-sha256; t=1784882449; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZOpvLlwWj+7lGrMZJk/c2Rd3kVQO6zMhqtooAQuR5aIISzJ/zCZZizgrWvjKC/bvef
    aUXavw44fI1DxEv/ZBvc7IecFN5oQ80QrB90DwNJx0PSmXUh1dtQjOeiyy/1vxzND1Mv
    U+5m/TG9WZ75lHtbwpGj5FRgXBW/SEK7IaZJOrEh7lOLCPDSkefw24d07aASc0cr1rQ6
    2j84mtNvZi3D6OUwBtD3Ywv9wHliRIIzjQfh/f3ndgJ9Evn4RQg9sTNeSbjQo0UY3Uo7
    sAMR0EiR1bCj9APCGlpuGDb6BcfxPKNeHnsIMTgLqmpIcIw/besJatCYDDpI7LNz68IU
    4ScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882449;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=S97pZa/smBNsYM1nI4/jmomwY13qtEbYy07XuyS9uF8=;
    b=Tv93spVWGL5YaMiDv+eJRlCog17tcw/aVnTJ4l/YCNCsgbiDxdDhLyjYhUqXAqELRr
    cU0bfLJsbq2BwM95W3hw9WbysgGX4q1BqWFmCfETiNzNLfLrjIssoNFST2j/jAzExA/e
    mrARvyzAVnq/s2FvkKl5AnAvBlqTGxl7Uk4UfeBNt8KTtl32zUTDwhUge+6bQtyYZKwc
    pWPKrtftadshXth5GtdpruESkvT04OSDvnUmJKLmnmnJSCtto0YokbZLPmPhM0X+bWqX
    Ji8V+o53+JFloZZh46uYp8cMDJO2S7WHJdm3t8+S4G8cYzbEqhrtCG8vEHYU1y+UBkp4
    EY6w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882449;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=S97pZa/smBNsYM1nI4/jmomwY13qtEbYy07XuyS9uF8=;
    b=iNwjIOK1GPIHpUmqi7VtaFyMIT2mKviw9m58ZHiJ3OPAcstl3NhSfGr7Y49OavCr+Y
    SjXw9bqPeIPf2VBeH63ovqbcVLD0F2HpK6gk8ZVkFQjrLDeLyFJSuyW6Uyu1i98acKaE
    HB0/JNdaAVvG6dCPnts1EwY/MsD6GVuL0yBAssrJPz4PWC+1CWPKVWIFPJYKUkuIfCJT
    lw0xuLBzqjui5C2RR3VOo+SgV2p8wvY4ahU7lA1d7dUS7QC7V5eSvRQMuC+dyB3V4CDl
    Q2ePFPWh1B3A//zZZCozyJ3Z/w0uF8gvxG8DF1YqsN/NtbQR7nZvPwRTr9SZ/Dmsk+Xx
    VCaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882449;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=S97pZa/smBNsYM1nI4/jmomwY13qtEbYy07XuyS9uF8=;
    b=YRsh/CdSwhLCNrqgYZO45yiG2sEevPAbQuv8acA9NfgCiQOEthLkyCXly/62dZwTN8
    g6dnogf4ZNWhi4glZdAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8enrWv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:49 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/8] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 10:40:39 +0200
Message-ID: <20260724084042.12984-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072038-herring-ruckus-b265@gregkh>
References: <2026072038-herring-ruckus-b265@gregkh>
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


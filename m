Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903942047D
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888057; cv=pass; b=np5kFX++4Lo8HjbBNMAhTcC9QGyG4j/ArwpauYl33MMu6IlcV3IzAXMwbfDMvtMrlFKeV/k+1HGydsLdQHKSDUGDl/sw3yCVKBi6RlnCAq15faK/QRmfukVa7NEDXzwVVzbt9TSp8Fjg/IQgXeUmkbze5UJPV/lg+OIBzZHnMDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888057; c=relaxed/simple;
	bh=gVZWMtPPTdie6OGnB3bUjD/Uqkah1actqH0OFZETEF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBlgFV21yn5WUQJubhBTqgplVAHU+zilW1rv14s4FU7uncUJ7zzNc1RLu4W1FO53aO1DxnsQUrJOH/Br4D7/VEHlrTCVcy9j2XzyqrhK2Ajppo/sNGzm8TdbDpg2Pk1O7J6j2VN16+voklSPvmiwAxzfyA2s/apqLNHZ5r/4b8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FkYb5q18; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UF1pJtOX; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FkYb5q18";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UF1pJtOX"
ARC-Seal: i=1; a=rsa-sha256; t=1784888046; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QTSupsDuPQlLfEu9bH6ffC/RHsXqF6m33SyXcvbgHpy1lPVzX/qB4OJGPaEkvxPtUf
    AeHoVlKaqZsOqKp8YmIvoSjEQYK3cP2E6oFvw2apWamHJmEti0X7/edSsN0LIiFzzgid
    +plXNBHERDBhCcpaz4GgFAileA926zvnLSTk9SRWqfvhh2Su/Vv8ULjTIzo87fE8Hyvd
    Ypa9pRikqYv7iFL6lkThs4xRxtq5gGrH23ELwc1u8gRByQnlALTOzuTx2bO/x2+6pxkQ
    1tXIStSq70cz0EEPSzhoY2zJlAKTPA//+K/hhObJrU1nnP6YIxPSMxoAWUQbh5CkyfrP
    2ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888046;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG2q8t5FPzWNcC2UNvxbsr1Lf7d/AMaWfAt5xglMNtk=;
    b=W7s5956bvE8BIFURysPvxHfpFGjXIJ2DPjwVimU8CrLBwRBaiw70PjBe4GAVjVc7tH
    FXMGHTtRJF8R3NSghzJqzSTCvwUPOSe84hzI6apbYxs2ND793o9Ze9XmGwPLhAVSlDbi
    P2k8jPg94BdVVrQSXPsLFlNJvNCEocoAMXFOv1cyFBrHp3B2zwdDsVBn2bDRvbGxnGVa
    FBL3mlUrtaqI+SKuigQKILa15cJUjRIcK5vojRnU22/V/+SJtFgsFBWORiocvxnsDgdZ
    r4iYYO+ZnCJLeX+S1ebnlIvEOWzbwo8TrmiNJvo1m48kaQK9REQMV4UHcxDvm8IpuVdY
    m3mA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888046;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG2q8t5FPzWNcC2UNvxbsr1Lf7d/AMaWfAt5xglMNtk=;
    b=FkYb5q18PKZGdjy97xKDfmYzqq5UwAljFMLxNFRsy3hr0wrZ5lQ1qJxdTuOICkXu8F
    UitjSUwYeZZXtnsFP19IybaP9KQsFsh9Tb7pxUjApsVsw62oES5pPyh/LiFOCNOCLD8Y
    vkiiI7XbyOAJQoISLiiJp5RX4xTlr2Aawgfdg2YB8ngqz3mCdoqJ4faRV4nAmTkomvY2
    QDOEgqH8DumdsPb7zIEuMyUIVYxmAQG7WQ55iJqIR9e5ytwFeP5N4G9+/fwd3q5Bcgum
    y6tghKFXjsn8TwHTx2/NpjF7RtLws1M/KHDhgb6TiHxAMTyi6ASaSfT4JW5JHn4XfwzT
    H2Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888046;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG2q8t5FPzWNcC2UNvxbsr1Lf7d/AMaWfAt5xglMNtk=;
    b=UF1pJtOXl1BWemiXae5t1w7aUcY3Fa9gdomBg6nn/cHjB99CERp71wlzog7Q57KVQv
    h+aE/phDZpWEAD2BJDCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAE6tFG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:14:06 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y 6/9] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 12:13:39 +0200
Message-ID: <20260724101342.16000-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724101342.16000-1-socketcan@hartkopp.net>
References: <2026072037-bagginess-bluish-c081@gregkh>
 <20260724101342.16000-1-socketcan@hartkopp.net>
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
index 09a6bd5..813087a 100644
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


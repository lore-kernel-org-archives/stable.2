Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2142A160
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888527; cv=pass; b=j0Ehs8yCE8IHssVkTCWdNL/tkZeeUlXdPHO62vzApU5I8j3EIzfbRbhVmOEldduHJI5ckZT9FTYred/Q8sJhm+UTZtyg2yrcFjZvU62PIQRvw2kx95gcwWb3K6BWmq6RV12RS5GPNYXaheRV9XzZHMc0dcAKdsZ1Me3IWHIkucA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888527; c=relaxed/simple;
	bh=qzM8GUXCgxZajg79iEdmDxseMT4fA+4rVbXp6LUCbdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvz9AXTbbvWNr4+cUSDzWirsviCOOCg36qb2xEYQQ6hJ4qAW2CSpd0IVe2aWEfg8xifRmUWSAWBZUo9gl/BgDF8QKm+yQvjoxMZs4lH2lu8wucaMHVPafIxwNvx9T8YoqHO4eSWMFHorhaLIEuYPkUNP6Qhdz6wSzOMol/mhYQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XwvnBP65; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aRTBudlW; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XwvnBP65";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aRTBudlW"
ARC-Seal: i=1; a=rsa-sha256; t=1784888520; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tluBnwcTObtILESqUsHgxon11fn3PwfMQoe2YmfoCNivNXgyOLlrUl/CWCfEaydN32
    zZzvPvbWV4om8Wf7C252YEkslrSwymgDX85LxMvwdiDDX6CgvRqALSZfRSaslij4tBIt
    wQtsOM0ZpOWD5Z5th/K2274e/kRePKuCXDmTE91lAaOxRws1UCU1hlWDm1++eACsEg88
    znSSldZyJ0ci9HJBbIbGnHdqC6ts1TYm1W3gvbfs2Oswo90zwIjSZAMbGLdFnGWncAOO
    oJbC00P082avh9TWshSxz4BuqZLyAEZsY0VIs1UTVXAWeNt/uSgx8qAs3te2IQB7x/lE
    L29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888520;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iX/goZ4SF0ZzpCX26cB8C7oGVPF623lKcob8dClrWN4=;
    b=K30n5tXOp73offrU4s30FkdK5GCpTCsct1/IaYu2xmhGX4saKPVzZLpNfZaX2i6g1r
    KCVOSKrt3z62nqjh0QaBRxpt244hj2DSMGjaVa9yEzvQyJ/fcfQnse7DmVO4ys6Uks1y
    kIGjlnqJW4q/Uc3ZzcG0xwqTfT5bTjks/aTRWdFTjyGu9uYtzUWNmg/MDhwVBFeOwTXr
    S3ubb0OcDlAxdawH5ZPKjgo21z9gKtzKuTPOvdf+G0ApqMay5QmBVCPWqfqhdIdiKaMY
    3UA3/TrOIG81o3WIMvxzs/uqlrzajUP/lLdxEb8G90/pMCrA+4R4wpMy56B4Bi0j03gf
    SDtA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888520;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iX/goZ4SF0ZzpCX26cB8C7oGVPF623lKcob8dClrWN4=;
    b=XwvnBP65FBYIhN0UbFOjQBASz4xK+sSVe7nL1dwnE2BFPlzoeYwdDfG/UcsofOgbN1
    AmBWh4Y9RNHDdrY96pMYzXz51JzZYv4IPVZRJAXu+IXCB+JR6SRpsMDH8xlLsEFjBgqW
    gUaLXv/QgMDLPsmCcPC/eiETniNKHJd/VozY0vkx1OyLH9fAEMbJp1IuwzQYulrquhIl
    Uh17i5y9stX5mU5/jDJUBHny/W+bvCGG+5aq53Km1VxRlfwR5zrMBWoic+Lnz2zAN4F+
    3Mr5t2h6+LwUIOR2cbsDABgfwZYwR9okUbIS1N2N3xnpJ/3vFsg3HPTVh+iI0zsjGUXD
    NB+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888520;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iX/goZ4SF0ZzpCX26cB8C7oGVPF623lKcob8dClrWN4=;
    b=aRTBudlWOD3G0ekjNfv8QEUpoafS8whA7NyfUy2f3kj/JZ9G2YXbIcSq6m9u0uZJOy
    N21CAjJIMXer0WoIMXDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAM0tHg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:22:00 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y 6/9] can: bcm: add missing device refcount for CAN filter removal
Date: Fri, 24 Jul 2026 12:21:46 +0200
Message-ID: <20260724102149.16440-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102149.16440-1-socketcan@hartkopp.net>
References: <2026072036-giving-knee-3a33@gregkh>
 <20260724102149.16440-1-socketcan@hartkopp.net>
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


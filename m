Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2D42AF93
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888623; cv=pass; b=Kw9IVSaE+m+TwkxCVhjaoyZv4ZyYQGiol+XFQAdiuGl7lLpWEaX0vYuivl2yDY3rnz/Ih1tVfvfKDcREzsf1bKse/JRnEN3Rs+/maiIGbkRvUUCJGvvX+3MfgayZI/UD4HOFpy1jivPtpz9sPLDvJKdeyGKtUXjk4f3xvsip7AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888623; c=relaxed/simple;
	bh=8VF4ZUC9tRJRXxiD6JweZ/bEyFMQNC0AelY1LWYPA80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MprBeaUsZjOhd0uH1q6k7Dw0y0CABCr0ZSukWTId/0uI03oWNtPudTE3nO1r7dt1aqHu7baOY1mpVA9JiwbknfZq/FWZq8RMsvHiHe+D+22I0zr/zFeiFWmWq2tkZuTa8TJtMlZGhYwTjnZf7VOjNZCbV1KBD5IYCp+EAz0We3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ppN1FZGj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tqEnUpgT; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ppN1FZGj";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tqEnUpgT"
ARC-Seal: i=1; a=rsa-sha256; t=1784888616; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oIH0L+WyCIkaaRj9yYL3EQlLw3VADDiL62dVchgoHbo8Lb9Iqztf+tU7iujDvS+RVn
    LpO8bdLGxhCYcmHB3lnnU0zfFKvS3t1jkc5LLsDOHDRy8iggZB5jLF6rvubPO7zIddsX
    A9bp6sGXEZl6DDKm0jCV7bAOi0jrL2XjVulGUp8acTpHFMbzXwgh3KaTRSJtmgiEhilj
    xjVv2Mc5TgSOe5DrFPLfw6ccaju0KpGSSN0P95WLJLvhmVk3pI7PqQivYwwJysIsOGet
    HhpYSdUZ42eq/Qe9clPt3uqkJEdgas5fpNGlTCS+4ctPsz35sIPA2VZBZcY68VTrOjR+
    5hhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888616;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kRzGM0MlOBcGBrDdJhxxTGaznlkuu26qT1D72jhapHk=;
    b=VqSUN1Fnozq3+7vJqgsXfrSw4y/GGuwG+tr9dvt0/s85G7pA0A4/k+yklIB3/1Wq2m
    NU5y3jmh+WVIu/6toNOQl0Owly4Ait8m+VjT0C53GXaOtLyIGFNUUbf/pndRvuH0DIK1
    ckZRQxPM/4m/W47z/4tsn/yXhouO0Ox4An+Gp8Gxkyb7kgyPxwXTZSOCsncCv/5u6oac
    zF/MPw//VzhHygsQA3+aJE6HHemzjchPOUwRBJLdVRlOwT6OVMW9zh5tL0Zm8bJh5duk
    dwnbPdTn/YNp8JnggBjnRAbovpbe/UYd1n2+LemK3Dy3TFT1irK1kPsvu0cwwM121GYS
    +XuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888616;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kRzGM0MlOBcGBrDdJhxxTGaznlkuu26qT1D72jhapHk=;
    b=ppN1FZGj1K5EoBVg9OL0M4+aNFSUtsyPt8rGr4mYt1Lvubb3qHPH5cmdoDt7sM+pp5
    ohK4c3b+7f8uqr+URuEo2ScUG9b1gGdh+TNoboY+f/7pGDgWzQ05yvcm76Nr0Jp/EeYO
    7IHsVOsQI1oKw2fNQhFZHXDjVGemr/zqd6b3PGoCUU7fGgBjUnqoWKeUO/ammotwcwE+
    VX0yB6y+JkynjLvWLTWDv4JNyjSqm/1RYVh+BJ3AsNkuJbpumXmvFDEL7frvFXYzoC8i
    snsBwSCJqESR60tOo+c0B7nVA/8+68pkJgYEQsCxm5o59CC36+9bbPZfkElc2rV/DFc3
    nvYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888616;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kRzGM0MlOBcGBrDdJhxxTGaznlkuu26qT1D72jhapHk=;
    b=tqEnUpgTUVVAshMNlKqS0uH2u0ZNArbZ3VGjhAAquCZlQsv4wMzgKcfBhTWD6dwFlY
    rUhVlo9+GBGk9u1fOSDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OANatIJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:23:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1.y 6/8] can: bcm: fix stale rx/tx ops after device removal
Date: Fri, 24 Jul 2026 12:23:27 +0200
Message-ID: <20260724102329.16572-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102329.16572-1-socketcan@hartkopp.net>
References: <2026072012-repair-flip-109e@gregkh>
 <20260724102329.16572-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit 3b762c0d950383ab7a002686c9136b9aa55d2d70 upstream.

RX: an RX_SETUP update(!) for an existing op skipped can_rx_register()
unconditionally, even when a concurrent NETDEV_UNREGISTER had already
torn down its registration (op->rx_reg_dev == NULL). This silently
did not re-enable frame delivery for that updated filter. bcm_rx_setup()
now re-registers in that case, while leaving rx_ops with ifindex = 0
(all CAN devices) which never carry a tracked rx_reg_dev registered as-is.

TX: bcm_notify() only handled bo->rx_ops on NETDEV_UNREGISTER, leaving
tx_ops with an active cyclic transmission re-arming its hrtimer
indefinitely to execute bcm_tx_timeout_handler(). Cancelling the hrtimer
prevents the runaway timer and any injection into a later reused ifindex,
since nothing else calls bcm_can_tx() for the op until an explicit
TX_SETUP update re-arms it.

Unlike bcm_rx_unreg(), which clears the tracked rx_reg_dev for rx_ops,
the ifindex is intentionally left unchanged for tx_ops. bcm_tx_setup()
always rejects ifindex 0, so clearing it would strand the op: neither a
later TX_SETUP (bcm_find_op()) nor TX_DELETE (bcm_delete_tx_op()) could
ever find it again, since both require an exact ifindex match.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-can/20260708094536.DDF821F00A3A@smtp.kernel.org/
Closes: https://lore.kernel.org/linux-can/20260708154039.347ED1F000E9@smtp.kernel.org/
Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-9-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 54 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 05fad88..c24fbbf 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1239,6 +1239,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 	int do_rx_register;
+	int new_op = 0;
 	int err = 0;
 
 	if ((msg_head->flags & RX_FILTER_ID) || (!(msg_head->nframes))) {
@@ -1323,8 +1324,15 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		/* free temporary frames / kfree(NULL) is safe */
 		kfree(new_frames);
 
-		/* Only an update -> do not call can_rx_register() */
-		do_rx_register = 0;
+		/* Don't register a new CAN filter for the rx_op update unless
+		 * a concurrent NETDEV_UNREGISTER notifier already tore down
+		 * the previous registration. In this case the receiver needs
+		 * to be re-registered here so that this update doesn't
+		 * silently stop delivering frames for the given ifindex.
+		 * Ops with ifindex = 0 (all CAN interfaces) never carry a
+		 * tracked rx_reg_dev and stay registered as-is.
+		 */
+		do_rx_register = (ifindex && !op->rx_reg_dev) ? 1 : 0;
 
 	} else {
 		/* insert new BCM operation for the given can_id */
@@ -1394,6 +1402,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* call can_rx_register() */
 		do_rx_register = 1;
+		new_op = 1;
 
 	} /* if ((op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex))) */
 
@@ -1407,7 +1416,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (op->flags & SETTIMER) {
 
 			/* set timers (locked) for newly created op */
-			if (do_rx_register) {
+			if (new_op) {
 				spin_lock_bh(&op->bcm_rx_update_lock);
 				op->ival1 = msg_head->ival1;
 				op->ival2 = msg_head->ival2;
@@ -1437,7 +1446,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 				      HRTIMER_MODE_REL_SOFT);
 	}
 
-	/* now we can register for can_ids, if we added a new bcm_op */
+	/* now we can register for can_ids, if we added a new bcm_op
+	 * or need to re-register after a NETDEV_UNREGISTER tore down
+	 * the previous registration of an existing op
+	 */
 	if (do_rx_register) {
 		if (ifindex) {
 			struct net_device *dev;
@@ -1467,18 +1479,32 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 				err = -ENODEV;
 			}
 
-		} else
+		} else {
 			err = can_rx_register(sock_net(sk), NULL, op->can_id,
 					      REGMASK(op->can_id),
 					      bcm_rx_handler, op, "bcm", sk);
+		}
+
 		if (err) {
-			/* this bcm rx op is broken -> remove it */
-			bcm_remove_op(op);
+			/* newly created bcm rx op is broken -> remove it */
+			if (new_op) {
+				bcm_remove_op(op);
+				return err;
+			}
+
+			/* an existing op just stays unregistered.
+			 * Cancel op->timer and (defensively) op->thrtimer.
+			 * Other settings can't be reached until the next
+			 * successful RX_SETUP.
+			 */
+			hrtimer_cancel(&op->timer);
+			hrtimer_cancel(&op->thrtimer);
 			return err;
 		}
 
-		/* add this bcm_op to the list of the rx_ops */
-		list_add_rcu(&op->list, &bo->rx_ops);
+		/* add a new bcm_op to the list of the rx_ops */
+		if (new_op)
+			list_add_rcu(&op->list, &bo->rx_ops);
 	}
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
@@ -1694,11 +1720,19 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 
-		/* remove device specific receive entries */
+		/* rx_ops: remove device specific receive entries */
 		list_for_each_entry(op, &bo->rx_ops, list)
 			if (op->rx_reg_dev == dev)
 				bcm_rx_unreg(dev, op);
 
+		/* tx_ops: stop device specific cyclic transmissions on the
+		 * vanishing ifindex. Cancelling the timer is enough to stop
+		 * cyclic bcm_can_tx() calls as there is no re-arming.
+		 */
+		list_for_each_entry(op, &bo->tx_ops, list)
+			if (op->ifindex == dev->ifindex)
+				hrtimer_cancel(&op->timer);
+
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
 #if IS_ENABLED(CONFIG_PROC_FS)
-- 
2.43.0


Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE242E8F0
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888725; cv=pass; b=lfKWGBFj+j1AEwnLNQboV5rAB0Vf6flgubfRz73xxPlalf67whRAHUisckJCXMGLr7bGId23o7ibB887FlAyxyN34CRv5JMolMW2ieLfUmPi72CRE3v30F/XEwzv0FQsjQGvAK/FlFAWNkBA2n7cbzpRO/qjEnsj8ICvBz8zWT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888725; c=relaxed/simple;
	bh=0rB/Og750u+9Ox4zYLM9QYveK2LNdBlwv+Hdf398IB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDg/Gtr0GjStfcp0kYj7SsjRHUKJLJ3smZvsKX8M6sYMFfty4Ug8gH/dtzGpuLRJ9hDI5i8b/1QqUuw0MRdzH+CVbHyBHLE0/bjCdbBTBe4u5jTKqVMJ2QhTjH9iWxqFbw/misMnzybAKVZH1c/Nf5kRMroZu6lcpyeduY5t2ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GKgRIwub; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oUgk6kkF; arc=pass smtp.client-ip=85.215.255.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GKgRIwub";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oUgk6kkF"
ARC-Seal: i=1; a=rsa-sha256; t=1784888720; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lpP7rszvcHIqH0fhvZVniaq8VqoZokW0NM2lTujC5FyL9Rp5WpcWuLOdTQYYsDnOIg
    HB0HUwPXQ+ziuvfthMvwjJFPRM0cir0uOeKi6MrLwFEBNQZO8GEHRjNL+6DP5wCrpR7b
    e0ldyVJEqz0LefonwyJHSJvLXL6O+rmizQVC9JB6MeVVEQT6TSnbIam1jX5R+4JjxN79
    m37SqKzs84CIMckjVCqfTv6/rdZPDE64FO5aqJcKDSAtbFpIoz+Md3JaGRAbNyq/UDky
    sD7XwhWX+aBFXrC8w2uj4YqhHoucHB3mzQiT04ScFi6xjv9cx9M7NSVqmA2xtWZFB/s5
    iiHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888720;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4ucuOlw3JOx1qN9KTR9MWNhkn8h46tQDv5qWhA5KLo4=;
    b=XxZ38egupmH3y1qg1Y/lycgSpLHc2mYUqk/g08qPOFjT3POcDIlnG3Iwsucrl/9CD2
    SnfjsMsGKTasWYw3CI8lqQ4zuY0xL5DXlAPKGNjlXphyxnZRwzzCO0GuirtykeeqFNzK
    E90E4CBX0mhZm27DQ0UianNFC7tU7/B7oxCHK+BS4ZPXDV3aNAztLYBnJDuEdrf4T8pR
    W+zop+DoxoE9sUkkz1/IyFMS33fxUhdeS5RaxXaBgAMs5TCoQYOhXVMaFOQ9LO9AbMdl
    0pLwIdiEu72V76hu9S/WkxTArm3AOPtmBjA0WrYrMK6ACYiuoa3qfkY02We8x4lytduV
    SI5g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888720;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4ucuOlw3JOx1qN9KTR9MWNhkn8h46tQDv5qWhA5KLo4=;
    b=GKgRIwubx4clpzYgYxrm8IZmwbj22iknhrOFy4CaUU//hhFoAvfFFnyzLfyUrgc0GI
    KYlem8xg227Bk1REdZr1/teQzr3n5iNEXPNSP0SaMO/jMl05H05BxzAg8Bf1LjOOYz7o
    it0pwr8+5hBvd2HkTvFEr/LRQG0If9f5yIlZ0rOAStMZSP+12+SwAKEa9eHMUqxgY3jm
    pq7HcU6z5zsfn4lm54uqrQETM2chyugS6ffSQPu4rShwS7J6dbDvVIwYXra15em9N/sH
    DJWQL9jbjzJ/eP8xaTvb/IJ6cmb5h+5xZJt2l9DER+Gpf9dK+gcCYvVm25JTImfvFO8A
    PEPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888720;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4ucuOlw3JOx1qN9KTR9MWNhkn8h46tQDv5qWhA5KLo4=;
    b=oUgk6kkFCyAg6QnI+Up6bKzr9hkEX0P1bAxXgeYBig9cMcTKyuy7F5paU/fm7KLqJ/
    ws9dCg9eA6WnDNDkm+Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAPKtIy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:25:20 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12.y 6/8] can: bcm: fix stale rx/tx ops after device removal
Date: Fri, 24 Jul 2026 12:25:11 +0200
Message-ID: <20260724102513.16898-6-socketcan@hartkopp.net>
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
index 819c7cf..845797b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1281,6 +1281,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 	int do_rx_register;
+	int new_op = 0;
 	int err = 0;
 
 	if ((msg_head->flags & RX_FILTER_ID) || (!(msg_head->nframes))) {
@@ -1365,8 +1366,15 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1436,6 +1444,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* call can_rx_register() */
 		do_rx_register = 1;
+		new_op = 1;
 
 	} /* if ((op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex))) */
 
@@ -1449,7 +1458,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (op->flags & SETTIMER) {
 
 			/* set timers (locked) for newly created op */
-			if (do_rx_register) {
+			if (new_op) {
 				spin_lock_bh(&op->bcm_rx_update_lock);
 				op->ival1 = msg_head->ival1;
 				op->ival2 = msg_head->ival2;
@@ -1479,7 +1488,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1509,18 +1521,32 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1736,11 +1762,19 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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


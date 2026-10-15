Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E53783B5;
	Thu, 15 Oct 2026 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029227; cv=pass; b=mGxIvREG7KTGGzGzn0cNJbR3He60B8bCRIsUEi7jQvO7xJStlGLmkA31/uzqxhA/miIZA10oMpeTtJb9QQ5RIfRPX3MyjBSj9a2B1BVjC/aCghvWUFnMivDwDnupatGAZLMFcRbpCeZtwxbnt/tmDOE7qKr6GhoMcQrnbUov2pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029227; c=relaxed/simple;
	bh=H/GmaesEjcIOfMkeE7bcEdmT3OMM3noBCwuG2IgaWEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbafIfqEp9HhCwfeblW1jWUDdci6RPGtV7zBuojUXnNKqMhbe1JyWtJjVwxX5ePAXOUVNQQDkf7ll0/Ov2+glbMfwanOG9ypZJhRm6HEPd5LNlsP7lPLWCnPgdvPSnNvY4iB1IqY6JIfLzo1vwgYRXkzwb8cqjjX8LFOW36LGog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=YQkDPSJZ; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="YQkDPSJZ"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2BCAA202615;
	Thu, 15 Oct 2026 03:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rKT7yfKtgubz+WdHUVuWNuYCkeGVj/I2FQy/Q7P+7U=;
	b=YQkDPSJZ4o7Sn8fSScGEEuKW6jATm5yLxgSmTmK/gTW2R2OjuuuSgUaO7wJoao4UjKpPt1
	/bxlh2dgmZkkXIX7EGQtIbs3yXPlKvKyoI6BTtQK7fCbDuma/q8bRQpWLLz/8Cbhz28GGb
	Y56lXkfpRL48enVv3k+XpHptoRqm1+tQ7TQ5WWClu65Oo/Gm46huPDrfGNZDmbwBnKf8ju
	JjEXIUZd0e6lTBzpZOW3HpXlbputWSKdGG7lktkmAPaGGhtw4yPW5t3DZlZ0ypVLakVAa+
	auvNRWHS4FQyOk/gBHddUQiSx780DaubXw03FaG5c54zKjJ55oMnM9awulEJKQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=EmE0l6TbsNGQTpCv5QJAIXbn26rcndneg2ZGoLVJ1rSroDHRBz6POGGyQyBUHXLwfuLzms
	vZSxF8cEjBGnuY6YvES9qgEWytSNR8ly+N7DPSXnubI0BFnjNH8boHNqfZuRORUWCqnjWk
	ueDwWCFnuAw7BNhGMNWQaezfV9cedO0bZMDzF39bYdvQUtWbguuJzS6rylJy9/ky4l/cBB
	vjmAGtypdbFtTuUTqjkud9/fWMtWrErsAp2kqevVJodruQX5kmIggt9dSBemAh8DF5e0n3
	c9KMA3AgjjG1mIcMw3dhRtDd5VhNUVntYEStFhGEXvkCSKbbCaxcRvAsK1ap5Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rKT7yfKtgubz+WdHUVuWNuYCkeGVj/I2FQy/Q7P+7U=;
	b=XzdTpnuT8881ipco+/YAK7jXuwCxcsXixlu4o/jXfKMBoGsqIwGLLt8h6PAwkoj56RSEzM
	UOP4JnuewvQs5mJCY18owQpPluqoSixuJ2/Sh9t35y0toiYYuQB4MvBzG4Jm8RHr+CZWtC
	jxWTCEHFqQGS31NGclxaKtFSbrjpe68qjiWPiMYwYYyVouNGBGhb3WFhYGHPX4ZHChKKp+
	8H88xWki4iyjzoMKjdhu+/6MsoQZulkB3JkrKL9p/LeMq+XnWgbEQuESBaIEzma/B5JYrY
	vWblxzpSV/dxtzfI3jSDXHJhLnshG+b+UZ1V9xteo3BRV8cvSONP4SPs9fo93A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf6-005wq2-0C;
	Thu, 15 Oct 2026 03:53:40 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C86F25C477B;
	Thu, 15 Oct 2026 01:53:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/37] can: bcm: fix filter removal race between release and netns change
Date: Thu, 15 Oct 2026 03:40:06 +0200
Message-ID: <20261015015336.816543-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Hartkopp <socketcan@hartkopp.net>

bcm_release() removes the socket from bcm_notifier_list before it takes
any lock that serializes against the netdev notifier chain, which runs
under RTNL. A socket that leaves the list in this window is skipped by
bcm_notify() and has to remove its CAN filters itself.

This fails when the bound device is moved to another network namespace
in this window: bcm_rx_unreg() reads dev_net(dev) without holding RTNL,
and can_rx_unregister() silently returns when this namespace does not
match dev_net(dev) anymore. The op is freed anyway and the remaining
receiver leads to a use-after-free in bcm_rx_handler().

Take rtnl_lock() before removing the socket from the notifier list, so
that bcm_release() and bcm_notify() can not both skip the removal and
dev_net(dev) is stable while the filters are removed. RTNL is dropped
before synchronize_rcu(). As the notifier chain is always invoked under
RTNL, bcm_busy_notifier can not point to the released socket anymore.
Replace the now dead busy-wait loop with a WARN_ON_ONCE().

RTNL is only needed for the notifier list removal and the rx_ops
unregistration. Remove the procfs entry and the tx_ops before taking
RTNL, as remove_proc_entry() waits for concurrent readers of the
world-readable procfs entry, which could otherwise stall RTNL from a
plain close(). bo->bcm_proc_read is cleared so that a NETDEV_UNREGISTER
in bcm_notify() does not remove the entry a second time.

Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: Norbert Szetei <norbert@doyensec.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261014142114.280279-3-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 6759662e024c..301920011a30 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1926,21 +1926,19 @@ static int bcm_release(struct socket *sock)
 
 	/* remove bcm_ops, timer, rx_unregister(), etc. */
 
-	spin_lock(&bcm_notifier_lock);
-	while (bcm_busy_notifier == bo) {
-		spin_unlock(&bcm_notifier_lock);
-		schedule_timeout_uninterruptible(1);
-		spin_lock(&bcm_notifier_lock);
-	}
-	list_del(&bo->notifier);
-	spin_unlock(&bcm_notifier_lock);
-
+	/* Remove the procfs entry and the tx_ops before taking RTNL:
+	 * remove_proc_entry() waits for concurrent readers of the entry and
+	 * must not hold up RTNL for them. Clear bo->bcm_proc_read so that
+	 * bcm_notify() does not remove the entry a second time.
+	 */
 	lock_sock(sk);
 
 #if IS_ENABLED(CONFIG_PROC_FS)
 	/* remove procfs entry */
-	if (net->can.bcmproc_dir && bo->bcm_proc_read)
+	if (net->can.bcmproc_dir && bo->bcm_proc_read) {
 		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
+		bo->bcm_proc_read = NULL;
+	}
 #endif /* CONFIG_PROC_FS */
 
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list) {
@@ -1948,6 +1946,21 @@ static int bcm_release(struct socket *sock)
 		bcm_remove_op(op);
 	}
 
+	release_sock(sk);
+
+	rtnl_lock();
+
+	/* The netdev notifier chain runs under RTNL, so bcm_notifier() can't
+	 * be walking bcm_notifier_list and point to this socket. The spinlock
+	 * is still needed as bcm_init() adds sockets without holding RTNL.
+	 */
+	spin_lock(&bcm_notifier_lock);
+	WARN_ON_ONCE(bcm_busy_notifier == bo);
+	list_del(&bo->notifier);
+	spin_unlock(&bcm_notifier_lock);
+
+	lock_sock(sk);
+
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
 		/*
 		 * Don't care if we're bound or not (due to netdev problems)
@@ -1973,6 +1986,8 @@ static int bcm_release(struct socket *sock)
 
 	}
 
+	rtnl_unlock();
+
 	synchronize_rcu();
 
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
-- 
2.53.0


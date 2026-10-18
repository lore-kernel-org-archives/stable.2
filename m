Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE603EA963;
	Sun, 18 Oct 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341869; cv=pass; b=X96ToGgRp3nZ9v6iW2BK+rnokIGyKH6cf/BM5v0rjEWabRtzFkTshd71chXdpJ0N4hZttW9tszzWwJt349qBHywBo80CB2O/qoWwIAkW7I+vJQlaTftRrM1cGqPwk7QSKxkBjgvaJtyukCGDNXl7FciOYoyBagdHq3l6mOmt4Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341869; c=relaxed/simple;
	bh=etqVcgRMT/a7jV48a/ZTt5YFz/WAqUJKPKS6PqAUWm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8SzNW2Ich232wvJ0VGhTPguv51tZHknYPU48Ysq0AvgmGBM2yNDW3Uso/dyYiL9j8cdEiJCGuW4Vul+UpYWn52jVrIykpU3Fqei8DDkGbH+dZKvVQgSWDa3VjNEzk4TCtxLaMT4In8T7msexmYI79B7wa1xnGbHCHupvXTdnjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=CnVCSdt6; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="CnVCSdt6"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1EC3E202835;
	Sun, 18 Oct 2026 18:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkMzmo7w7scE4rC8qEbTSy1QT2V98/KY5NCDPCn7sp8=;
	b=CnVCSdt66Y12bkBkKaFd1tvqkNcnuBe7s8oZD/awW3PAFNpLwM7cQxn2ucz1ekPs//ILVd
	Nu5ANH7ZEhVNjJRh0MSd2cKMdV4R9oNBGz1lG6kPCAxm+PvG3Trmb/cdcfe82Z0PNFxr5z
	yu3DFLc0PfQnhV/vT6Wf1gNeU67XloVFvTU2LNeuHMUhGpyx3p8n5viBt8j3Ads+CvKCMQ
	314O2WKYLpj6kSHvXLRiwAvYREUqoeFGIfyCE54Mqrf6rR3gbamgswIkdHZkWk13OijpvY
	pX3ThL4Eu0I1IeplbgKE4WldPHqhzccmyHjdxFVxjXHu1lZT+yRc08BlnYWx6w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341860; a=rsa-sha256;
	cv=none;
	b=ZWdTyg/TMzhxN3qy8I2+MOrvckOnRdlQlDlYEnQwqORHltjVN/VSxq+mxy5LUfdnM5s00N
	svrpZTeOAbuT1Kp1P5WsddadApjIFw5zTmW7TUyWKphhW1P8j+CQRR8Rsyhm/Yc2KVrbAc
	Cp9O85Z8GTx3RhqMO/lIVaH8t3g3ObeGkdx+S2vUPz5BqXTSxrFgjiyRwaAqZFBn8/qOOI
	OBPvzyG/1golfY2HxrswlvVdywHRZCpiUHgUeuyXEVNZtTlPRllzLoOsTPpWc2DLqZj3nu
	tOt2/8V7VYfir1XW8oThYQK3WlSEaoLq5WeoAFPbEC0hDwoxmU003AIAJ2A6Uw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkMzmo7w7scE4rC8qEbTSy1QT2V98/KY5NCDPCn7sp8=;
	b=GO7l0ti7hdB5T74vplnDnB5evoxNZp165gI2evsTfyk92cY77yCBQa54QryUPTPDYB4P7W
	2KWZX2CxcRI4MCvUjz/hqZC8uYn8hCR9vr64H78oNXFa3uzVrKFohfdQvBEZLVjTZHlh2d
	UmGPjunzncaGCy4BEDnIlz8Feg/lv9/p4YWxh/gd8Dn4imPKEZSi2ZKijcYtPHH5vppZo6
	oSjdpokZwgSS6AwQlN3JPJfM3k5QTq2N0f2D0XCpU5H5RADah+czXLnDMfiv8b5OU4vYKk
	d7JAJZJ/u+js10d4rWnnQGy6mnx2fwjv/qRJd6RuY4FdFihYjsSwsb7QK50Rvw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzg-0006SR-02;
	Sun, 18 Oct 2026 18:44:20 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B698F5C7D96;
	Sun, 18 Oct 2026 16:44:19 +0000 (UTC)
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
Subject: [PATCH net-next 06/12] can: bcm: fix filter removal race between release and netns change
Date: Sun, 18 Oct 2026 18:41:42 +0200
Message-ID: <20261018164417.1540449-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018164417.1540449-1-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
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
dev_net(dev) is stable while the device specific filters are removed.
As the notifier chain is always invoked under RTNL, bcm_busy_notifier
can not point to the released socket anymore. Replace the now dead
busy-wait loop with a WARN_ON_ONCE().

RTNL is only held for the notifier list removal and the removal of the
device specific filters. Once the socket has left the notifier list,
bcm_notify() can not access it anymore. So the procfs entry, the tx_ops
and the filters for 'any' CAN device, which live in the socket's
namespace, are removed after RTNL has been released. This way a stalled
reader of the world-readable procfs entry can not hold up RTNL, and the
removal of the 'any' CAN device filters does not delay RTNL anymore.

Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: Norbert Szetei <norbert@doyensec.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261016091128.325332-3-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 47 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 6759662e024c..fbc79da4e4fc 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1926,17 +1926,30 @@ static int bcm_release(struct socket *sock)
 
 	/* remove bcm_ops, timer, rx_unregister(), etc. */
 
+	rtnl_lock();
+
+	/* The netdev notifier chain runs under RTNL, so bcm_notifier() can't
+	 * be walking bcm_notifier_list and point to this socket. The spinlock
+	 * is still needed as bcm_init() adds sockets without holding RTNL.
+	 */
 	spin_lock(&bcm_notifier_lock);
-	while (bcm_busy_notifier == bo) {
-		spin_unlock(&bcm_notifier_lock);
-		schedule_timeout_uninterruptible(1);
-		spin_lock(&bcm_notifier_lock);
-	}
+	WARN_ON_ONCE(bcm_busy_notifier == bo);
 	list_del(&bo->notifier);
 	spin_unlock(&bcm_notifier_lock);
 
 	lock_sock(sk);
 
+	/* Remove the device specific subscriptions under RTNL */
+	list_for_each_entry(op, &bo->rx_ops, list)
+		if (op->ifindex && op->rx_reg_dev)
+			bcm_rx_unreg(op->rx_reg_dev, op);
+
+	rtnl_unlock();
+
+	/* bcm_notify() can not access this socket anymore. Release the other
+	 * resources without holding RTNL, e.g. remove_proc_entry() waits for
+	 * concurrent readers of the procfs entry.
+	 */
 #if IS_ENABLED(CONFIG_PROC_FS)
 	/* remove procfs entry */
 	if (net->can.bcmproc_dir && bo->bcm_proc_read)
@@ -1948,31 +1961,13 @@ static int bcm_release(struct socket *sock)
 		bcm_remove_op(op);
 	}
 
-	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
-		/*
-		 * Don't care if we're bound or not (due to netdev problems)
-		 * can_rx_unregister() is always a save thing to do here.
-		 */
-		if (op->ifindex) {
-			/*
-			 * Only remove subscriptions that had not
-			 * been removed due to NETDEV_UNREGISTER
-			 * in bcm_notifier()
-			 *
-			 * op->rx_reg_dev is a tracked reference taken
-			 * when the subscription was registered, so it
-			 * stays valid here even if a concurrent
-			 * NETDEV_UNREGISTER already unlisted the device.
-			 */
-			if (op->rx_reg_dev)
-				bcm_rx_unreg(op->rx_reg_dev, op);
-		} else
+	/* 'any' CAN device subscriptions live in the socket's namespace */
+	list_for_each_entry(op, &bo->rx_ops, list)
+		if (!op->ifindex)
 			can_rx_unregister(net, NULL, op->can_id,
 					  REGMASK(op->can_id),
 					  bcm_rx_handler, op);
 
-	}
-
 	synchronize_rcu();
 
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
-- 
2.53.0


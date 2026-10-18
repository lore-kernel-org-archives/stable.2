Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245033D9691;
	Sun, 18 Oct 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342224; cv=pass; b=LqN/QqRuSQY/HJ8T9a8rb+MaGCUba7Gm7h2zbNKdXei7kxB6Stmry+QJ4JNs/eU04Wj2GBu70US9UQroi3FzELmnhD4FWiblN+MVTOdJkQ6fp75h4INS5+l+uKMzry0GVbBYJ982nJCzYBt3V5R9jjLrQKd7I5YeyHL2tcxSrQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342224; c=relaxed/simple;
	bh=E09bOoWCHJ7TV/jce0stG8xt1VbokE0TBlL1aiD84vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNCg6eOPbX2jYX9ALIxdiHWGDunuYSZqpuK4MGgFHqnbEeU13nqgo3htWvaY8am4YK6/wcU1ttBx/0fkwQKMSJVrjbOKr3WGRkzBZZs+voqvYB42Kw5uGtxNQZIku4Z1d///Ub7EZUzI6gKe6/ggFKQBbifnUgeV5hy0iYcONug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VdC2siav; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VdC2siav"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 04D38202827;
	Sun, 18 Oct 2026 18:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmoKEg1hJ4YToIB95bvHxXA2N4RiCTq13NMrviyHn1s=;
	b=VdC2siav6SrSjNBWHKFVcV/OGMUY202fGNUsi7Un+8aUWqPsPUYtIaIJaEobtJa55WnIBs
	/MfJecUQwBJnvdmywUt8wmxWqpMFlGjsTTedlAmZd24m4EAfntob/VdcJpF4oFD1cDrYAO
	jcHhTKTuNNyL0Hx8eAeDbg+7W6ha5qLo2sojsncONpdaigeeyZQmum68xxYJusFq3OZkLl
	PJCIP8x0usi8s+HIWa+Fht1uxBnqCdfEgi+ZvWKlF8/K7XAN/G/6RSkewOfT9QnCORCuec
	clToSchT+nXCZNlEQX9rav2foXLyaB+hmsqxd6pqNJ3U0XvrjCzm44auW6W8Sg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341860; a=rsa-sha256;
	cv=none;
	b=eBsC9O9oYV4RcTYr4g/2mgxs6j89F8/1hnrzJETllzbpnTPYpzSKLNFrXBPodXzKx1IGdK
	SG+nFUCimxceIJDyMZYs3btZGg3DcGb46TQh1qJB/0tZLn0+dw6g5e+lQKJSW0wbH2NjQy
	Uk7fNACA1YwcYij95EoSrJSvFREIFUCrU6kYkVL329/np+Y5BW6Tv/k2VgU1+yJlb6kdO3
	QPAUZAqEaujo9pwPdXSjnkEeU8/78BaAiwMBstiomeOO2GU7OheVxfxACByildwfXVCRXI
	LDKHm3DKR9TUy/gi1atT8KSFe0lvykEyqhPZNyZvpl5By2M9EAWv17ZNfjt/KQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmoKEg1hJ4YToIB95bvHxXA2N4RiCTq13NMrviyHn1s=;
	b=Ge4v4WGRoErgxTTL72iJeVnFphNL8k4pc/aRUK48mS8/JkiDbsqCzu1ZGPypp+sTEq+DPr
	gtbhKcVhVr3NluZG8MMnFWFn/60lXm5wfrTIXdqL5s3GoDCctiUYH45H7ZzNlq6skFxzWM
	aSNWhXHcPWIwbxwed8ULpcmXHgEtEdccLTXYOmmcnrhjTeC3cE9u3boBRbEU2cmMqfO6kw
	eKc0qre/XoJiE7rSydFUxVdx/zhfXQGWgwi4cyA2e+DCDYIHsrhuP4Cwq/uvqVN6JdkVVr
	UPlU8eA/ZqYqPx0k/g7KEIKRTbBhvvAuxbZiEPUos2DmNb1YT901nRwNZ2xqOA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzf-0006SJ-2u;
	Sun, 18 Oct 2026 18:44:19 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 884545C7D94;
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
Subject: [PATCH net-next 04/12] can: isotp: fix filter removal race between release and netns change
Date: Sun, 18 Oct 2026 18:41:40 +0200
Message-ID: <20261018164417.1540449-5-mkl@pengutronix.de>
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

isotp_release() removes the socket from isotp_notifier_list before it
takes rtnl_lock(). As the netdev notifier chain runs under RTNL, a
socket that leaves the list in this window is skipped by isotp_notify()
and has to remove its CAN filters itself.

This fails when the bound device is moved to another network namespace
in this window: isotp_release() passes sock_net(sk) to
can_rx_unregister(), which silently returns when this namespace does not
match dev_net(dev) anymore. As can_rx_register() stores rcv->sk without
taking a reference, the remaining receivers point to the freed socket
and travel with the device into the new namespace:

  BUG: KASAN: use-after-free in isotp_rcv+0x1570/0x24d0
  Read of size 1 at addr ffff888118130552 by task isotp_ns_uaf/578
   can_rcv_filter+0x4af/0x8c0
   can_receive+0x28d/0x3c0
   can_rcv+0x2a9/0x310
   __netif_receive_skb_one_core+0x21a/0x260
   process_backlog+0x210/0x760

Take rtnl_lock() before removing the socket from the notifier list, so
that isotp_release() and isotp_notify() can not both skip the removal.

As the notifier chain is always invoked under RTNL (see ASSERT_RTNL() in
call_netdevice_notifiers_info()), isotp_busy_notifier can not point to
the released socket anymore. Replace the now dead busy-wait loop with a
WARN_ON_ONCE(). isotp_notifier_lock is still needed, as isotp_init()
adds new sockets to isotp_notifier_list without holding RTNL.

Additionally use dev_net(so->dev) for the can_rx_unregister() calls, as
the CAN filters live in the device's namespace. With the new locking
both namespaces are equal there, but dev_net(so->dev) is stable under
RTNL and always names the correct namespace.

Fixes: 20bab8b88baa ("can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER")
Reported-by: Norbert Szetei <norbert@doyensec.com>
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261016091128.325332-2-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 5e1c3971ebfc..17ff40a4708d 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1488,16 +1488,17 @@ static int isotp_release(struct socket *sock)
 	/* forced SHUTDOWN may have skipped IDLE (gave up on a signal) */
 	wake_up_interruptible(&so->wait);
 
+	rtnl_lock();
+
+	/* The netdev notifier chain runs under RTNL, so isotp_notifier() can't
+	 * be walking isotp_notifier_list and point to this socket. The spinlock
+	 * is still needed as isotp_init() adds sockets without holding RTNL.
+	 */
 	spin_lock(&isotp_notifier_lock);
-	while (isotp_busy_notifier == so) {
-		spin_unlock(&isotp_notifier_lock);
-		schedule_timeout_uninterruptible(1);
-		spin_lock(&isotp_notifier_lock);
-	}
+	WARN_ON_ONCE(isotp_busy_notifier == so);
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
-	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister
@@ -1505,11 +1506,11 @@ static int isotp_release(struct socket *sock)
 	 */
 	if (so->bound && so->dev) {
 		if (isotp_register_rxid(so))
-			can_rx_unregister(net, so->dev, so->rxid,
+			can_rx_unregister(dev_net(so->dev), so->dev, so->rxid,
 					  SINGLE_MASK(so->rxid),
 					  isotp_rcv, sk);
 
-		can_rx_unregister(net, so->dev, so->txid,
+		can_rx_unregister(dev_net(so->dev), so->dev, so->txid,
 				  SINGLE_MASK(so->txid),
 				  isotp_rcv_echo, sk);
 		netdev_put(so->dev, &so->dev_tracker);
-- 
2.53.0


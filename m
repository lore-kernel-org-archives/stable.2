Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46195378811;
	Thu, 15 Oct 2026 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029226; cv=pass; b=HPtgsNEz74ef58KDZTAvDkGlJWXdzi507i3dvRq6Gw3141wVheAYR+Q8NJWqte9NiB6q18uzxux4zUWaILk/ncRocgGhLjPcAOdYBv236Jk0r5NgopC3N53seXkA1kZJaClzWojpm6/awa8g0EFwdSuomXxYNKEuRRYG9w00f44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029226; c=relaxed/simple;
	bh=2rgHceDy2r9bB2UYaf+caOQ9ZPmdjbSPF0TDzjp+Fj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBNG3hMcxmx3Ao9qBnef2M2goDa8+dwYFdU70Xd/XHmInH9rDSXR3JJ25+x/fvEqvjXY6W8IR/UFmcsxsEFNdvTPgM8q0vkd0hiOxkBRAJsW+Z/d1qkZup7l9IKgS88RKb3L0JGuAX+Um4Wv+8a6oFBviBiydb+tK/vyXJ0uSX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=YXJ86PEv; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="YXJ86PEv"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 168192025FA;
	Thu, 15 Oct 2026 03:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLdXItwedYKkP0zL86Qehu/dwRPazrVfVjJsVOauR/Y=;
	b=YXJ86PEvGcULO5OEeZ/FDoYJ7I61GUvREqzWLFDFzkNni6qWBC90si0G/frLIXE0ZRJipV
	Affv4DOZV1SpPrxnx8A5t4pVht9++aAAAeIgKtMa5VezBNyOJrlzEGlJnN/1JT0il2AJVW
	qN18q5+8rVhxJ2kCfq0NhitiSz1tXLch37ITwmVv+IqRf5zY7RG5bxSlCbruK6RIP1H6JP
	UuF01ZW4apqHTTlTDTZ4yYauwcTIZaXytfbqsyEQOVzaXMJgCEJ8StPwCwTdoy2lS4Ueul
	CMS+za4dcKSZU2X8ULl3/bpdJmzl1NTL9OzP+6DuoawTaXfdKKAE/IzVa80JwQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=TMVDRvv4s2gj+5i6+mvLvnLDpM24j2qWRe/86d0sKxUVKajT+wgfDS+6uPrF5s7UaCDxNJ
	H/vxJ7MBokKFzp1hpG2A7qSrQmY1e5UvJOgoweaJkp/AJFfqbJR31O7py7MIjaPvU0rK6b
	9PE8qPZF5RAAc+NejNhhxzK0VmVK+9XEVTUQF4gvnp5iP203pBCYljGr4p33yRf45LIyPA
	Yarcgh+rX4KdMAHb7cPIj/pdYiqmWuAIngQqGt2cJIDWcE8LKsd88yggqLfh7I4ON1XNsu
	ADBgWzzYfkUVjiZMb9+CVnJZyBXr1GSjeuiiKKf9BXRBQNLFZcTHKQF93Cu8KQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLdXItwedYKkP0zL86Qehu/dwRPazrVfVjJsVOauR/Y=;
	b=fZFTbC97Ml1VDqkQqYNbpWx4Qr59ulMT/47CqRu0pch0VwK+ZGMdOWV3rlz4yNkBpIMLE3
	r5LIiMHMtlSxdMThLPxNpXZBQxSRMVEdSfFKvHjpi5EE/BWhC6PRYuPqVL16df776kDTBu
	bEhLpY6CkF9Bfe+MMityUf/77mnHUfViYXagWXDtolgVIfJm7DQym8X/Q8HbmYdAzIyca9
	8QMJ/AkB+leuZr1T2wBDatlc0eCjuGux5N0LEga05Ueh/Cr3naZv6M3oFd3zmKCRgI5eC1
	mjQ/ZiVQVRdKfNEzs/ZMhdWPMB1W+gcoy0Qm14vFZfSHjlRZYmFRzMrUn8yeMg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf5-005wq1-3B;
	Thu, 15 Oct 2026 03:53:40 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AECF75C477A;
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
Subject: [PATCH net-next 07/37] can: isotp: fix filter removal race between release and netns change
Date: Thu, 15 Oct 2026 03:40:05 +0200
Message-ID: <20261015015336.816543-8-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261014142114.280279-2-socketcan@hartkopp.net
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


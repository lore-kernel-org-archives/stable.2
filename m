Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F74184524;
	Fri, 16 Oct 2026 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141909; cv=pass; b=Iozat4/RaORnT6DQPD/EOC0B3NEyxQqPhBuJZxG1B3VA7WKKrtGBqShGbVyfEieF1LteRrx8atcH+wvuKXV/R5YbHwjkXpgg3qgJOOVq3S85Fb5wZivo2MT1WlZ2PGMg5bg7XlNytJJYuKeZfs9LvoLml7kQQPK5jgmZRI+HWCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141909; c=relaxed/simple;
	bh=Ata4h/guBNum7eC7lqw9Q0Ka00OJCkWAvZd/x3UU0GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQqB26m+6q99yDixKgL354i/PG3mu2v0b7hh3QD4MOYa8qWK0wpW3sqKyZTiGJbS1yXzWmevw0PwTUAu4o8klBPZO2Al3zi4+0kftR5YJuunKTh0snkxE0h58SDbtwoFp46pmMr5knBabe03N3I55agXWoMApy2JSlhURCOkzmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qwNfDTCm; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=7lAzLsZX; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qwNfDTCm";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="7lAzLsZX"
ARC-Seal: i=1; a=rsa-sha256; t=1792141903; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PjIjJEg2xBnZpXcREJ9CVanmLFFp+cpQznjiXmv6j44H64j1Bawc6HLcshRM2offfz
    WWhLe0oUzAErBpKfSO/E3QmocFpJBuCb7JlIwS7W04YjBLpM3M+WyjIwS+ezjtAwD8Do
    ReJClY+OXzraiKsnimACOVhmG32+l6mJfLLpcUKAa8rlw50Ca25yUNV59b3RH4SH0/yK
    xu5r8mixnlqV+MLcM0UVE7KsrUoxpuNamtudhDjNT436ri0FMr481IlpwZau/rpWRjfB
    P9TmuCob1wsaj8MX6JP+B/d7tET3eEVG0kjsGrCBiv4JTPN8IrI9qy/iv0KmuuU4cd+e
    FJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792141903;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=heo1CCnELHInPN/ZV9p4RLroHPkdMQfC6vcLV7EOpdg=;
    b=i8bTPve/T+8Ef4WaZ//lDfuctemLTV8fNLUmu87d/OVCjSBFfdKH1Ow2VwXjvhKK9Y
    kbyLAAUJFpLlIoGAwhrxzCl66TJu/0mDJn3fVla2kwV6hd1slgYXbRswqShTEErKs3G8
    XhrwbP4ACHEMAPLLle4OBdkD+R/0GpJWQj5hQpP16NEfrK9tolcCsocenDlTdgDrLbZv
    F1jgQ6RDDA6RZlrWv6fLYDgnZ0AZb+KLRDDQ8usjDA+Me3ohmlkTGSViA6Mi43rIOWAE
    sXhrTePs87DUUlj9YjfMMbiEa+UlPsmQWPjVPwVkrbVrILCZDOpF1Kf/vUbxFsxZoZue
    sPBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792141903;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=heo1CCnELHInPN/ZV9p4RLroHPkdMQfC6vcLV7EOpdg=;
    b=qwNfDTCmQ9VZXpBNB3mLoBNF4iWYpePU3QtI3kbu3AEF9L2/ojXPZpOrlq3O3lB98q
    z5eyenJRQCGxJYsL+AvwT8fojFCn7M3qh/LSwBhXn5VD/NU1XNF56ucuipmcU9nXjuIj
    SBTpm3v6sB/9CoArs9YfxtlpxgCywi1WaLOWWpWHmNDgyVEoljDpkrkJEpxGjf1/GjcW
    PJuWnqhogd4myIRxvE85YrNXev1PIxSnthXzddbWSHjXTCTRLHvjuNHl3158zq2k+csV
    kHdMNGqHIHWD1pXj7WfkSObvq3HWEjTk5RUTNC7aKhJrW3U5BeGrXTIfR6S+CISgr0ab
    k5fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792141903;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=heo1CCnELHInPN/ZV9p4RLroHPkdMQfC6vcLV7EOpdg=;
    b=7lAzLsZXZFWXm1xtvxotmkoKCtOW4xmlefz0+0Q6NXXHLW8f0UYpwtKlefilfmXu0h
    NBTzTiLuIyGP3erSgHCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29G9BhLK5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 11:11:43 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [PATCH can-next v3 1/3] can: isotp: fix filter removal race between release and netns change
Date: Fri, 16 Oct 2026 11:11:26 +0200
Message-ID: <20261016091128.325332-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016091128.325332-1-socketcan@hartkopp.net>
References: <20261016091128.325332-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

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
---
 net/can/isotp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index f5dc9d0..186daa8 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1479,16 +1479,17 @@ static int isotp_release(struct socket *sock)
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
@@ -1496,11 +1497,11 @@ static int isotp_release(struct socket *sock)
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
2.43.0


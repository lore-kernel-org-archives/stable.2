Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4064E56D0;
	Tue, 13 Oct 2026 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889180; cv=pass; b=NUW4KO4+9JQVJh8x2ocW9N7X2DlNBApsc5WHUHXUuhUhAKeAL3TktRvj6+ysq/WybWxJJgpHIEtw9FAOlbjDggbXWgRqM8KSjBzEeSl0VCoeKeypSVZk8hcEN5RgqhVV0fZlWBEHdGDd+64x/ehE7ZUh5kxqbsNgJrM0nv8LOu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889180; c=relaxed/simple;
	bh=Fmuux2S0sh4Z1LJcMlkj7thikJckHfLDUMlqtBUvrAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lyp2R0P7AH6o2DNpLAa0FVit8KaJehgA2eGonrqpqA/CZcfUF7G33K3bGRz79FMUKxva87RVILlkPSpnbWzVPJyAvgNDk0RhVgJsLm2FOnh2iekGpR0p6OL6naOn8ptvNk//1IDNqfuZxu/aZ2SZ+U8PFfs3+rOU9hK5YxUwQ/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UJxyNSi/; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CZNMTlDq; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UJxyNSi/";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CZNMTlDq"
ARC-Seal: i=1; a=rsa-sha256; t=1791889169; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hcsr7YbjEcMLP/TVlLIQqT+KrIAvMZ73obLOkW5Aebb4ba7HQIa0KM+/n63JRhKBnE
    1JA75kJ6W66+n5IU9AwLyrkEjDkVzfAyDLowYLRYiveC1UIX3Gz1wLgTqw0o/D5Ks8x5
    fwTLI1ZzIGi8JpMIUwoVKP/QkgI/LIZsYbvkNY+JKFh8OqQj8tN9krFxEjv0GXSJPIQm
    igP5EwGIlXOLpvoVADDI+Sm3k3lksZMTq4l5XefKYNWEHgG9MBbWSTOv1iGXKHg0VvzQ
    KgNPuk6FZvpjjv9sUcVvvZ/nyPF8TQYQg8RzEaBuyDVCaKcUq1UX6j0yAeZsWw1+c8WK
    cLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791889169;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QG5FKUmGCAxlXwdaIkwiAfmKUN8QwHHv8/uZI+WMwlk=;
    b=OmJzCje+DrYkPRg1T45ev8f8xWm/WdNXhOGtlNeJpp6KUh72xGNIQas73njYRB93FE
    83rcG8hZQdZkrpSlMjuVwFlLa4oOXylqEM7WZTeqnEX2cGvdG/P4Qh499QOB/Bf5W2Qh
    ldAuaME4T4HQ23yLkPdounCV8/fEojiI3d7QzToLUZ1LDnElBk9zR7vEmyOkGPTU2Hoi
    WY6sspGo3sqepITmX5ciL+v1O49YO1ePiiENaqchLxNdxFX6Icy5pvHwJQEJeinxMmwF
    xRQIhhrIJC321Ky//ZDv5/APaKcYtr+UI7Z9Be4/CY4lQp4BU7g0kC3t5GsEO2lK7chW
    wLUw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791889169;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QG5FKUmGCAxlXwdaIkwiAfmKUN8QwHHv8/uZI+WMwlk=;
    b=UJxyNSi/wBasB7i5ygjc7whCEKPoEL4kXFQld03i2XPxtjj1WYpib3I/XUHqVK/5lg
    Ti/vI/ZKgdjn9kPVjf3KpoJ+tgbUJWowiwLSfLt/Qqjk8inSQhmTT2MBl38iqEFEo5Tl
    r0DP5OhJLm5s97WH0pxzG2w8HkObII40pgW7Q1Rjre6yl6kUtcNhtu/s6XC3N+R+TsE9
    ro1/MMWNADc9CjWpTXn/OR0XTfN1C+djnR6a7+6PjWp+baEpuJE2HuicLGeHjVuCQy9G
    rfhCmrvBX6wvYomssl/wEPAMRsfc3ZRVoZzfsmR/+C+S+dHxgBCj0gN1UrS2BZXNbb0Y
    2EVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791889169;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QG5FKUmGCAxlXwdaIkwiAfmKUN8QwHHv8/uZI+WMwlk=;
    b=CZNMTlDqBivAoG2Fma3Mt70SiYFOeefN9uFTuTGyrxGOny+iOcdlMjzB3i8qzMvNz6
    /i4Imatv3O/a0VY+wMAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29DAxT5uu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Oct 2026 12:59:29 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: isotp: fix filter removal race between release and netns change
Date: Tue, 13 Oct 2026 12:59:09 +0200
Message-ID: <20261013105909.91715-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
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
index f5dc9d04bd68..186daa818647 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1477,32 +1477,33 @@ static int isotp_release(struct socket *sock)
 	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
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
 	 * tracked reference so->dev is taken at bind() time with rtnl_lock
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
 	}
 
-- 
2.53.0


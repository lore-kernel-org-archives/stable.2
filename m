Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C001F5349B7;
	Wed, 14 Oct 2026 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987707; cv=pass; b=dRWY1E+EHCC09cwgBrudTAtBL36tE9vWY9Ww4IA2Wy7JdsMc+1iUEKdRKz1hNTEPDu7/Vhz3jV2/uNTvRE4C+skTbXl9nXifv94R1XnFNY5UR5UE85/qQJLlMegOOkZa70BMd2cz2T0mYSrKrqcDotju+XiYNW2mmOvc1GjBxBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987707; c=relaxed/simple;
	bh=Fmuux2S0sh4Z1LJcMlkj7thikJckHfLDUMlqtBUvrAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbJ9qQW9rInERpAzZ1kOao5pJyj7m91pQxWddHISlaadlC2MITTgOCq1RZ9mLMeK9rDIYwwYgJqJstlz1ZpEGkH04LSYBKAEHiqmYSOavoE+kqYyiNP8KzLFScXbf4dOMOSYAZCPIMont+VhGpJ61sQb/zr1Mago/tebbPAY3xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YJc6zpQ0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mDFx3iQ3; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YJc6zpQ0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mDFx3iQ3"
ARC-Seal: i=1; a=rsa-sha256; t=1791987696; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l/Smbwj4R2k4IvTrgIWAu5119wjBYRF+/W8kso5wzA0W6iKPDNO4o9ohNTrIp6NBke
    EAevXb6toTp3KbOKiCWN/aFsikk46qlCMKJYjEp6VNMEtrVEpevNoYDpiJ27eDLKwtDd
    eHF+nH0/Q5UdafKK5uHuGDJctDbesJWbkqy29y34+eylVCdTP8Fm3F9riVL9vF2hcijY
    MtfoB1s0HrD0kAalZeKxfRdH/sCTZO3oHfdDFB8WPD+QHWz63EF6QftEBM/6Sj4FwpZm
    cNfYd9mL+wnkSza+sxc+vndMBog+YEMdh1boskRtoTu0TnyAhRkk6pmw4yFVhLF9+h+D
    0yuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791987696;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QG5FKUmGCAxlXwdaIkwiAfmKUN8QwHHv8/uZI+WMwlk=;
    b=lYyItkL3ZvemuA81iltvvYxWtLth8m/7qB7OydV5pvkDch316U/Myr8AxdO0rcG6r5
    IVVlrvCCNcdBSvFAMMXO/GrlELa1Kr2TE5GgqzN2frRsKJpr02hkKaqj2WcvQbr4Y+Lt
    QjoBP9T2H2agmcyeHhxkMA2XxIXiTT/0dJnifKnJvbg14EUBUW6HS6WQBSDqkm/mIDKo
    8pYYPgSyYkAyhw+sv3FfTvb6tpTvyYOkE+0Im1gUUTJzcggo2Gf93RybYTV89JXlSHdY
    zDgKhA04vTKCXyGBjv3mQaWCeBGHuhTJzS8H50BgaYKdTqRtj8iTRTbIdDWV0KdlLonD
    diiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791987696;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QG5FKUmGCAxlXwdaIkwiAfmKUN8QwHHv8/uZI+WMwlk=;
    b=YJc6zpQ0vjka7TO593ztPjwFX+A3C6J6zVmpSr4rbKg/Or9zTJqhYtBC3QRs6HZhQN
    m+0NL8wEmfA49yFDL1j2O9nn1o1f+7IzhC2jkJkn30H99vqSqarINlOdOJR+YI9F861i
    3cccaC0QmgKUNiWPi+t272SXyzCi9jgLEjayyw7KjsxvOlDPs00nHOuowj2GibS5xYVv
    OgvcZW4mI50BYg/5d4uDoAZG5/oc3jIQVOAjsIV4y3BOBPPL+D+jDPgt7OaTiC/NcKst
    /uakIUPhg6SNgfDGCHIzFL5QmrSxLz19S6H1UERhk/OTa7l32owEQaMcIffshhGvGHiZ
    N8Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791987696;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QG5FKUmGCAxlXwdaIkwiAfmKUN8QwHHv8/uZI+WMwlk=;
    b=mDFx3iQ37wwaTCu8m4Z/sgXDjGkCpi6F6RBxtfcgBN5dGFCdLBSleiLHN2Ryz8rrZe
    NLXeVILOA+6QpXcf5aBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29EELaDZX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 Oct 2026 16:21:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [PATCH can-next v2 1/3] can: isotp: fix filter removal race between release and netns change
Date: Wed, 14 Oct 2026 16:21:12 +0200
Message-ID: <20261014142114.280279-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014142114.280279-1-socketcan@hartkopp.net>
References: <20261014142114.280279-1-socketcan@hartkopp.net>
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


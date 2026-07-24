Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B93C277B
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883171; cv=pass; b=fTca5/nP1RwEsPDbMIV0WvMELzXxNyvnaQ/SLNf6TrLS/Ew8mXtU6sQ2S+3xSJcMEBXjp057CZ//RlNThk788p3KxaI6Ai4VERyQCi4RHIvPlvvPUsieci/KNvASPm8wnQolSzhEDeB6W0dEwH6s0FbpzqIgafUi9ogno3/fikg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883171; c=relaxed/simple;
	bh=8hLcXX36PneCsCV4+swRcQf2KWia8SxvL98zRzO+3gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htOfGnW6I3b5tVlwTIhNZQAY7UKaN8wsONzG+/tZFdRaYAE7nERp4LMwr1NGmej/m1LPBLT65Tu0Fdm2M4+/o6ubtx3NM8jFAHnvVtWZQ3xkX/pp65v/oYnRz8f4b3BmVcptBvdjr5NMRENC9oeB9zSXIsUFeyIsB8gNEecRuZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hN8YYqDa; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jGcuxJ+i; arc=pass smtp.client-ip=81.169.146.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hN8YYqDa";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jGcuxJ+i"
ARC-Seal: i=1; a=rsa-sha256; t=1784883165; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GpHJXnDlkoQ7EcVOO7DqYW/urs0mIkJdrrW/154TmOBDlVpvDhrSnAKUpIgDp88OV7
    eO4q5L9NFGnq4oAOzbjRcPVPRv5HE4mhzT6F+7d11DLLRBigswYvlgEVuO1oJ9K7smEG
    cqVEAlA09QI5S/IhFml74nqwkTFJmLd5h7AsauL2bh/GpTJXbEStqdCr8Coga9suYV2F
    rG1s4bre0qV5hTiABnDRfOIHDAlnsWBcWmD6nGqmFtqXEVWuv4Rg8fC10YuXKNIsAXnI
    khPVmskaEq/vnmmdOuUwi9yW1Mw/hL2Vk6vYbs0RQB7ycuQ7kHR45C1wBj+WRnufOYIP
    ppxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784883165;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kAFlgNsbsCrt0MMSnftbgKJNVOG4ZtqHsj6JqwVS1Os=;
    b=CtCOBkd2pwrgWVY7XalrtucVlnDJHSImAtDfGLbzll01j7KOGd18K+DA2E8jhEu9jx
    5FoSwjmJOzPIIOrTao6N/tIjdxJ7efLoT0635yccuSLGyASOnuKE2sE9vGZPw+colPgk
    oGzXPMsDhnCvqtHtiTBqIbN7Yzy3030C7mk2lO9XQ5QWfMIyUW0XlDNgSikUqp3qQHyj
    QiwrT2EzT56qK0MoSViLwsUd77qVb4pIi85znwO3rsdxkU4MmOiCN6V27JQrWNhmRWAE
    cPVlhmpryLNHOp2aI25o1G8F0km/MVrR2cEMDWMOn59uzn2hYSC6682u3C2NYxEQuy9B
    Qfbg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784883165;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kAFlgNsbsCrt0MMSnftbgKJNVOG4ZtqHsj6JqwVS1Os=;
    b=hN8YYqDalWn9SO+1Pevwz4E7MxlKaJWjthZ7S5x2C2q9G4fD8PyiWcuuUu84fcdyff
    Ztkh+iwVrM2QvPAxtCkk6EiY1kqM7z+P/gqOgkaFRTeEYSJnoKciED65c8RWmi7DuhQ3
    dy5b80Reg8nRPpY6xt2dXyh80CoKDkcDWxemrZehVI9pLZcsvre7PIgsM27XvIJPNHi9
    dwZvHLBsZdogWavpi/W0CabjOBJGwi52BXC36/QON4JA/dFvPWqlW5REqcO9TNGCoh7c
    zTPizdfH1kZPmaIns8dtv3wNI1khmXF+UX1T1hMPyBwFfDgpkxP1opPnPOrHZ2auA3Ak
    Rhbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784883165;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kAFlgNsbsCrt0MMSnftbgKJNVOG4ZtqHsj6JqwVS1Os=;
    b=jGcuxJ+i2XClV0r9sMOtU4asSxBvgKx45sQIWEBoDsONV/nCNgfrZADv/3S/mjKnKG
    nRKVQG577bkafxDgnRCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8qjrju
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:52:45 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
Date: Fri, 24 Jul 2026 10:52:37 +0200
Message-ID: <20260724085238.13886-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072054-stingy-versus-73a8@gregkh>
References: <2026072054-stingy-versus-73a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit 20bab8b88baac140ca3701116e1d486c7f51e311 upstream.

isotp_release() looked up the bound network device via dev_get_by_index()
using the stored ifindex. During device unregistration the device is
unlisted from the ifindex hash before the NETDEV_UNREGISTER notifier
chain runs, so a concurrent isotp_release() could find no device, skip
can_rx_unregister() entirely, and still proceed to free the socket.
Since isotp_release() had already removed itself from the isotp
notifier list at that point, isotp_notify() would never get a chance to
clean up either, leaving a stale CAN filter that keeps pointing at the
freed socket.

Fix this the same way raw.c already does: hold a tracked reference to
the bound net_device in the socket (so->dev/so->dev_tracker) from
bind() onward instead of re-resolving it from the ifindex, and
serialize bind()/release() with rtnl_lock() so that so->dev is always
consistent with what the NETDEV_UNREGISTER notifier sees. so->dev
stays valid regardless of ifindex-hash unlisting, and is only ever
cleared by whichever of isotp_release()/isotp_notify() gets there
first, so the filter is always removed exactly once.

isotp_bind() now rejects a (re)bind with -EAGAIN while so->[tx|rx].state
isn't ISOTP_IDLE yet, so a timer left running by a prior
NETDEV_UNREGISTER can't act on a newly bound so->ifindex. Both checks
share the same lock_sock() section, so there is no window in which a
concurrent isotp_notify() clearing so->bound could be missed.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-can/20260707101420.47F261F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260712-isotp-fixes-v10-2-793a1b1ce17f@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 88 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 29 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 7d9327b..23affae 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -137,6 +137,7 @@ struct isotp_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
+	struct net_device *dev;
 	canid_t txid;
 	canid_t rxid;
 	ktime_t tx_gap;
@@ -939,6 +940,14 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			goto err_event_drop;
 	}
 
+	/* so->bound is only checked once above - a wakeup may have
+	 * unbound/rebound the socket meanwhile, so re-validate it
+	 */
+	if (!so->bound) {
+		err = -EADDRNOTAVAIL;
+		goto err_out_drop;
+	}
+
 	if (!size || size > MAX_MSG_LENGTH) {
 		err = -EINVAL;
 		goto err_out_drop;
@@ -1164,28 +1173,30 @@ static int isotp_release(struct socket *sock)
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
+	rtnl_lock();
 	lock_sock(sk);
 
-	/* remove current filters & unregister */
-	if (so->bound) {
-		if (so->ifindex) {
-			struct net_device *dev;
-
-			dev = dev_get_by_index(net, so->ifindex);
-			if (dev) {
-				if (isotp_register_rxid(so))
-					can_rx_unregister(net, dev, so->rxid,
-							  SINGLE_MASK(so->rxid),
-							  isotp_rcv, sk);
-
-				can_rx_unregister(net, dev, so->txid,
-						  SINGLE_MASK(so->txid),
-						  isotp_rcv_echo, sk);
-				dev_put(dev);
-			}
-		}
+	/* remove current filters & unregister
+	 * tracked reference so->dev is taken at bind() time with rtnl_lock
+	 */
+	if (so->bound && so->dev) {
+		if (isotp_register_rxid(so))
+			can_rx_unregister(net, so->dev, so->rxid,
+					  SINGLE_MASK(so->rxid),
+					  isotp_rcv, sk);
+
+		can_rx_unregister(net, so->dev, so->txid,
+				  SINGLE_MASK(so->txid),
+				  isotp_rcv_echo, sk);
+		dev_put(so->dev);
 	}
 
+	so->ifindex = 0;
+	so->bound = 0;
+	so->dev = NULL;
+
+	rtnl_unlock();
+
 	/* Always wait for a grace period before touching the timers below.
 	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
 	 * filters and cleared so->bound in isotp_notify() without waiting
@@ -1198,9 +1209,6 @@ static int isotp_release(struct socket *sock)
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->rxtimer);
 
-	so->ifindex = 0;
-	so->bound = 0;
-
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -1254,6 +1262,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
+	rtnl_lock();
 	lock_sock(sk);
 
 	if (so->bound) {
@@ -1261,6 +1270,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		goto out;
 	}
 
+	/* A transmission or reception that outlived a previous binding
+	 * (unbound by NETDEV_UNREGISTER) may still be draining; the FC/echo
+	 * and RX watchdog timers bound how long this takes. Checked together
+	 * with so->bound in the same lock_sock() section above, so there is
+	 * no window in which a concurrent isotp_notify() could be missed.
+	 */
+	if (so->tx.state != ISOTP_IDLE || so->rx.state != ISOTP_IDLE) {
+		err = -EAGAIN;
+		goto out;
+	}
+
 	/* ensure different CAN IDs when the rx_id is to be registered */
 	if (isotp_register_rxid(so) && rx_id == tx_id) {
 		err = -EADDRNOTAVAIL;
@@ -1273,14 +1293,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		goto out;
 	}
 	if (dev->type != ARPHRD_CAN) {
-		dev_put(dev);
 		err = -ENODEV;
-		goto out;
+		goto out_put_dev;
 	}
-	if (dev->mtu < so->ll.mtu) {
-		dev_put(dev);
+	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
 		err = -EINVAL;
-		goto out;
+		goto out_put_dev;
 	}
 	if (!(dev->flags & IFF_UP))
 		notify_enetdown = 1;
@@ -1298,16 +1316,25 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
 			isotp_rcv_echo, sk, "isotpe", sk);
 
-	dev_put(dev);
-
 	/* switch to new settings */
 	so->ifindex = ifindex;
 	so->rxid = rx_id;
 	so->txid = tx_id;
 	so->bound = 1;
 
+	/* bind() ok -> hold a reference for so->dev so that isotp_release()
+	 * can safely reach the device later, even if a concurrent
+	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
+	 */
+	so->dev = dev;
+	dev_hold(so->dev);
+
+out_put_dev:
+	/* remove potential reference from dev_get_by_index() */
+	dev_put(dev);
 out:
 	release_sock(sk);
+	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
@@ -1510,7 +1537,7 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (so->ifindex != dev->ifindex)
+	if (so->dev != dev)
 		return;
 
 	switch (msg) {
@@ -1526,10 +1553,12 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 			can_rx_unregister(dev_net(dev), dev, so->txid,
 					  SINGLE_MASK(so->txid),
 					  isotp_rcv_echo, sk);
+			dev_put(so->dev);
 		}
 
 		so->ifindex = 0;
 		so->bound  = 0;
+		so->dev = NULL;
 		release_sock(sk);
 
 		sk->sk_err = ENODEV;
@@ -1574,6 +1603,7 @@ static int isotp_init(struct sock *sk)
 
 	so->ifindex = 0;
 	so->bound = 0;
+	so->dev = NULL;
 
 	so->opt.flags = CAN_ISOTP_DEFAULT_FLAGS;
 	so->opt.ext_address = CAN_ISOTP_DEFAULT_EXT_ADDRESS;
-- 
2.43.0


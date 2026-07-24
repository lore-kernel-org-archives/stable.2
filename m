Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52803B4EBF
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889229; cv=pass; b=fd/DO2INg884hA7OX23NIHGS/0U9YXB1fmk17mfHo5s/FDUWiTxNiNgbotUlwc8nlhnjqmanArJzsUz4FBzdNDSCPJQgDkn3gQYW/7af38EZhUhY6uhvjZ0m57lffRJl/M8WAB9VDGU1Y9lziXrF7bFvOXdhOouVP2ndZAVtGH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889229; c=relaxed/simple;
	bh=8hLcXX36PneCsCV4+swRcQf2KWia8SxvL98zRzO+3gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OM8k1o2UHlZ2vYlkuZ3pT0wdB5Kh9+Cems5FO9kttmo4FPAnZbDGYxvcgQq8u6MJYN49xCvEHL778VWy6E0nxQxQ50PPfHrqtQO7cLwhRtecaZOEK+gqXOCVSEVKV8CFge3FXvmKvUOMcFbTXVwgZwG/OWXgJvbLo0o41PBT5Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lK9BK+eU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/luCneso; arc=pass smtp.client-ip=85.215.255.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lK9BK+eU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="/luCneso"
ARC-Seal: i=1; a=rsa-sha256; t=1784889224; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oKcZ88I4tG0QGDZrmZ5Irf3C64IqAXEnRB0JKGUjlpDVjEdhEnU5IGJ+W88xOSfKV5
    SSdR4qX5yIxOBK4s+B0LK7zaXu79yLHq9+aiVJo/zOGUq/Gtd64E0MR85oitmRnVfY70
    BxNrKthiX1PMRB+lg9p1aehMiQRvyZKy3Wn3bN6s33ElWUmVPxZHoyuI7RIVoSGOhLVb
    CXWhFJNQ77rm71JCkKBqw9pweQbL+mVENmImfQ0gMXmt+un5BYGI/IkrVzwCmYHDooB+
    JrqFp8MRBkjXsUeTy94rNe906sZ3h1ZeH/CUSZI2tHb15kOyyI/As5pzif5Mje2HCtji
    YRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784889224;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kAFlgNsbsCrt0MMSnftbgKJNVOG4ZtqHsj6JqwVS1Os=;
    b=C8HcYfLuhEasLe+R0FlCmFnxeTDhA5FaUgKKZpI40PYchBRVkFopBbx9zHeJFH9FPa
    SsVkZPvDRsDH66rTK/8EpyNNBxynMfLU/Rc7uW8JCm0NoWSJbqCWACgEa1okDF1/wJWg
    64KFkXg6y9v2x4gGfRgXoTFB/8HEYEz20bur9uBHyjWhZQ4g41CgX3e2xcYPmb6Szado
    yWhR8+BIYmIILNyh9HB59Pxual6Tjm8dcoCCBYAFWP1wXA+/ku0Ms1hI7H7zGpirsUun
    0jxMRR1Q99oAx2nt8ZOeBPuXHxuT3FugifkO4wgGOKHZgVKRVmiAnXNjHUqPAJtUzeOe
    Ozaw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784889224;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kAFlgNsbsCrt0MMSnftbgKJNVOG4ZtqHsj6JqwVS1Os=;
    b=lK9BK+eU5UWoWXZSeq5/oEy8pCrM8J3ZvPF2aiNRY6oYKT6uGWb2+CXOPo4kGTm+fm
    mX0dkpQfW5LFkAUYz+JmDV9g9zwDJ+3Xtgzz00m1vK/br0G6aYpTxyvIIceU5+yzU5D5
    S0FRkDadZSuuNwmLJEidn4WfI5kiJIphCt/x3HmkUtlvl9Ly79rLRzb/bUY4Nx7ZD5zt
    Txleo3icoJjz+S5F4fBgQ0uA+xPskYLlNTsBeI6LG7mHZzTdKsENkbA4oPosAW5+2K+H
    tkB8uLC0aI0OOIFu3peTDBYnGEWtxE0t1Tr3oedVL83Ryf5RTfkxIRZM9+sv13oyyShc
    O0MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784889224;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kAFlgNsbsCrt0MMSnftbgKJNVOG4ZtqHsj6JqwVS1Os=;
    b=/luCnesoYw51gorFk2esq4+R3MYgk760+lvQNXPq1EETKNliSC59PWG5tbohTLW+nD
    MZUEYqUSIRqG/5NvPVBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAXitM3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:33:44 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1.y 1/2] can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
Date: Fri, 24 Jul 2026 12:33:36 +0200
Message-ID: <20260724103337.17723-1-socketcan@hartkopp.net>
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


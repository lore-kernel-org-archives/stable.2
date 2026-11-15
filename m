Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736674;
	b=U0b/4AE30zEaSAhlj6N7V41pa1SpuYOU3uzd+tik9I5CStK0rOipsat/5hGWS+0IT3ec
	 0IVEN3NxlatFPElqARFM5eZCL+QdIr+sBAEu9mhmup4DDLtbAUddZEG0gSiT4s7OUfkyz
	 VlA/Fn3joKPHM9BXUAUwbycXBTpmbWtdpTywNiI58WgwtmHBbg3Awlz9C9Hu6R6GMIs6H
	 tz+qNm34DYLfI0G8ivLOQv+wp++nYKlhcWBtklGf49qkQJRWd+uJc6SDK/O2ArUvWxWfI
	 Tjp6et1I67KY/E4YVeuknYQx3ASqgN/JICldUKVL0vgdRDmKrf2tqxLhlrInf0RG9Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2CVzP+WkYD9DwT6dhmfg7RSkn3jXjLANkl9tqbbq2n4=;
	b=oMOLvSJY33vL/zgki4e5/Gts/zbRifZ4e/OLCd5KlaKVuJPevF6Io4IqxsXJ5rbrMt38
	 CUBSqipQMetj5CAJBzeMo9BaWN4Ln0yzA+jusoxbU63e/sTZEZWGNhu2zQqkBdzwiDK76
	 C9NUwk9CNhw96/k9y9Yfrq0bR7h/88uu9nozpef2eesQyfQuPlI3xkHkkd/LbvxR29zBK
	 UVyju7bLOZLA5GdCSNGy58yScQxUXyf1BfRfDL8jjbwV2uqREoFhRvZnxNwaHv0r34rxN
	 ghVz2pBYtXs+LzD2YDylaxxXq/qFqrgiU6fnru579X5SJys3c04+BJCcEu5XDbxnTGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Tr+ta9iW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE6606A31F;
	Sun, 15 Nov 2026 09:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68EE6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Tr+ta9iW
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 77AA02059FD;
	Sun, 15 Nov 2026 10:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CVzP+WkYD9DwT6dhmfg7RSkn3jXjLANkl9tqbbq2n4=;
	b=Tr+ta9iWK+My+UG1JPRk2HTe5Wn1ISOVerkM3pUHRrMi1BrnuUZJyYS7yxI1LAEncTHXyO
	5WG11Na3L9XeZQMsgzfl6uhjGc8WQXu7UPc/lvUjA/ApSUkIXvKWNmR2QKwNVzHAHSqrGA
	fp+lNd1+kV6CLndM5R4YiNqpRe1GdTFfYSxCS9gvyW93WHx/5TPROwG4hs0WHo0UkAufPJ
	xHOxlkU2ifOXwcp/MXCP8+WCKMYZrik3o8dFDxt7g8aikiBrTyQWFdkMCSmzNGrDVHRcZH
	pGIQasXFkG4meLqvDPSsKDVPN28rH3HgjVdAOrwVoJqhtaHuSdlevPPj+RB+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CVzP+WkYD9DwT6dhmfg7RSkn3jXjLANkl9tqbbq2n4=;
	b=fsHGxc2fJjhpJjcKLZ23YZwLdAsx18KBxOYPI0lH2aU4VWsDgnq0m6Jwa37b9CtZ+gE1x/
	o89lFMj1+0i0cu3ixQs4KfGVK9nk/gJz+BXOnCor8d9QgEu+HYMLdGDVERYRGEoB6YFdZR
	LrBXxNf3gaOxku4xETsAmX0G8fp5kzDnfP16QmmBEgE287A1+6ZP5S93ouN5saJFD7CRWI
	g6XlS7ybJEGFfFnUSHYWGu4jy16KXE1NZLffnCpyWgl8gGQNJ/CkXy/bEl3YQe/HLKOPWM
	6is58ArYmFR9Z0oLFuuSNjzDH429zO3xJQ8REhw9yknyZnF93mZ2XrtiYttX8w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794736670; a=rsa-sha256;
	cv=none;
	b=bMZPhCdlqD9EnBd/Pqh//Swhh2NJuAw5R/liyiMI4bCZK3i8M8coBSUhP2l9UP2+2Q4iFL
	/pup7d4Jgj6S+YQT5OzwCIgdyKXS6t+M/cvjXNsEC4fUtCyOwq3ZN26o4nF09HSVxGFCJ2
	+F5Hw8EMhYabRW1ws3iXpkhqq+pjs8jZ/KWC8oCz1TuE6HXF8JqDdygnzUS1XIUzZ/M2C9
	RmcSp/7mBIK47ARLHzf75MzvG7KhvD91QNtzX4RNg1YmaR+PeOrQWqhMGPNeuZGe/lfO8+
	dN1hY0IA63S9H81zaLiwXxKwZRc/KL0r1hZqeb7cCaQu9PqvGyiivtelTc0V7A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSWze-004GWJ-19;
	Sun, 15 Nov 2026 10:57:50 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 15E4A5EC250;
	Sun, 15 Nov 2026 09:57:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 4/9] can: raw: use a private mutex instead of lock_sock()
Date: Sun, 15 Nov 2026 10:54:55 +0100
Message-ID: <20261115095746.709371-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115095746.709371-1-mkl@pengutronix.de>
References: <20261115095746.709371-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Hartkopp <socketcan@hartkopp.net>

raw_notify() takes lock_sock() of the sockets that are bound to a
vanishing CAN device while holding RTNL. Any path that holds the socket
lock while accessing user space can therefore block RTNL. Since
commit 43c973a0887d ("can: raw, isotp: copy socket options outside of
lock_sock()") the CAN_RAW specific socket options copy their values
outside of the socket lock, but the generic SOL_SOCKET options in
sk_setsockopt() and sk_getsockopt() still access user space under
sockopt_lock_sock(), e.g. for SO_ATTACH_FILTER, SO_LINGER or SO_TXTIME.
A stalled copy, e.g. on a FUSE backed mapping, then blocks raw_notify()
and RTNL on the unregistration or namespace change of the bound CAN
device.

CAN_RAW only uses lock_sock() to serialize its own state: the binding,
the filters and the CAN_RAW socket options. It does not use the socket
backlog, as raw_rcv() queues the frames directly to the socket.

Replace lock_sock() with the mutex conf_lock in struct raw_sock. The
generic socket options do not take this mutex, so they can not block
raw_notify() anymore. No user space access happens while the mutex is
held. The memory allocations for the CAN receivers in can_rx_register()
are still done under the mutex, as they have been under lock_sock()
before.

Sashiko suggested to hold not only the filter copy in raw_getsockopt()
under the new conf_lock mutex but to also protect ro->raw_vcid_opts.
This change will be addressed in a follow-up patch as it goes beyond a
simple lock replacement intended for stable.

Fixes: c18ce101f2e4 ("[CAN]: Add raw protocol")
Cc: stable@vger.kernel.org # depends on "can: raw, isotp: copy socket options outside of lock_sock()"
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261113-can-bcmlock-memcg-v5-3-634c0e04bc72@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index f14270b56f52..b69eaadc5e93 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -103,6 +103,7 @@ struct raw_sock {
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
 	struct uniqframe __percpu *uniq;
+	struct mutex conf_lock; /* protects bind, filters and setsockopt */
 };
 
 static LIST_HEAD(raw_notifier_list);
@@ -319,7 +320,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 
 	/* Lockless fast path, ro->bind_dev covers a concurrent bind().
 	 * Read it before ro->dev, pairs with smp_store_release() in
-	 * raw_bind(). A stale ro->bind_dev only costs a lock_sock().
+	 * raw_bind(). A stale ro->bind_dev only costs a mutex_lock().
 	 */
 	bind_dev = smp_load_acquire(&ro->bind_dev);
 	if (READ_ONCE(ro->dev) != dev &&
@@ -328,9 +329,9 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
-		lock_sock(sk);
+		mutex_lock(&ro->conf_lock);
 		if (ro->dev != dev) {
-			release_sock(sk);
+			mutex_unlock(&ro->conf_lock);
 			break;
 		}
 
@@ -351,7 +352,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
-		release_sock(sk);
+		mutex_unlock(&ro->conf_lock);
 		break;
 
 	case NETDEV_DOWN:
@@ -401,6 +402,7 @@ static int raw_init(struct sock *sk)
 	ro->ifindex          = 0;
 	ro->dev              = NULL;
 	ro->bind_dev         = NULL;
+	mutex_init(&ro->conf_lock);
 
 	/* set default filter to single entry dfilter */
 	ro->dfilter.can_id   = 0;
@@ -451,7 +453,7 @@ static int raw_release(struct socket *sock)
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
-	lock_sock(sk);
+	mutex_lock(&ro->conf_lock);
 
 	/* remove current filters & unregister
 	 * the tracked reference ro->dev keeps the device's receive lists
@@ -474,11 +476,11 @@ static int raw_release(struct socket *sock)
 	ro->dev = NULL;
 	ro->count = 0;
 
+	mutex_unlock(&ro->conf_lock);
+
 	sock_orphan(sk);
 	sock->sk = NULL;
 
-	release_sock(sk);
-
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
@@ -500,8 +502,8 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
-	/* lock_sock() serializes the binding with raw_notify() */
-	lock_sock(sk);
+	/* ro->conf_lock serializes the binding with raw_notify() */
+	mutex_lock(&ro->conf_lock);
 
 	if (ro->bound && addr->can_ifindex == ro->ifindex)
 		goto out;
@@ -581,7 +583,7 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 			sk_error_report(sk);
 	}
 
-	release_sock(sk);
+	mutex_unlock(&ro->conf_lock);
 
 	return err;
 }
@@ -621,7 +623,7 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 		 *
 		 * The reg_state check is only a shortcut: On a concurrent
 		 * unregistration or namespace change raw_notify() waits for
-		 * lock_sock() and removes the filters set here.
+		 * ro->conf_lock and removes the filters set here.
 		 */
 		dev = ro->dev;
 		if (ro->bound && dev &&
@@ -730,6 +732,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
+	struct raw_sock *ro = raw_sk(sk);
 	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
 	struct can_filter sfilter;         /* single filter */
 	union {
@@ -744,9 +747,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
 
-	/* Copy the option values from user space before lock_sock(), so a
-	 * stalled copy can not block raw_notify() waiting for lock_sock()
-	 * under RTNL.
+	/* Copy the option values from user space before taking ro->conf_lock,
+	 * so a stalled copy can not block raw_notify() waiting for
+	 * ro->conf_lock under RTNL.
 	 */
 	switch (optname) {
 	case CAN_RAW_FILTER:
@@ -798,11 +801,11 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 			return -EFAULT;
 	}
 
-	lock_sock(sk);
+	mutex_lock(&ro->conf_lock);
 
 	err = raw_setsockopt_locked(sock, optname, &val, filter, count);
 
-	release_sock(sk);
+	mutex_unlock(&ro->conf_lock);
 
 	/* on error free the filters allocated for CAN_RAW_FILTER above */
 	if (err && count > 1)
@@ -831,7 +834,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		struct can_filter *filter = NULL;
 		int err = 0;
 
-		lock_sock(sk);
+		mutex_lock(&ro->conf_lock);
 		if (ro->count > 0) {
 			int fsize = ro->count * sizeof(struct can_filter);
 
@@ -843,7 +846,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 			} else {
 				if (len > fsize)
 					len = fsize;
-				/* copy to user space after release_sock() */
+				/* copy to user space after mutex_unlock() */
 				filter = kmemdup(ro->filter, len, GFP_KERNEL);
 				if (!filter)
 					err = -ENOMEM;
@@ -851,7 +854,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		} else {
 			len = 0;
 		}
-		release_sock(sk);
+		mutex_unlock(&ro->conf_lock);
 
 		if (filter) {
 			if (copy_to_iter(filter, len, &opt->iter_out) != len)
-- 
2.53.0


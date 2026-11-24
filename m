Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510690;
	b=tQO994NOlcvOan54lxpZXl+olgGyASib5ITxRqY3g57++7cmjb97/LrpSApeiTeihkXZ
	 Au4FH5ZboHWntFsM8avUjzaZepiL9hDIPFzJ9kmxHxpxxgJpN2NZOMEV4Ga8h+rT5Qbos
	 u59wBIDHK+nF77AG0vEl8YGess/yRkm1nWFFUifE6NNlUS0WeLj+WQKyH6INXHyZSLjTm
	 PD2U+oCflGGa0mW+hXuJ8x/Cpc0sJc3Np0BDULb9GmZAMZ1RfGI5yNa7Habh8xtx0pZlu
	 IhEzDalXrRYq+DTHEbJauq3sz072WB2Oat73paVUfsP2VifGZgT7kdKAcLNUGaWxh5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510690;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CGS/rYgelltar460Hw1Px5oFFl0cLQ7MKv1pVz/e5To=;
	b=BfSjT9pnz4qVF8y/JU5ebS07QynmUDL8cwc7RvfpMCWhLx12t2hkIyOvYIpMzYDPP/QI
	 vder0fgQADAd4EbtCMz4LHMIJOhBW+sJX+suFi0Wr22g8F0oFur2Lglnd47jpInJKymcN
	 JFl9d5fGe71uDWLawKBrC+dX0ecKnA6cxKq27rj/ixrkZKJbmbvKR8dTCFy3IwfO/Cd34
	 1rEJjNUIUaWt1gsT64uotDxTD7uKSnvOjta3aIh+hwdtMlBhmsXMFDyaaHIdOyM0rk33M
	 FijGvM38K0ow0zdcAnGH8aebiP5ajdJkh4b4x31rDfaUw+GVCIYN/H5A55bGfXozQQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CAD9VTX7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53E606A696;
	Tue, 24 Nov 2026 08:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B53E606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CAD9VTX7
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7A941205A21;
	Tue, 24 Nov 2026 09:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGS/rYgelltar460Hw1Px5oFFl0cLQ7MKv1pVz/e5To=;
	b=CAD9VTX7wTNwGCUbjMSgGvlV2HL4KlzmkyiGcJyynQakHpw1Oi5uaJyMFyOLjpoBlKW3fj
	xlHEYkVO8tUprFthP7gF7kFPG9KUd5FsSZwot0eEnD534TyA8oFYt0/D+hqcuGyVoN+P7c
	d7M6hGwpX5VYgOA75QqIrPG7COpYObHDpWikeMFUr0oeHCmsSnR7NYdHTKhNwmeyJmWR4c
	iLOtO1z98vjCNK/lH0QVeztQTfuZ6/aAB3xR7O3Lu/Fpnyord5NV+nICi504OMjlSu66Hj
	FhmWjjFfMkm/fMS6IN34ZoLFewk9HPfrg7Vko/Hkc1XSE/1qfA4w5N9mbCIpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGS/rYgelltar460Hw1Px5oFFl0cLQ7MKv1pVz/e5To=;
	b=g4hbPMkkepBs9c/E4WcqY1gPPvjHR+BYlE5EiELJ8xw8NgeDRnVAkhCn3kNQCwQNlTKheX
	YN4Hofcq4eeJ3LHB4yYiCbLty+yHzvba42cdQZ7bRm8ro+trrur/ZG+8/elsZW9VD4QbEZ
	oDf4btXSZ0BPZZIYOtb4/krV7eo1jOyz+ImGZw0bZs5gkSjqLgengs4DykwS50/7BluD73
	lIt7F7y1rrKm1/EwiGZKM5R+9U17T/HDZh8vT1o3OnUJ9zI9w2sNgVng8FtjqElc1ENiw4
	r2gYXZ16KWy+INwKpGUvNmx8/ySNDnFo9B9A0y6bB4DSpPXKTmY+nCdn3kaW3A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510685; a=rsa-sha256;
	cv=none;
	b=bTCseoJTBc9ExQ6RvfJBPo+UW48YGg8c2+DYvSvYYN8AAT7zQkZP1LR++EtFwY1z1ljf0z
	582kch7HFqcLy0BLO4Sw3El+AHKOfhD1ht/E3i5QlT5p+mpjppIo7AOwrTKnfIJTRAAN1Y
	DzKpiGYCYQkyu1vHPP3e1tHl4q/C0lSbbc/2sE3R8FVLDHlbdraBcX/XpHTQir4tWYdQ6f
	IE1KViG9+OEodLTz/czx7IHe34JQ2OhL340yUwza1c+bsmuQWKpwc0bV5IjGwqgnuD9lRU
	vUeqvKNVXlTm8EcuHzgYNAGLVyP9nvlRU+vKyEnyKyHJ24xSX4zr7f+wokGHtw==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 03/12] can: raw: use a private mutex instead of lock_sock()
Date: Tue, 24 Nov 2026 09:51:30 +0100
Message-ID: <20261124085757.1093632-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124085757.1093632-1-mkl@pengutronix.de>
References: <20261124085757.1093632-1-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261120-can-bcmlock-memcg-v7-3-f6b84f5257b1@hartkopp.net
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


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510689;
	b=vxuErdNqSULhlM1Q0dRixfRE+Uz4gts46RdL7yg/8yW+OqwrFEHQz7k9RR0hm+zye2eo
	 MzrMxKl2tbOL48LgorrSQ/sR+T1Bt+Y7QRLGadZyzmCz42S0aZlmuOxP9jmm0h34Ouvq0
	 YEectnl0yimkAUDFoxzdn5XyDLe3qV0u4mkYUjEQ6lCjenSjIgUZbqgMSdpOxzE1X45Ma
	 unjYCapcDyr/K3JMyHNIuIdaIV56KLVFSgc2SqNXrewGZBlp8Fb+l3Um+md3z6NSuTsk5
	 HUXEan9YDxWfRZ4O7jPAGPx1/hIE/piGsO6BmhHumgUd6jD22n8Z4eWZrlzEOvgvz5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510689;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1AhGJBLQYGXAjn/bCuARkdD/zoAEVzxwHiT2NyPmhQw=;
	b=zsJeew7yua9OZdA4YHmpTHrbfBMk7LCoo9y28mc8+3hasDHiUeSpczxnlNVkDe0r1eM2
	 Yt4QZGp3vYsIpr16lCWfClmEGhvdvR2nxWfdi6hkv+Pr5ETW3GFeR0N6cynGa/W2sn3MY
	 dGVZq69xOzpOy7idjqwXfmcF+95uY8l0iS0gPV6SOWlh+T3BnAm/PwfBUHrAccjYydgIV
	 aZB8T4feLsu9+VXypB8SPUaZfckWDxMZEXBSVd9Gv/wcclyeHDBWRv2pBnPb6ihVnkPFF
	 1gP01ERpafOT+AGuAcVrpN2CAhqb5squeCgrlhqMqliqb7sBBVwkuIKp/kbFYilBmfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MY4X0eIf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A57606A699;
	Tue, 24 Nov 2026 08:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64A57606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MY4X0eIf
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BB780205A22;
	Tue, 24 Nov 2026 09:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AhGJBLQYGXAjn/bCuARkdD/zoAEVzxwHiT2NyPmhQw=;
	b=MY4X0eIfEHncu04urJK1+SValpfMVNznCHU6r7NEXanAP/X6J6enG3aOyH5yBJfpkvudT1
	beXwdScRgANkBaMvwizEm7W1CEhBOK1tWJ22rzb3+u/vciXr/N1/5dgmbKiNFzqT4kkc8Y
	JPGiSotXdEi4yRRLbDTd2rN3TW0In4J4Lq4PSc8sz8EVhqplx+Vp2gk6hneoZakLESQT3o
	XGLlLQ2vdDiH+hIcCWiZ+KtCubKd6Mi3Tb0NVJ6blBepuot2N47z7SMijYIH5nh5qn+3Vh
	iZ+tCP2V3FdiV0iqP1ZjJ+tvB4WawDVSNVbTnH5tFRFVMI5xGyCSE2LEO4H+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AhGJBLQYGXAjn/bCuARkdD/zoAEVzxwHiT2NyPmhQw=;
	b=R+NYQL44UUZb6/+aBsV85CZvY0p+m/c4qN12gWvj5p6L/LJyGB+LjuSswgXEpfSbnQ727G
	NYBttfVgB70eACL5tn4nNHlcDbETv535vXiv81QCVNip27Hbhm0WbCHj1HXa5Xrg1Ecfar
	18E9oVOUBdj4Icg9EkzLg6TDgHu+rSBSFhq30GJsCKCQ57mUiJ/fqpm213p0mIGfoIStpp
	WCGBSupT9v23A3dbB3xwLdQw2thJsbUj8PKcQOCp6bWR5zioF+ywUBslcCbxsFDjdxq3yA
	z4cEiZyWWqcOzDf+UtYhBLr65FcA/1W5Fs1/9MsFKW2KiXgvDQGZNgCaPJyYIA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510685; a=rsa-sha256;
	cv=none;
	b=G4uxlMQDY+bcXa0VX5n4aPQLY/gnJL6/qzxltT+yuJNsh8It0S6ag6jQIWLmfCrh2Slm8f
	vG3K/DYM+49ngT7qYiHXjXpDOSy3x1oZdtWnjSzYJwqXIG3cAGBS7uL0MXHEVktQLXiEhV
	rXSTSWMchSxhg7z62BlCmC43xGte8bgJhONaXg6SVpF3s1/aJVfj2CXe3pIHFyBbOEJDJ2
	pHPdeghPuZSbWY+iDp4NBCTiIewrl1oBqbqrF7k/sjKWi5TfmTMjUgcDKhzdjmUaRxYzgg
	n10934d4DAywIR7e0gHZC3EYgYUx0WLeEJ3m3bwNpP++c6anXUgNk8w6PIeyXA==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 04/12] can: isotp: use a private mutex instead of lock_sock()
Date: Tue, 24 Nov 2026 09:51:31 +0100
Message-ID: <20261124085757.1093632-5-mkl@pengutronix.de>
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

isotp_notify() takes lock_sock() of a socket that is bound to a
vanishing CAN device while holding RTNL. Any path that holds the socket
lock while accessing user space can therefore block RTNL. Since
commit 43c973a0887d ("can: raw, isotp: copy socket options outside of
lock_sock()") the CAN_ISOTP specific socket options copy their values
outside of the socket lock, but the generic SOL_SOCKET options in
sk_setsockopt() and sk_getsockopt() still access user space under
sockopt_lock_sock(), e.g. for SO_ATTACH_FILTER, SO_LINGER or SO_TXTIME.

CAN_ISOTP only uses lock_sock() to serialize the binding and the
CAN_ISOTP socket options. It does not use the socket backlog, as the
received PDUs are queued directly to the socket.

Replace lock_sock() with the mutex conf_lock in struct isotp_sock. The
generic socket options do not take this mutex, so they can not block
isotp_notify() anymore. No user space access happens while the mutex is
held. The memory allocations for the CAN receivers in isotp_bind() are
still done under the mutex, as they have been under lock_sock() before.
isotp_release() drops the mutex before synchronize_rcu() and the
hrtimer cancellation, as the socket has already left the notifier list
at this point.

Following a Sashiko feedback for raw.c it would make sense to copy the
content in isotp_getsockopt() under the new conf_lock mutex too.
This change will be addressed in a follow-up patch as it goes beyond a
simple lock replacement intended for stable.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org # depends on "can: raw, isotp: copy socket options outside of lock_sock()"
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261120-can-bcmlock-memcg-v7-4-f6b84f5257b1@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 7a90ba3f1cf1..8229b6a69ecd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -182,6 +182,7 @@ struct isotp_sock {
 	struct list_head notifier;
 	wait_queue_head_t wait;
 	spinlock_t rx_lock; /* protect single thread state machine */
+	struct mutex conf_lock; /* protects bind and setsockopt */
 };
 
 static LIST_HEAD(isotp_notifier_list);
@@ -1497,7 +1498,7 @@ static int isotp_release(struct socket *sock)
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
-	lock_sock(sk);
+	mutex_lock(&so->conf_lock);
 
 	/* remove current filters & unregister
 	 * the tracked reference so->dev keeps the device's receive lists
@@ -1519,6 +1520,8 @@ static int isotp_release(struct socket *sock)
 	WRITE_ONCE(so->bound, 0);
 	so->dev = NULL;
 
+	mutex_unlock(&so->conf_lock);
+
 	/* Always wait for a grace period before touching the timers below.
 	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
 	 * filters and cleared so->bound in isotp_notify() without waiting
@@ -1535,7 +1538,6 @@ static int isotp_release(struct socket *sock)
 	sock_orphan(sk);
 	sock->sk = NULL;
 
-	release_sock(sk);
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
@@ -1585,8 +1587,8 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
-	/* lock_sock() serializes the binding with isotp_notify() */
-	lock_sock(sk);
+	/* so->conf_lock serializes the binding with isotp_notify() */
+	mutex_lock(&so->conf_lock);
 
 	if (so->bound) {
 		err = -EINVAL;
@@ -1596,7 +1598,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	/* A transmission or reception that outlived a previous binding
 	 * (unbound by NETDEV_UNREGISTER) may still be draining; the FC/echo
 	 * and RX watchdog timers bound how long this takes. Checked together
-	 * with so->bound in the same lock_sock() section above, so there is
+	 * with so->bound in the same so->conf_lock section above, so there is
 	 * no window in which a concurrent isotp_notify() could be missed.
 	 */
 	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
@@ -1686,7 +1688,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 			sk_error_report(sk);
 	}
 
-	release_sock(sk);
+	mutex_unlock(&so->conf_lock);
 
 	return err;
 }
@@ -1790,6 +1792,7 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 
 {
 	struct sock *sk = sock->sk;
+	struct isotp_sock *so = isotp_sk(sk);
 	union {
 		struct can_isotp_options opt;
 		struct can_isotp_fc_options rxfc;
@@ -1802,7 +1805,7 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_CAN_ISOTP)
 		return -EINVAL;
 
-	/* copy the option values from user space before lock_sock() */
+	/* copy the option values from user space before taking so->conf_lock */
 	switch (optname) {
 	case CAN_ISOTP_OPTS:
 		size = sizeof(val.opt);
@@ -1831,9 +1834,9 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 	if (copy_from_sockptr(&val, optval, size))
 		return -EFAULT;
 
-	lock_sock(sk);
+	mutex_lock(&so->conf_lock);
 	ret = isotp_setsockopt_locked(sock, optname, &val);
-	release_sock(sk);
+	mutex_unlock(&so->conf_lock);
 	return ret;
 }
 
@@ -1906,9 +1909,9 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
-		lock_sock(sk);
+		mutex_lock(&so->conf_lock);
 		if (so->dev != dev) {
-			release_sock(sk);
+			mutex_unlock(&so->conf_lock);
 			break;
 		}
 
@@ -1932,7 +1935,7 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
-		release_sock(sk);
+		mutex_unlock(&so->conf_lock);
 		break;
 
 	case NETDEV_DOWN:
@@ -1991,6 +1994,7 @@ static int isotp_init(struct sock *sk)
 	so->ifindex = 0;
 	so->bound = 0;
 	so->dev = NULL;
+	mutex_init(&so->conf_lock);
 
 	so->opt.flags = CAN_ISOTP_DEFAULT_FLAGS;
 	so->opt.ext_address = CAN_ISOTP_DEFAULT_EXT_ADDRESS;
-- 
2.53.0


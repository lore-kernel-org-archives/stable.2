Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736676;
	b=eZiTgJBShIm1JucssGzJ5erNU5aaYToiEqZ68x0mxi4w2AaCuO8XazWh5Tlk3IFQcfpr
	 NjPBk6iLuX/slpHhMaRvGqQCqe1w2mxtKsKnyRDCowOBAtS71tEnWLl3cNX6eH1pKFA/H
	 HElxhFxno++A9pR/EgHMLNlpzEd6UWsTvX5R0kkUF27w7950jsBnYVUj8ZnS7emfKvpTH
	 FPyE+pzwKQGJfezJUWZHyIUlKismn+jNzAECAd3J0eXHV2V7GWdntZ5ruk16Ja0dG3/N2
	 02a3Y6oAJ/UFYU5vI1nj4ZCllDwY5/BpDva2GclIt0NPQIblVauhUp5AFuY0aZ6EWkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736676;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZNGlmFHwWs4LB2wB462fQq+acIDeReyTK8DzzFOveDE=;
	b=U7gOKw/fG/gzEe32UyhBtYEvT91bL0oplG8503e97aQCLo5AVCFfd4n6YJrIkMZ74pbT
	 fbYyhzzUtbx8WfZjVEWX/zYO0mWmsSe8mdph5eQfY1osA7NqZwvphX1sfNt0mLG1B4wkq
	 /idkBqVeNmv3XHmEi3s3Mfy5fO+0oc1jYVviUClMWAV0//QI9W9znonmScVXig0usFWWL
	 t4Mb8ySUNnQVaRvfsiL1QUukWz9nwJEIPoLa/NTJ8MPO6fv3fnRXhRi9sHWVvEuNODLwk
	 2ZfcH4gwmjgZoWKDk4QAjXgUdv3DfjlYECApDuqFp8XzfSWR6tp9BwvJXynU1j8R9LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=C36wwsgv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51A606A89B;
	Sun, 15 Nov 2026 09:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C51A606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=C36wwsgv
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 93425205A07;
	Sun, 15 Nov 2026 10:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNGlmFHwWs4LB2wB462fQq+acIDeReyTK8DzzFOveDE=;
	b=C36wwsgvzZ6uIJkds54J8djGROk254VSTRxhNu6IgMCiO4R6HMmCH2oHJtTEy0cq38r8sw
	smEiEZAy4VDbA8jZdu0MbU5+NRWSLw/4p4aXxnas0za+EjDIhZf/KjHy9jyghMB00Cr275
	yiJF6wz3x9f8/tWcTDQqX7OHi6ZJBQamKhUp6f02pfO+KeiTd8gzuaUl1mYwisRqz6AD3y
	QKwZbIz97Q59T1B+2YBw3Xpal3g8kU1FaRWVT+S3faRrbUKu0lL/V9oQaMBMrBLLm9ppsj
	rBNOlHIix8dq8MuduSDE5zieOfHq7TUu7p11VopRBVFAcL3LdORsl7Cf6IO8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNGlmFHwWs4LB2wB462fQq+acIDeReyTK8DzzFOveDE=;
	b=fCnjKNZKBeXC5sVHY42LC8PIz3gyYYSbr9VskJ4YbXqGyAtqmS9K2JoZdYqbLNZA8lcYwZ
	xJbFwCLZa963Q/Sbevi7Mh7FxmNaMveVkW3RsoWZKufy0rkEnvVwQh6sCXw5zXPL56n5N6
	We+soU6eNWurQKMYSLoA0N7WQo0+mkA4EozHp6+EnZE6sOZ0qbh1TMMJRiw/zy4xBe99Zp
	W1qQd3YBqAQ18dmzVLikZhSLO2xeb2Lhztw7naWKIGrNghYFtA7wms/p8QkXia3kWqYElq
	PWThJ7DxlngF203OIjE0X7yZkh3X9VVCQGLp7EvV1ffzYjYNKleGjWfXrMVpMw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794736670; a=rsa-sha256;
	cv=none;
	b=UL3EvMdxMBBd5eN9BaKvi+4BWGfj8LZLW0Eu/jmHqC4V/R6pJz0xHZ0rp34hn8cgHBR8XC
	cdhMc6+NRcZJ8Y1TNfKrMnFg0SjViCpCx+NgbP0om7xihxmvlFJ9fSp3/4SEkKxLqAMmem
	pP6xOkaSp71P3dF/QWrrBrjemrwYRdHEo6mG7lbgSM6xmchy499ZFo26CRPuOvVfu/4kP/
	H8Tbr2idLF1Z8AKFdGjfgH+c204PtFdIUymK8kwE0KZ6HspoSoiTxBs4dCSVk6RmxTrlO/
	WZjV/9leiWGTA+G3PZVZNq5RrIGlsuQ6aLtudd+atLhBHx8UiINtofSCq7JnwQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSWze-004GWO-1V;
	Sun, 15 Nov 2026 10:57:50 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2981B5EC252;
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
Subject: [PATCH net 6/9] can: isotp: use a private mutex instead of lock_sock()
Date: Sun, 15 Nov 2026 10:54:57 +0100
Message-ID: <20261115095746.709371-7-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261113-can-bcmlock-memcg-v5-4-634c0e04bc72@hartkopp.net
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


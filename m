Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736676;
	b=n3Wr7eMMCJF0aQVYmPUvRK8/Cuas/RZmGXw0j9nAB0Mv7fqow1CDL+yQu012xd6gf1VN
	 mce9RrO/A1YyIFb8cL38sXCIchP3/WBBMSGntznORgfD+WQSeh8n9jVgh/89jEVdSQKaH
	 d5XSZX3wAQll2D5NYAMflHqpLBlJtIQOeX6NhpPrUhEpR4uqtuBvaLcVMCwY8UEv+TEg7
	 qHTt/2BE3WEmq6bHOmDsdCT+VLx7hmcHO4Fayr+9iZqofoqNNj52pB7eaJlVCFFqRsius
	 7/gLK1ybo577Y62ONX/k56o1qniwXSpi3P4LAjEHxyTg109J827IGtVv7hf9D1+4FOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736676;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AuaivjySb+5Vj+muuf77hKS1ebg1ISqCaZ13ZULp7WA=;
	b=DPbqFCPhe1xagGlKgEtN0T4YgFBtsdQAX5ph2Xz0C6cqoTSHbfuFWF7ts7g2M6hljkhM
	 jnSJ8dgO9RJyO4mX70MPSvTjfD06QqkGWy4Dz0fBknDedZonmOS/+uqsiV/i9qIUHBlZt
	 Ob5yzekf3J8LdwnVWfl5t7vKcnvnuuVaesi8HEjx+mzUwKZFvh6JlJG64tPRdg6EB7T2D
	 kgNPOoUHoEtDIGJO1WDDvW6QbmTJgYVI8rm8O3Rv/t0UGRUumle4oIDzcSp9y/QgloSr6
	 YbGBE76lYBg0a+WRH5aXeaJjft18WJPxmlnoJvTQoQMrvj/MvxyNyFx2YGzCkWN/+Kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Kk6+13Qf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3AF606A337;
	Sun, 15 Nov 2026 09:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C3AF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Kk6+13Qf
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A1C40205A09;
	Sun, 15 Nov 2026 10:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuaivjySb+5Vj+muuf77hKS1ebg1ISqCaZ13ZULp7WA=;
	b=Kk6+13QfY7oELFOXISchMb+adC1fbZ2DnHmq+YtL+7zEQ0uZXkTg6LlLzD6Q5mpHbYAQza
	Za2GNcncBbuH7fnTzkLXTkyROe8rRKDly51oI/uis8LV8RWlbMz1Lt9g8+/0PeBGF06lCc
	lVSnOEcNtV756lgxdc18kgT3bZY9mUF1mImdENnXFryJNtV5yB9QvAsbcjqoeJwV7EmkVN
	Mlq+R5Wfe3xTyLau4CCZUpl6qRidVj6EuO3+ABZpKGAjUJZOK7l/43n9KRDXrRbtCr7Pd/
	NtYCh7rPV0bgcUL4NSxNjT5JEatlo6tVD2Mo608/DtySWNjeaEJEBOpErTgmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuaivjySb+5Vj+muuf77hKS1ebg1ISqCaZ13ZULp7WA=;
	b=SOiGcdGk+ubXZeMWfKh2IMqYZyBiBVa3Ps8X1JOc5mXLtrn4ly+BE5aH7TGlN7UaWSMWs+
	93G1eU8r1ZV3hF1tnfDRp58vADYS6npUDkgpa+DJyJOpx+g5GtGh0nxZ/QkPqRIyDunUT6
	lJK1KIxtHiAI+pflJcY9OpP0PkwgGhkyqCXmwX6dxnLsgboHaqc/Jq/EhleDjHOCjMckbf
	tvml5FsRybF9nFmqBMcEV2YiCVvvwKxdzEJ9jkpaaQW4p1I598MlKtoQHOACJB15ToOeaf
	7eAeqVHLri7naIUaizkVlbnf+rfK/ykTc/8XLmQWo0VWA32A7EWukCFb92iXlQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794736670; a=rsa-sha256;
	cv=none;
	b=cMxXtRSeXBuBIjArmxGKM7tKZwXfZy6YBtfXPxDpzmNt111NApZO+RhVTr9OE2XMJGbSiF
	A5niqPRV21/rUrNRZnl+hbQqP1S9idxAkzGvpXn+TZc3m9zV92XyeOX3sqDt9zRm+nfLy/
	lQ1iwH5GRc5Qy5t1NGNbPM/8dVR8C/eadPzJRbh49vLCWzpLQzLsykjKales12kvYn5r6F
	qIA/fBSdBkk4gldu6R6V3QlGPQU95c6pfY+m8PqrpjdndMdRUYma+2t5T4n4HHgFPQ/zeC
	jD2+manJuCUaA5aFft25ZB8iHUUVPQSq0bpy8IIALND8yyu9XmHmMWMhuYd+3g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSWze-004GWS-1b;
	Sun, 15 Nov 2026 10:57:50 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3CF695EC254;
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
Subject: [PATCH net 8/9] can: bcm: use a private mutex instead of lock_sock()
Date: Sun, 15 Nov 2026 10:54:59 +0100
Message-ID: <20261115095746.709371-9-mkl@pengutronix.de>
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

bcm_notify() takes lock_sock() of every CAN_BCM socket in the namespace
of a vanishing CAN device while holding RTNL. Any path that holds the
socket lock while accessing user space can therefore block RTNL. With
"can: bcm: copy the CAN frames outside of lock_sock()" the CAN frames
of bcm_sendmsg() are copied outside of the socket lock, but the generic
SOL_SOCKET options in sk_setsockopt() and sk_getsockopt() still access
user space under sockopt_lock_sock(), e.g. for SO_ATTACH_FILTER,
SO_LINGER or SO_TXTIME.

CAN_BCM only uses lock_sock() to serialize the binding and the bcm_op
lists. It does not use the socket backlog, as the BCM messages are
queued directly to the socket.

Replace lock_sock() with the mutex conf_lock in struct bcm_sock. The
generic socket options do not take this mutex, so they can not block
bcm_notify() anymore. No user space access happens while the mutex is
held. The memory allocations for the bcm_ops and the CAN receivers are
still done under the mutex, as they have been under lock_sock() before.

bcm_release() removes the procfs entry before taking the mutex, as
remove_proc_entry() waits for readers that may stall in their copy to
user space. The socket has already left the notifier list at this
point.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Cc: stable@vger.kernel.org # depends on "can: bcm: copy the CAN frames outside of lock_sock()"
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261113-can-bcmlock-memcg-v5-5-634c0e04bc72@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 1595b7720c98..dc9e2890490a 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -145,6 +145,7 @@ struct bcm_sock {
 	unsigned long dropped_usr_msgs;
 	struct proc_dir_entry *bcm_proc_read;
 	char procname [32]; /* inode number in decimal with \0 */
+	struct mutex conf_lock; /* protects bind and the bcm_op lists */
 };
 
 static LIST_HEAD(bcm_notifier_list);
@@ -1673,8 +1674,8 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if ((size - MHSIZ) % cfsiz)
 		return -EINVAL;
 
-	/* Copy the CAN frames from user space before lock_sock(), so a
-	 * stalled copy can not block bcm_notify() waiting for lock_sock()
+	/* Copy the CAN frames from user space before taking bo->conf_lock, so a
+	 * stalled copy can not block bcm_notify() waiting for bo->conf_lock
 	 * under RTNL. Only the frames the opcode handler reads are copied.
 	 * The handlers keep their checks and read the frames from fmsg.
 	 */
@@ -1714,12 +1715,12 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	kv.iov_len = flen;
 	iov_iter_kvec(&fmsg.msg_iter, ITER_SOURCE, &kv, 1, flen);
 
-	lock_sock(sk);
+	mutex_lock(&bo->conf_lock);
 
-	/* Re-validate under the socket lock: a concurrent bcm_notify()
+	/* Re-validate under bo->conf_lock: a concurrent bcm_notify()
 	 * may have unbound this socket (device removal) after the
 	 * lockless fast-path check above. bo->ifindex is only ever
-	 * mutated under lock_sock(), so reading it here - instead of
+	 * mutated under bo->conf_lock, so reading it here - instead of
 	 * before taking the lock - guarantees it can't be observed
 	 * torn against bo->bound.
 	 */
@@ -1819,7 +1820,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 out_release:
-	release_sock(sk);
+	mutex_unlock(&bo->conf_lock);
 out_free:
 	if (frames != &sframe)
 		kvfree(frames);
@@ -1843,7 +1844,7 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 	switch (msg) {
 
 	case NETDEV_UNREGISTER:
-		lock_sock(sk);
+		mutex_lock(&bo->conf_lock);
 
 		/* rx_ops: remove device specific receive entries */
 		list_for_each_entry(op, &bo->rx_ops, list) {
@@ -1877,7 +1878,7 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 			notify_enodev = 1;
 		}
 
-		release_sock(sk);
+		mutex_unlock(&bo->conf_lock);
 
 		if (notify_enodev) {
 			sk->sk_err = ENODEV;
@@ -1930,6 +1931,7 @@ static int bcm_init(struct sock *sk)
 	bo->ifindex          = 0;
 	bo->dropped_usr_msgs = 0;
 	bo->bcm_proc_read    = NULL;
+	mutex_init(&bo->conf_lock);
 
 	INIT_LIST_HEAD(&bo->tx_ops);
 	INIT_LIST_HEAD(&bo->rx_ops);
@@ -1969,15 +1971,14 @@ static int bcm_release(struct socket *sock)
 	list_del(&bo->notifier);
 	spin_unlock(&bcm_notifier_lock);
 
-	/* bcm_notify() can not access this socket anymore */
-	lock_sock(sk);
-
 #if IS_ENABLED(CONFIG_PROC_FS)
 	/* remove procfs entry */
 	if (net->can.bcmproc_dir && bo->bcm_proc_read)
 		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
 #endif /* CONFIG_PROC_FS */
 
+	mutex_lock(&bo->conf_lock);
+
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list) {
 		list_del_rcu(&op->list);
 		bcm_remove_op(op);
@@ -2012,10 +2013,11 @@ static int bcm_release(struct socket *sock)
 		WRITE_ONCE(bo->ifindex, 0);
 	}
 
+	mutex_unlock(&bo->conf_lock);
+
 	sock_orphan(sk);
 	sock->sk = NULL;
 
-	release_sock(sk);
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
@@ -2034,7 +2036,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 	if (len < BCM_MIN_NAMELEN)
 		return -EINVAL;
 
-	lock_sock(sk);
+	mutex_lock(&bo->conf_lock);
 
 	if (bo->bound) {
 		ret = -EISCONN;
@@ -2086,7 +2088,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 	WRITE_ONCE(bo->bound, 1);
 
 fail:
-	release_sock(sk);
+	mutex_unlock(&bo->conf_lock);
 
 	return ret;
 }
-- 
2.53.0


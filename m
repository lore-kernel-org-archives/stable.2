Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510690;
	b=0L+XakyDi2UsRXK4Y97UMw93VB83eJVdzOGSEzpo/6xQ3pl6Mjw3Qzvp9SOJNc2zKBne
	 7V82b41YnZqw9kZTVZQx4Ph2uNvA8ve+4QKB9TfeEks8iUGB4TljeK8k4/a50MWo4Pyqq
	 roM7gJ8ssxkYZ9pwGF/5vAz1tuTYzerDsFUDRC8nP2QIePw9fIK9UpWfR3quUVMBXrMcw
	 KFvTmrMlRX0gu3AJgYIuSI0H1Qe8aC9rihlPCbbcvCNgPMmukt2VP7+HCWgLuQ3XYR6Uy
	 iXyBjNauX17MGiMwNkJRpsZY7EkBb9qu7lbz96kxHOObGrVH6zb+5+oPDKSgDPUR8kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510690;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mze21OvYOmIcP21bm2KY+Sy+rMLxzvAs5hpVAMgco/U=;
	b=K/DKLoJ/g+qtuEYYQOKbQwT5C4yms1DyJn/04G2iuq8VxCeRynwM8a+TAyvO05d5uZ37
	 Y2pa3DMV2qY9HtguDkWI6Si+X1mCofl8amRi7Gdmi+ZzI3nPWFGfmpxx+lLK7opeQpyN6
	 YTwW5ZiyJTk7KYb7JbxMHHkrDC4QEpw4Fn3qdzwa1M+siF808P2VAQJx2Ct7n3EgJkB5m
	 6LKotaizOXZrPco86kJqfRQz1QFVggGI2oGrZ2qAJTp34J3URZxkM5eLOxOR7Yy63zt9N
	 nDQSvtiokTsVGynlzzflRBvPJZo+q1RQTd7d+3fGgHssVJ7JE92kNLnoa0e1F2pvszg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SZQJKH3M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7567606A6B9;
	Tue, 24 Nov 2026 08:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7567606A6B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SZQJKH3M
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EE5D7205A10;
	Tue, 24 Nov 2026 09:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mze21OvYOmIcP21bm2KY+Sy+rMLxzvAs5hpVAMgco/U=;
	b=SZQJKH3MZe8OA/VA+ky/S9AxLC7mjlp6OmuOmt0zrdVcGz33qg0n5d8ZaEhns3s6OBaIJF
	9EHRZDJ89qdic0oy3sGMhYBP6w1AMKtjo4aTN2ahwakX1XtBdGtSHaZf3cz9dLRgalrJW7
	Hgsu/r73xn1kez0WiPsFpthEjsYp3rF7CVPAW7q2tXkzFSoYMDcSb/liXIjE2BMkNlIX5Q
	jrtE3F+Yckzi0G9NYU0GYK6uETTqyJYFHQy5dq9jAPeVkPvbCojV+rPh+a6eig9nZWcVrc
	2YvBl8rIawqhn4uIFAUcRUbjZ4XTJ1K8edzl1MYKVYL/rM/XiGuERDuZGMTQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mze21OvYOmIcP21bm2KY+Sy+rMLxzvAs5hpVAMgco/U=;
	b=e9uhNiB+ZhUgfneLJ66XYN9In1HJCg/ay4m5szIj1bdCHH/Wu4YW+itdK4efSIyXE6KcK+
	luirbQ+5YG+JGZRlmplqYbJS7XT8S0/v7X/nDhgECdaj7X2R5kPnQiY6tTWovhLt+vwvCa
	CbLRZLfH93d2b267L6AQurxnHbj7E9hQaFmaYRNuA8uo8Y3JYxDS86gECofnylluRPlljx
	ZAgXYg3gPARoo6tM/ABQJFdosLkaRdQ0zfjY4h6mPzh12oe5jBWth7TDn/oEwFAOjs/6QO
	vMIPSo3daWsJgySByBQpub4HS9NgOhDfvYrQydeO4oeP0AssWF85rywHwPvL0g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510686; a=rsa-sha256;
	cv=none;
	b=R1ncK1EYf5CblfMAKMctgPVIiW71FWMI/LJ1txLHAvtJ2NeGTiWTIXLxrzml9yJQN7U5Nv
	uFtgyJDpo1M7yVW+SpVEs8+I21isNT9L01FXePO0xumum7UCqW6QU8kSmJO5gr+zucEGWj
	L0UgbO8pyOFBpnQMCmg+20Prj/tz5KN83L8UQQlOL7NELUGB6iNqr+CkQD9Fv2kahJTs41
	/9PkblZnjALBSTgfcgUtAp+WmL0arJTwZSXWEFf4WJSErk4NEgY2EcavKQlmWu/ih82+NL
	AsVp5JG7c9kXJ1FvGe+rFXohYhIVevtaX52nLvJPQ5n74BbrNgJuxXouGYQUog==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 05/12] can: bcm: use a private mutex instead of lock_sock()
Date: Tue, 24 Nov 2026 09:51:32 +0100
Message-ID: <20261124085757.1093632-6-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261120-can-bcmlock-memcg-v7-5-f6b84f5257b1@hartkopp.net
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


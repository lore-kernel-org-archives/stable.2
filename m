Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953348;
	b=IO1kwr/QuRRUKtMrbjNHIe+Px85gZ3DvI8YnCx1PFscsvd9pR+ze4n3l0oWW1RRbGOCN
	 wwt6Bn7baw7lVh3uGMXI/8r7qf2spw4J8d7+rrVGKfczk5cJgNnXYMAGq0h7+XFNGZYGF
	 PIqUu+9d/0+7I1mbmWafrpAslpgaGuuteXnJ/IFjjmfUOfW+J59wAU9cERZI96P55UyTT
	 bpLwtbDvFQxQmxf97XfLMTJ9ueh2g2zrThLbReb6JIIPb+jPHKWL7lG6vMcY8h/9LJBqv
	 7/pFGSUvU2cwsmSF3Lp3Fra7Cz4vOOw74qDNDA2XKLF3MceVT7RY1PJa5WTnfZMErFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953348;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ev5y31uxBqmh0ulOq2osZXWPzVo8MTYsJZ49voX7MqQ=;
	b=WAEHBGJCB2CIbkc4ojwb8k8NuOrS6CF7ctUwNvkfyrK0uue70H/Xqcj+DH8KcU57shKg
	 /dD8CSFMR9KdSGFMO0EefG9Klh7rbXibG2TbbOi9o6IQvIU7G1yrA4zo7NQHgD0wnj4yQ
	 AyTof2FnE4RTX41L6zEq6wogPfylyKIMFtvP8QB6AielYQiA7XMZs0oOhC8Z3BahkzK1I
	 WJDDxHW7uN2RaNwS3GkDZsHnMXS5KG9mfvvpAmxM7mA3aJohzgg3HrEJCfn9nh+Q1+MQA
	 rLiRs3RM0gpQyEORDZLAeyGqhRxGPbFlFhKj+ZSpsOZlmBG3JgTNDxxf2xvD2yYd0IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=U1v6VBQu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA61C606A335;
	Tue, 17 Nov 2026 22:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA61C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=U1v6VBQu
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4C5A0205A64;
	Tue, 17 Nov 2026 23:09:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev5y31uxBqmh0ulOq2osZXWPzVo8MTYsJZ49voX7MqQ=;
	b=U1v6VBQuD8S7ow0tr2u6u13c8zONNofRtd79DchIDLyUlTzuiJaIhLjURoZTmj/O6a0QA3
	bkbtpZ3j2mXqez33tI4YUY6EmbWqlG93b/QN8OfJ2j9FDR707l2hjKMg9Zpz+HeR5m5mk1
	+JEdEPKeIQFIwYQm510aNFyn3nuF+GIFRMhB1YWEAYgyfpDYUzQ0Ek123KqaKZz2XdrFZd
	+zagEgLz7h9JZNgfdTRKy5lcDOfk+FAF+Pm51VXSvL7QZU7C0mp3v6ZkGd1j1uPwM0H1b6
	Eh8RM5Dcrks3j+Sr9hxlD7WXGOqnlvEGKrHeaM9onLZbdmt8Td2chvDktuOu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev5y31uxBqmh0ulOq2osZXWPzVo8MTYsJZ49voX7MqQ=;
	b=RlWMuEqbk/c+fd7MPg0RtKtuClVlpFjz2t1WXoevwN1A9Ad0xSLEMhMvjSmlJOM3C55Pp8
	araO/y4WwoSsPqQOT69J5b0ooiqpV0zGiuFIsWFnJEbG2fcXO6eJQyH78ctS7e9tn537R6
	Y6fGXV0Gby3kwjArD671h++JGtKgUv9BLNhAYs/Ac+UVNQ9kCOIS1V0YIxxWEc4W2qWGLH
	RDXXAYe95gFZxXHdtY9kQkDddCgaiwR18lD2uA6vjXW8apFhg6Yed4gYV928rI7LRjp9Xe
	p8ICOkA0ll10c0/pVAoqAkOqQWTvBlpBcgJ0/CdYpoqIPqshcPMDIBW7z4ZAPQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794953342; a=rsa-sha256;
	cv=none;
	b=dguIMeu7o4Vn1N/YfNdpHPdGiABzZw/RsoBmtxBbSXRL6/arupglWPBiR1La0w9M4q7xV0
	hfHOsrnQoqnko2dwixTaBFSPRJbQ+f62XIxA8hH+NpnnbCEw7RGaWki7EtcgAvgAga6rEe
	Ui1xBIcRwkFnfVzsVXhOgp4cwLm22g+Ir9KUQVUdGDaRCCdj0GDFO4oYQN+CAa3f/ly0Vf
	y+G+cl7wRPctkekCGpYpA2gxtUAtgx9I9FJTp3i1Ry4XpQ1cbbhS2zOIoDBPkSXh92tQ2D
	xSu60AHjfbu5AfiCveTunMyZQmXSbO/8zl+H5AOzGykMF31jZpvk/25HJlXF3w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTRML-000Fmc-2D;
	Tue, 17 Nov 2026 23:09:02 +0100
Received: from blackshift.org (unknown [192.145.8.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A83775EDA28;
	Tue, 17 Nov 2026 22:09:01 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Zhu Ling <zhuling0805@qq.com>
Subject: [PATCH net 05/11] can: bcm: use a private mutex instead of lock_sock()
Date: Tue, 17 Nov 2026 23:03:10 +0100
Message-ID: <20261117220818.1142581-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117220818.1142581-1-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-5-6826a6227d36@hartkopp.net
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Zhu Ling <zhuling0805@qq.com>
Cc: linux-can@vger.kernel.org
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


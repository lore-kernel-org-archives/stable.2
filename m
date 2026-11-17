Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953334;
	b=St6ZqoprFaPrnVmpgYJVczbarUH9qYVTLhM1UGI3HgjIbtcno23IVhyMNtn3kdov7ytd
	 pWqvJJrWFpgEyqWJtjX7KFXt02sS/OWt3qLNsEC5d24XLNjk9i9tByUDDO0MS0BvwhbPT
	 hEo/E5E7dhsjziqdiBVXYTHmtqIJgGurorw4YONi5uz4ZboeB7pfCVWb8WmmqWqsuk9I8
	 ffx6lnkW2SDZpemvmaq0XETTWvR/o4fPwb6e9QZxw0+GjUrzFOVfEEk4ALXOYoZvfv8Qf
	 1i96Uk2/Es/OxNts0wNgZYdR24vSDE8/zPsaeRwFDwcy/Sw4cAlB3hb6tQ4JcFlMOsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953334;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+MUhm+aLIZKS2wGISTQ6+laWnSTjIlWlWKEMIYweqZo=;
	b=zOd2RL7NnJ1l/05fNjzItgU1mJ+U5SLvDcCG3AiW3T260IMHJz83nWMQMmI+il/w2+29
	 LbCRe4s5v4bgbRdID5cI5FM/fpGLc1jx1mXF/lIza47e+E3LvzmSu99EA/hMmUUO3+VaH
	 WW0AhuXDJj58Qy1sACFGI3MnP/ONraKGYkpdPPGgzPnvPCnMyVMrqtJGXW5PhHQLP1WPn
	 UK9/oXQ9zkXAtpQ8VeVHPwnZAcc6tgutjTrqKYwcdh2PjdzWdNF6w1+sYuzfQvYBEJwHO
	 tNDbIRkZa6BmpBhyBC5AgxC1+kpKeBo704gGst2XW4k6z/0vK6Nr2vmavn/Pj1qP63w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aojJoltT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F79606A884;
	Tue, 17 Nov 2026 22:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F79606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aojJoltT
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0133C20062C;
	Tue, 17 Nov 2026 23:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MUhm+aLIZKS2wGISTQ6+laWnSTjIlWlWKEMIYweqZo=;
	b=aojJoltTZmR0pBIkpzah54yf2z5mcYDMW0wK6kNuhDTDrl1LliiDOtdl9kFDJ6/GSDr6Cz
	vRZG12/E3CqnbTBWFsOascrIFIAL/Wv0l5in+4rmOvzxTt4RCBLIyyPQhCZAexzTatWFBj
	oUQQ7zEZmR63HJKufFmn8fevBDEkhAMgu296Jbj7glCoq8TM77noago0Tdf/UDvJlKEFP9
	OyXKLu/U6DYOFG1HmlFO5+fIwDNuETdfba+zozbYc0bJXzf/M+smLTRYe5WIGH4BtL1KV4
	H6V+b2kJT+hc3Q2iqA4h9I+ebsLK2j3DSUPkBBsk02+cA2VPyvJ3fP6gBrSYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MUhm+aLIZKS2wGISTQ6+laWnSTjIlWlWKEMIYweqZo=;
	b=NqU72ha0UFIgPh632vHL3iBpd4WUw7mzs7EfqHHRGQIPLeGG04BK8YkZe0yJgTRldnB1sB
	wgJDGcO92DA0OhZJqvUU9I1vySzn7IgCqeggJbgLztpgY5vhJfW6LhiWLnX66MY63fDhR7
	rXgx9LhB10PU2SRI8ILYodC9rmhvmM4fV+LMNC3i+RBFRC89HOVWS1c14lfY4q88t+uaET
	z+UTwa7my2QOrImQ9lLXcND2eC5s9yUoUv2r/j8cW6SYnzOT4RM5nRRWzVno8kK4zgSzYs
	1dUK7x/qSwEqr4zYT7Vbkefq6XOGeNzIvQioufIm8cvWLAwAV+pAifUWs4mv6A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794953328; a=rsa-sha256;
	cv=none;
	b=GfGTu6a6iRfa/GPsILPd562L2Y3l4eMlYvll3vCjhEAqFZj52PcehdXcbWM7SKjtGVKzhM
	Wle7x5RcGQvhlaQF5rasZ0Y1pa3HZmDzlYC4xiBxpXfbB7HQU3uaXQRi4sfuJvUzZDktDz
	Wi7Xj8BW/AvxwtBqyePI61cLtXleQTnfMGf+ybshJCTnQH09tupaj1wW48jUWG5TwbgRsc
	1IuX2hBn0MP2UJMBApxeUdJUjrhKJgIaGnOQZAqB6KA0qWNYSQD7sKEjuzfBmuZa2rYRCE
	uPxndaJBao8gSYIGvj0Ec0Gb+lCWn1A11mJZunuf4RTxKXMcslx/4hvTcIX8QA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTRM7-000FmR-1F;
	Tue, 17 Nov 2026 23:08:47 +0100
Received: from blackshift.org (unknown [192.145.8.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A9A365EDA25;
	Tue, 17 Nov 2026 22:08:40 +0000 (UTC)
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
Subject: [PATCH net 02/11] can: bcm: do not remove the procfs entry in bcm_notify()
Date: Tue, 17 Nov 2026 23:03:07 +0100
Message-ID: <20261117220818.1142581-3-mkl@pengutronix.de>
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

bcm_notify() removes the procfs entry of a CAN_BCM socket that is bound
to a vanishing CAN device with remove_proc_entry() while holding RTNL.
remove_proc_entry() waits for all running readers of this entry. A
reader of /proc/net/can-bcm/<inode> that stalls in its copy to user
space, e.g. on a FUSE backed mapping, therefore blocks RTNL on the
unregistration or namespace change of the bound CAN device.

The entry has been removed in bcm_notify() so that a later
bcm_connect() of the unbound socket can register it again without a
"proc_dir_entry already registered" warning.

The CAN_BCM socket itself stays usable after a NETDEV_UNREGISTER:
bcm_notify() only unbinds it and reports ENODEV, so the application can
connect() the socket again, e.g. to a re-created CAN device. The name
of the procfs entry is the inode number of the socket, which does not
change until the socket is closed.

Keep the procfs entry until bcm_release() instead, which removes it
after the socket has left the notifier list and without holding RTNL.
bcm_connect() only creates the entry, if it does not exist yet.
bcm_proc_show() reports an unbound socket as "unbound" instead of
showing the cleared ifindex as "any".

As bcm_proc_show() can now run while the socket is bound or unbound, it
reads bo->ifindex locklessly with READ_ONCE() and the writers use
WRITE_ONCE(). The NETDEV_DOWN handling in bcm_notify(), which runs
without lock_sock(), reads bo->bound and bo->ifindex with READ_ONCE()
as well. bo->ifindex is still only modified under lock_sock(). A
concurrent bind or unbind may show an intermediate state in the procfs
output, which is acceptable for this debug information.

Fixes: 76fe372ccb81 ("can: bcm: Remove proc entry when dev is unregistered.")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-2-6826a6227d36@hartkopp.net
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Zhu Ling <zhuling0805@qq.com>
Cc: linux-can@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3f4c8d828337..1595b7720c98 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -219,11 +219,16 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	struct net *net = m->private;
 	struct sock *sk = (struct sock *)pde_data(m->file->f_inode);
 	struct bcm_sock *bo = bcm_sk(sk);
+	int ifindex = READ_ONCE(bo->ifindex);
 	struct bcm_op *op;
 
 	seq_printf(m, ">>> sock inode %s", bo->procname);
 	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
-	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
+	if (READ_ONCE(bo->bound))
+		seq_printf(m, " / bound %s",
+			   bcm_proc_getifname(net, ifname, ifindex));
+	else
+		seq_puts(m, " / unbound");
 	seq_printf(m, " <<<\n");
 
 	rcu_read_lock();
@@ -1866,19 +1871,9 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
-#if IS_ENABLED(CONFIG_PROC_FS)
-			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
-				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
-				bo->bcm_proc_read = NULL;
-			}
-#endif
-			/* Paired with the lockless fast-path check in
-			 * bcm_sendmsg(); bo->ifindex itself is only ever
-			 * accessed under lock_sock() so it needs no
-			 * annotation.
-			 */
+			/* pairs with the lockless check in bcm_sendmsg() */
 			WRITE_ONCE(bo->bound, 0);
-			bo->ifindex = 0;
+			WRITE_ONCE(bo->ifindex, 0);
 			notify_enodev = 1;
 		}
 
@@ -1892,7 +1887,8 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 		break;
 
 	case NETDEV_DOWN:
-		if (bo->bound && bo->ifindex == dev->ifindex) {
+		if (READ_ONCE(bo->bound) &&
+		    READ_ONCE(bo->ifindex) == dev->ifindex) {
 			sk->sk_err = ENETDOWN;
 			if (!sock_flag(sk, SOCK_DEAD))
 				sk_error_report(sk);
@@ -2013,7 +2009,7 @@ static int bcm_release(struct socket *sock)
 	/* remove device reference */
 	if (bo->bound) {
 		WRITE_ONCE(bo->bound, 0);
-		bo->ifindex = 0;
+		WRITE_ONCE(bo->ifindex, 0);
 	}
 
 	sock_orphan(sk);
@@ -2060,16 +2056,17 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 			goto fail;
 		}
 
-		bo->ifindex = dev->ifindex;
+		WRITE_ONCE(bo->ifindex, dev->ifindex);
 		dev_put(dev);
 
 	} else {
 		/* no interface reference for ifindex = 0 ('any' CAN device) */
-		bo->ifindex = 0;
+		WRITE_ONCE(bo->ifindex, 0);
 	}
 
 #if IS_ENABLED(CONFIG_PROC_FS)
-	if (net->can.bcmproc_dir) {
+	/* create the procfs entry once, it is removed in bcm_release() */
+	if (net->can.bcmproc_dir && !bo->bcm_proc_read) {
 		/* use unique socket inode number as filename */
 		snprintf(bo->procname, sizeof(bo->procname),
 			 "%llu", sock_i_ino(sk));
-- 
2.53.0


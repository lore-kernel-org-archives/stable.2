Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736673;
	b=bB7WC0Ldiq1MjjrdWRpm8BXdyRSZr9XKOWzkOxphplBak2DLXmXSNpHx5rJNHbZlo+Zv
	 +fZafwEblvVCjfbqVhL3Q1EQNef2FnjNBCIC2NL2JAOMrD8ovoz9C+nFFelF+Cvl3VdJh
	 h5judKPMyt+sxV7QcXlPaOz05ViEq80KdepDB7sOKG1VZYGjldy3wHX7q/ywV0ncbMCRF
	 TosyIRARBLulqd5fqdEoB+oYvVSdSwjZzdmsKY674wp1nDa7L066Io5RrwJlDZN720HC0
	 lemmv+LpMxtNyvApFEvlT9IzpdaERz7hBtBppKwq49hPBT2vMde97xCRf+j72dQ79gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736673;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jasd+7eTfCu8M5HIID8UopD0ImkUg5IwkLLHNVAPX/U=;
	b=tfBZ7yxm0Ii1vm0/MuslThrWIRP7+pxNxZDlqbCVFNPYRZkMUdGwuAM5RwgxV7phbyuU
	 4fIphZC/nFUYihk37FOSX4QRtsNGHAyMN4knt7XK9ZavLhhVhX0YX6TwDp2jQk3jPDI0A
	 larChRb1d6mPnAwGj0PciYHt/R2TjL1xFXVT+V+TN1UNXP2nxPoAB2AIx3kTUVxT1IWNJ
	 H9VKfrK+YgtiPx1A3kcIOoAFO71hus8bBUvv/iKNAZX8qF04blRFZoURVZTTau4TiB0AF
	 QEOT4bHucIUhkjAzaodFRDQD5AlUAatVGnTxujEugU9qyF818g3p+ZbW/aHCKtl9PWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OE7L21AX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EC7606A31D;
	Sun, 15 Nov 2026 09:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68EC7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OE7L21AX
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5FA922059F2;
	Sun, 15 Nov 2026 10:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jasd+7eTfCu8M5HIID8UopD0ImkUg5IwkLLHNVAPX/U=;
	b=OE7L21AXfLKapkD8TcKOm7FjJUpuRZ7PjjRmDiGYUpUt4UaJ9tSmXxwyW/oWyguoi+2VXj
	RCEXFLt+noW4IoNOz4a3siTM3xUrXjZfmAQ8nTncmlAjEF61P44bb9IGU9eVHc12IaMEfX
	0MN806sGQ9C37Hi1iVO+I5TmRm/fD6oQFR/SwtOpLmZtUe4C/tUYjsyqIm6Q+TTNiodjio
	YZZLThTrXgqtSuQH2Yt7EEqnSCS3eBouPOCABNR+twUrpvE17CVg47HHSdek0zhgU35rNM
	tr+xAdKYkB7EmvzOAZ8LoThVFy81VCX2/Dze8dTD74x7oZuJcUgC3DY6L91iNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jasd+7eTfCu8M5HIID8UopD0ImkUg5IwkLLHNVAPX/U=;
	b=Ur7IH2iCFIkFyhz6msxlVBDuR+jnoVFO9VSSwNhozA+ULusbnxXX0Mu9qR8D4ZodC812PY
	mWarZR/397XDQ+JzkXEzakO1JONPuTZCA3wQVQBWwvJIbvoBXwCiBFwwSdHEuH+AuK4MIr
	5X9UKRaO6cKPUKZjV3WL5vJ3b8RstCkQbBT541dxl4C7ONTyAhLKJqituCKWG7qZQ6dELi
	SZgzJlTM6mDncNX2WhVHqJtMudLDX/CMcyNdxLCbfhXLtWN8B9YHLioJ6J3nITlZJtkx/s
	uLfTtoxeQD0hsbUE0ZYhd+mmO0rp5Xq75NBm6y6Dnet7FxiQsOiaykzS9Txx5w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794736670; a=rsa-sha256;
	cv=none;
	b=JFzkMM8n3fkuLEpfoZRJMlArS107VKxywZxBRRXZO0nOUlLruzLCJVdK9nyn5aIxBvxg2S
	QXkQbsNKbUJrviz5r6qZ2ea/9LpcfZgHEc/1Vkxgwa1xYv2x6Ct6hqxbiaYx6lClbaZRmK
	ejo2Lf0Tik3K2Al8FNJudBtpQTtI1VqiWNBv9/G5XJVc7LprxVPZ6b7NvBnUt3W0w3m0aS
	O2eCFlLMhQAjByWi+Kz0D6NubmhNyGnuBHwpjEucptxsxUjZ4PeEElj050Lw8ulO+UBZ9D
	+l0Kk3fcq6o6bAOEzU2n36i+u0Y0xueN8kRrjb4DsuvuUeZ6JrHh/8Y+/FiStA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSWze-004GWH-0q;
	Sun, 15 Nov 2026 10:57:50 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 03D105EC24E;
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
Subject: [PATCH net 2/9] can: bcm: do not remove the procfs entry in bcm_notify()
Date: Sun, 15 Nov 2026 10:54:53 +0100
Message-ID: <20261115095746.709371-3-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261113-can-bcmlock-memcg-v5-2-634c0e04bc72@hartkopp.net
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


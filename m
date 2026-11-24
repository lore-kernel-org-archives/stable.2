Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510687;
	b=ebD39gwHQE0zM3x1ql5bL/h49qXl3HpAdTQOJ+0FgAim+dltUedDZElnT5zkfHy1DteK
	 nduM1I52ER0jnxBMFypivDv48Iw0bRUuPpBJj5h6YhLAzEToDrJIDfNVEV/wi0vwhUjAg
	 juAgUMu4ThIxyXbj8u624Vo56LClmnENUUh0O4VDA4G7GZjfZTnM7/1ogGOEP4vkLJSno
	 tuOrXp/KF1rqymiqRrnwQ96TdldN65A8/T3Xcp1LkQr3Ynod+UuOAXJEmzAoxymOJ6o+q
	 YoFANN3Y6+VIWcR/J8cVr0qav5C+1CydbADGkp0fchOYLdVNvXWvtSyosGkLGKWK0vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510687;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=76uqXxjlsjHRjkNzBtvYUvH+0OqjU/qj/joPKtF1TNo=;
	b=sI774QVXdDqafB8XhnPsmkxc2PZ9ukELxcnnObqeJd0is4A4L264i4tT7kMuOR9ZyeHm
	 CnY6fopYtsRwW0J+lPhrmuxxtz2cnc8B6A1+gMkE9S8c0yv7i2JitKZbQanbQA6GTJbTX
	 Q14lwIHBGX1VCyxqKa/jJfB9TfPydtmUXDHcd2F9i0aadUvfYYOEtL76rNLvfzBt9L8AV
	 KKGjzM69cC0qcM6gqSs+KyQzqUlvxZLfYocFkZ83kF+fmv2QoEWp5KjaIbV5GSSd1xBQw
	 WEe7dMV5qWGf2FZCj/H7Vb9yeGwnRpYYKidUn6SIvP/rU5+11TDR9H52k4eZMyjiErg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Mz3zak1W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4257606A336;
	Tue, 24 Nov 2026 08:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4257606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Mz3zak1W
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 474742024BE;
	Tue, 24 Nov 2026 09:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76uqXxjlsjHRjkNzBtvYUvH+0OqjU/qj/joPKtF1TNo=;
	b=Mz3zak1WmUOJNiDzAQzo7oZHpYFQyFse3oZ+X035R6aX394itf+tbxF7G7NKLmYUI2FVqe
	S/xZvDszRbBOHd2+M0qbUdZ26oAXFEkz28d8aI0omZSGYcux83Gx68ss6//ZPKku/I1ySj
	b8fgtHuzlw0xskgxjLYOkaqjXZZDTpr+DZPSx/SmjCtJAyI3uJp1yiBBQ4RAbQVijEKKw2
	6GIPEzHxCI4SbxZ2VjqnTycrVJhuFWpRLvTW/uAhpyaLJ0040AY1sJddqfPW2oWm03EnnW
	1VSFwgy9DlB5UoxPheNpma6w4sdeqBG/cf6aD3hNmJ2wsMuoFJhEMqH1ocTdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76uqXxjlsjHRjkNzBtvYUvH+0OqjU/qj/joPKtF1TNo=;
	b=V2MTHbbnk08tabwbyd1ZUyNsfmtpLRdjPSfGO1vgr7PzN1IQqSuVpDPNIVal1IegHEq8Jx
	EPd9kUggF5X8cnEri2qFknHdp5/X3Ftyic7O4lYDIijjLKA6hBU/VGNjY6KCcYap+2+/vg
	oAWhnV987at1W4ZoUU0ID0MDsZsTpdVCEU7Er/XSlm6VZYwp9RaEvo22FfT7N6rRIkIYuS
	Jarc7sKNhQ+UzHZwOFYtb+hXwDlkfsAx3esK/Gm5J1HMkZDZFzEmgMQ6tzFnR30+6FqGvi
	dLIEqUDELxRscfCzC7uSrBt7Yjjk1b5fSQ0SD1DoFwzXIjYZRcUDuYuM/Ttj0Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510685; a=rsa-sha256;
	cv=none;
	b=B7gxxw21EyH9/4UPh0tfSXRoPZ58xOwRxD7vsUJ/TQ0AKs/ihP4z9wkFKtU6ipg6Vr5S+O
	9OYtim7xIGFx+xoQAkGNDrsEkdanIQhAfxoJdaf8rWPDrQ3IjWVyxbj+z9G84wdfVK8S1D
	2JZgLrdRD6mgFgRcKqecQkry4api1yWqTOtyiDRXKqBZ5qb1nrSZIeH4Hha4Gn0mQzJFO8
	dLmj0vLyaIanB1rgaedWF1C7wiVODkjdv5piYfuUH5A++2swavRUYgUQfnPDtA/iz1C3LE
	A6FPe8AQAzgZ92LTm94UXnMXG0cVSdVHnk4n7yTl/my31iSlLzh59XYXk+W5rw==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 02/12] can: bcm: do not remove the procfs entry in bcm_notify()
Date: Tue, 24 Nov 2026 09:51:29 +0100
Message-ID: <20261124085757.1093632-3-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261120-can-bcmlock-memcg-v7-2-f6b84f5257b1@hartkopp.net
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


Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04304FE2D0;
	Mon, 28 Sep 2026 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624004; cv=pass; b=Wn0rjSeTymkisv0iLWwBv9Vrbpi+6+vCG2qWYAZYSN2WkseyJAuas37N+FogqVO1/OnqIt+fI7Df1JwdFzhB37MVYyyeAvrQUUI2w4b8RpzVigarq0eyI0MhMCyHmm6vEtUuhds94x6ykM34MFDdK6RsFgu/uoJlKcLawKeyKlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624004; c=relaxed/simple;
	bh=Qq+Ycq3EIdCyP7fRRmpcFsVOd3QQV3bqGdlZRSjk2Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLnc2/DvQSr+YjF5/lxRwjAlqhbV5mIxMviPPW9ltDDxl7/F8TsuVT0JbEeNARxRUOxkvTrW/cHFDlPMVJ4UFO1PgPAyUT8Us43Zzqk8R9Z9xm/fsyv3krIGxjVACbZVB9Q2aUOgHB+o63flo61/SbrGX49qPH1I5Zh1j9jmRgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=OTnrTIEW; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="OTnrTIEW"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D01D5201F2F;
	Mon, 28 Sep 2026 21:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U12IRhUVqyc9ePFqFC43WEcFbnA/BEO9QQoiF0/4eZo=;
	b=OTnrTIEWFKo09ClvkaBPru6BB94ZbZCmHNZ/K+XFt1Da1nMgMd6WHyO0R8x+AtT0z7EZur
	3LX4gEHJzR5WqfkHdlFLriLzeWywAsfkUFKC4OpGT1sBZV+zcT5XCJAt4JSe+GmcTV3FUR
	SujXxUILPJnBDVZEQrAi2nPELXpzOWEqPtiAmMvEwk7CeLmjS4TuG62a3w47ijUuiAErm1
	x7dA9FOSrOHUwpeBC2/OOidgJj4uHqyZkQ21I8JYqFWs68DF9AYIvfoDN3GDOQbhgwoCjn
	sodE0Rd3ZWIx4UHAVprDPAf5mutwRUlwnCT5hgIB6l07xq92iXrI3ovoLH9mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U12IRhUVqyc9ePFqFC43WEcFbnA/BEO9QQoiF0/4eZo=;
	b=OZCNkqRnJ6H3DDpj4YraiJ6z8Y9AkgC5N1K1aTRANHKuX10WzWifB7na1I5DbBIKfRnUHi
	I9Su/+vHfCZDhDwmUxbgYuVk5NZZMhidLCdY6B3Nfkr0BX+huOtnm7/Qiw7Etl5N6OjNuQ
	psTWwgnLBAZ4M91OM0laoID6Ir/mJBbjKAKbMaQXdw6impq9h4RZGK/E7E69bhCIAhns7T
	yCK9RxO3IFxcGcIvPOJ20cqln5T3lOl+lcgyc+hK5eZoNPsG6OrJ4I+S9VD63hghlGDxy9
	jnxEdtLPIR5dEXP5ZhW6wO1xSk6x4rB9QLzUmh7FajFhA0txxlDXErSDrkCKbA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623995; a=rsa-sha256;
	cv=none;
	b=VTNNQTIn4iMy5JDlZk38LuNw3A5cD8SxxyAx0V+ujJB5FAqJcuTdMoMFALDjZ343xdhjrt
	GGC+BSv9Txls2hHr50fsjFkq2SEHD5hLlhzamogWD92UG/zi1kJTMna2/OGEKFxIcywcyU
	+NJ7sJdYj7U1ylIJkvHBuuALNDw6cmtR8QSvhc6Ei27po6pHmBdZeRxSMJMgDkyDBVkuTq
	BMoM+M5T36+nlkLk+s5LJWCgyXNlAhp9eH77QfWFwYy/IMttPOFXacs3CLYe0SJXfeVrMA
	m/JDLRlZa2GvA02CU5QBJsfgVyR/sM48BQdHpHXTYzMsqa4lfqotkEMpSvuKhg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H60-20;
	Mon, 28 Sep 2026 21:33:15 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 614A75B154D;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when re-bind failed
Date: Mon, 28 Sep 2026 20:45:13 +0200
Message-ID: <20260928193312.553632-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

syzbot is reporting "struct j1939_ecu" refcount leak, which occurs when
netdev_hold() is called during ECU creation but the corresponding
netdev_put() is never executed because the parent "struct j1939_ecu"
object is leaked.

  unregister_netdevice: waiting for vxcan1 to become free. Usage count = 3
  ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
       netdev_hold include/linux/netdevice.h:4525 [inline]
       j1939_ecu_create_locked+0x1c9/0x400 net/can/j1939/bus.c:159
       j1939_local_ecu_get+0xeb/0x220 net/can/j1939/bus.c:293
       j1939_sk_bind+0x70a/0xc60 net/can/j1939/socket.c:529
       __sys_bind_socket net/socket.c:1920 [inline]
       __sys_bind+0x2e3/0x410 net/socket.c:1951
       __do_sys_bind net/socket.c:1956 [inline]
       __se_sys_bind net/socket.c:1954 [inline]
       __x64_sys_bind+0x7a/0x90 net/socket.c:1954
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

  ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
       netdev_hold include/linux/netdevice.h:4525 [inline]
       j1939_priv_create net/can/j1939/main.c:140 [inline]
       j1939_netdev_start+0x387/0xb20 net/can/j1939/main.c:268
       j1939_sk_bind+0x946/0xc60 net/can/j1939/socket.c:506
       __sys_bind_socket net/socket.c:1920 [inline]
       __sys_bind+0x2e3/0x410 net/socket.c:1951
       __do_sys_bind net/socket.c:1956 [inline]
       __se_sys_bind net/socket.c:1954 [inline]
       __x64_sys_bind+0x7a/0x90 net/socket.c:1954
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause lies in the error handling of j1939_sk_bind() during a
re-bind operation (binding an already bound socket to the same interface).
Currently, the function prematurely drops the old ECU references by calling
j1939_local_ecu_put() before verifying whether the new configuration can be
successfully acquired via j1939_local_ecu_get().

If j1939_local_ecu_get() subsequently fails, the function unconditionally
calls j1939_netdev_stop() and clears jsk->priv. This leaves the socket in a
half-broken state where the old ECU's refcount has already been decremented
incompletely, but the socket destruct pathway (j1939_sk_sock_destruct) can
no longer perform proper cleanup because jsk->priv is NULL. As a result,
the old "struct j1939_ecu" remains orphaned on the priv->ecus list,
permanently leaking both the ECU object and the net_device reference held
inside it.

Fix this by deferring the removal and release of the old ECU references
until after j1939_local_ecu_get() has successfully acquired the new
resources. As a side effect of this change, the socket's state no longer
changes when the re-bind operation failed.

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Assisted-by: Gemini-Pro
Fixes: f214744c8a27 ("can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/deb3ac27-5eaf-406a-9bf4-733cc43ecaba@I-love.SAKURA.ne.jp
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/socket.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4..24efb25c58c3 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -450,6 +450,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 	struct sock *sk;
 	struct net *net;
 	int ret = 0;
+	bool was_bound;
 
 	ret = j1939_sk_sanity_check(addr, len);
 	if (ret)
@@ -462,7 +463,8 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 	net = sock_net(sk);
 
 	/* Already bound to an interface? */
-	if (jsk->state & J1939_SOCK_BOUND) {
+	was_bound = (jsk->state & J1939_SOCK_BOUND);
+	if (was_bound) {
 		/* A re-bind() to a different interface is not
 		 * supported.
 		 */
@@ -470,10 +472,6 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 			ret = -EINVAL;
 			goto out_release_sock;
 		}
-
-		/* drop old references */
-		j1939_jsk_del(priv, jsk);
-		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
 	} else {
 		struct can_ml_priv *can_ml;
 		struct net_device *ndev;
@@ -519,22 +517,31 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 		jsk->priv = priv;
 	}
 
+	/* get new references without dropping old references */
+	ret = j1939_local_ecu_get(priv, addr->can_addr.j1939.name, addr->can_addr.j1939.addr);
+	if (ret) {
+		/* nothing to undo if re-bind() failed */
+		if (!was_bound) {
+			j1939_netdev_stop(priv);
+			jsk->priv = NULL;
+			synchronize_rcu();
+			j1939_priv_put(priv);
+		}
+		goto out_release_sock;
+	}
+
+	/* drop old references after re-bind() succeeded */
+	if (was_bound) {
+		j1939_jsk_del(priv, jsk);
+		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
+	}
+
 	/* set default transmit pgn */
 	if (j1939_pgn_is_valid(addr->can_addr.j1939.pgn))
 		jsk->pgn_rx_filter = addr->can_addr.j1939.pgn;
 	jsk->addr.src_name = addr->can_addr.j1939.name;
 	jsk->addr.sa = addr->can_addr.j1939.addr;
 
-	/* get new references */
-	ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
-	if (ret) {
-		j1939_netdev_stop(priv);
-		jsk->priv = NULL;
-		synchronize_rcu();
-		j1939_priv_put(priv);
-		goto out_release_sock;
-	}
-
 	j1939_jsk_add(priv, jsk);
 
  out_release_sock: /* fall through */
-- 
2.53.0


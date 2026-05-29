Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C636C5BB
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096917; cv=none; b=LXjnDtuKXs6WrgBp5COqA0uwaqn1BuPacGE8OMI4zHUJo55tfaxgnbZLt94gOYivxdAhHiR8JMHNQDcC+1iwsTZ1xpN/3ooL3/SN0+/2Jj6d+NbH+26lY528/kFu+iZrslQhK4n+UvIbyZztySuM3BA0wpETwumCbZRdB8Yofks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096917; c=relaxed/simple;
	bh=IUrztKbaCTRHEQfB7V0hMOUH3EZxsR1FTWwyxHtTJbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0bqvQzmo9zdp/FUZ2TN3p6VUotHR8pQ/kTRnE2MviqrsjSoQAwG31A3f8aT639EcCEpLikVfRvQBhjTZBNbEUJCySl5LIv8oiskxA1hK9z9jzXDgfJRTvK/118Sz1kUFEtbAXhxC57t5g9+FNaT4o+Un2FqWzJ/fErOVefh4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQJAS5e8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQJAS5e8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8741E1F00893;
	Fri, 29 May 2026 23:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096915;
	bh=d3AKB8Y0xRchlZijHA3YeVThfTMMZJWux+b5dpI0n5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQJAS5e8Drv1oGAj4B0PIETUPNjzE3SnG9TO+Y/hdu7OJ8m3rVQ4Iphj4cuCUEQte
	 VXYQwWRycb8g+6G8thEjBFxcaw/V4bRju4pt7iUFOEf3qMXF3rHMO4v9PA1CJrBnDl
	 p5itUAx2TB06DJwD0KZuKU3Fn8Ld6Lb25yuDz/bmPoazfjIP2Uy1QCHooBLdMAfVHD
	 5LfyRq/3VVcmK5M0naOe7RZJcKKUpuTOkyQyk1UylosbmID4fKcv51kJpnUGS+L1Bh
	 vgGSNj5YigA1OkRunZxsztlrVmNOZfeC5vMsSnMhWplboY+VKsSB06n7yBvfCdJpTz
	 Yx0WKbjnV6J7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] Bluetooth: Init sk_peer_* on bt_sock_alloc
Date: Fri, 29 May 2026 19:21:52 -0400
Message-ID: <20260529232154.1873470-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052841-railing-periscope-eaaf@gregkh>
References: <2026052841-railing-periscope-eaaf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 464c702fb9374ff8f3f816f24fb7ac719dd20e1e ]

This makes sure peer information is always available via sock when using
bt_sock_alloc.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: e83f5e24da74 ("Bluetooth: serialize accept_q access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/af_bluetooth.c | 24 ++++++++++++++++++++++++
 net/bluetooth/hidp/sock.c    | 10 +---------
 net/bluetooth/l2cap_sock.c   | 19 -------------------
 3 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 7960fd514e5a8..f4ea70981410d 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -157,6 +157,14 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
 
+	/* Init peer information so it can be properly monitored */
+	if (!kern) {
+		spin_lock(&sk->sk_peer_lock);
+		sk->sk_peer_pid  = get_pid(task_tgid(current));
+		sk->sk_peer_cred = get_current_cred();
+		spin_unlock(&sk->sk_peer_lock);
+	}
+
 	return sk;
 }
 EXPORT_SYMBOL(bt_sock_alloc);
@@ -201,6 +209,9 @@ EXPORT_SYMBOL(bt_sock_linked);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
+	const struct cred *old_cred;
+	struct pid *old_pid;
+
 	BT_DBG("parent %p, sk %p", parent, sk);
 
 	sock_hold(sk);
@@ -213,6 +224,19 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
 
+	/* Copy credentials from parent since for incoming connections the
+	 * socket is allocated by the kernel.
+	 */
+	spin_lock(&sk->sk_peer_lock);
+	old_pid = sk->sk_peer_pid;
+	old_cred = sk->sk_peer_cred;
+	sk->sk_peer_pid = get_pid(parent->sk_peer_pid);
+	sk->sk_peer_cred = get_cred(parent->sk_peer_cred);
+	spin_unlock(&sk->sk_peer_lock);
+
+	put_pid(old_pid);
+	put_cred(old_cred);
+
 	if (bh)
 		bh_unlock_sock(sk);
 	else
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 369ed92dac997..c93aaeb3a3fad 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -256,21 +256,13 @@ static int hidp_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &hidp_proto, kern);
+	sk = bt_sock_alloc(net, sock, &hidp_proto, protocol, GFP_ATOMIC, kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
 	sock->ops = &hidp_sock_ops;
-
 	sock->state = SS_UNCONNECTED;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-	sk->sk_state	= BT_OPEN;
-
 	bt_sock_link(&hidp_sk_list, sk);
 
 	return 0;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a054cc2d05b69..b449b6146283e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -178,21 +178,6 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	return err;
 }
 
-static void l2cap_sock_init_pid(struct sock *sk)
-{
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-
-	/* Only L2CAP_MODE_EXT_FLOWCTL ever need to access the PID in order to
-	 * group the channels being requested.
-	 */
-	if (chan->mode != L2CAP_MODE_EXT_FLOWCTL)
-		return;
-
-	spin_lock(&sk->sk_peer_lock);
-	sk->sk_peer_pid = get_pid(task_tgid(current));
-	spin_unlock(&sk->sk_peer_lock);
-}
-
 static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 			      int alen, int flags)
 {
@@ -268,8 +253,6 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
-	l2cap_sock_init_pid(sk);
-
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
@@ -325,8 +308,6 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	l2cap_sock_init_pid(sk);
-
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 
-- 
2.53.0


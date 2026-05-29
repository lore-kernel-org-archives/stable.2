Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239EF33D6F7
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098808; cv=none; b=mJF4GJpeYr4aFyKtvFW/FQmBL5/CHR2LV3yCIgOMkML9BveGPXS2kgFBS+FzcMsi+mgMG5Z5qn9gqH1QELruGI9Dhb8vjdBRjpkBnA7fh7Qs21gMEb8Zr4Qnbvh0zyXA5L5uYR3RvReXFHbiVV/Z+iX84Gi/GsEEXw/Lc/lT9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098808; c=relaxed/simple;
	bh=T5wUneGGVxoBu6pcp0I+uhYPIWpELGz2TOVyQgmvWqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK0N50OkI2UD0Lssk1fYCZsIJ6e07JJInqiv5kgc9TVWl4pA/UOXW9ljlNq5RKNCtmDyDMpr7MzQxPowOwbxD1sIVD8S+VaK0vnprOOtPVsIM37vKp+c6JwrjT0+GIg7OrWiLCQr7w6ebvGRTWlOS7w8Z61h/Zf6sQXC0gBtieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E39v5XEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E39v5XEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872FA1F00899;
	Fri, 29 May 2026 23:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098806;
	bh=Lw3E5twYQwCok+ahN8I2VSC8dkXGc2+GWd0ir96sfmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E39v5XEaqdidHYpTF2BC4OTmnropnMWZ5rAVpJw6x35kEDNElDMbomHfxMKPZ0+2c
	 m/W/ctIQuwP0LHSvY00Fk0Dtz1wC3IuG+nD0jJwq9atb7FFWhbIrBGxiY1PRULmbpR
	 JGdDyJ+hApv9fogtdtBJZ+FjwTn6FaCDZFtJOCth+ymV9C1U3EwQmNm9NWLJXimdHp
	 WSpwBaI3KnW6Wlz/HbPkaDWlNgRaxWQ6Yp0tfTqmacRohu/DbW+gF65UqyuRDih8Bw
	 15rCA00nGTg7psrj/YVfeaZtIB0sNKLotJAn71f3r3Dax5oUUhV0LguKu0JKl8nBXx
	 C8nukshLzgpJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] Bluetooth: Init sk_peer_* on bt_sock_alloc
Date: Fri, 29 May 2026 19:53:22 -0400
Message-ID: <20260529235323.1964735-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529235323.1964735-1-sashal@kernel.org>
References: <2026052843-prankish-sharpener-ccb5@gregkh>
 <20260529235323.1964735-1-sashal@kernel.org>
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
index b1d9b75c64853..67c5384f35a18 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -155,6 +155,14 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
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
@@ -177,6 +185,9 @@ EXPORT_SYMBOL(bt_sock_unlink);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
+	const struct cred *old_cred;
+	struct pid *old_pid;
+
 	BT_DBG("parent %p, sk %p", parent, sk);
 
 	sock_hold(sk);
@@ -189,6 +200,19 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
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
index 595fb3c9d6c36..19c932673bf14 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -255,21 +255,13 @@ static int hidp_sock_create(struct net *net, struct socket *sock, int protocol,
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
index 8df09c084411c..c3deae37f5853 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -177,21 +177,6 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
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
@@ -267,8 +252,6 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
-	l2cap_sock_init_pid(sk);
-
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
@@ -324,8 +307,6 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	l2cap_sock_init_pid(sk);
-
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 
-- 
2.53.0


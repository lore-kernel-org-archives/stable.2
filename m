Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C440330D23
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098807; cv=none; b=OCtaYWzDwYOFJunEy+PEvAmPBILioTdO55a1Oq5twUScl2bLBcxq4WJ3OoEF8FGQZqXodqwGpWy5UbGDymM/pDHqybAqjDXgR01soH2rHDorCER+Zfz9kzQy7XLuJbfHKrMfqo0JY7R0Sue/fD3uqOT+ilQdb0dhVMW826Ns3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098807; c=relaxed/simple;
	bh=byzE8Ilqdd5Ep0AhWlZVWZRyOhnr+k8HAxTraS7WR4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD1BGXv8BrziNWDwSJvVz1llYOqlzyp2hz+wuxT8kWNDZadhZdO13HchpqGVqYWeVpi4MpGvkjD0ISJ7lSP01Mb0KLrPc2u+2t/ypogdtxBO1qPaJC5IJCHLj1YQnK5zAiyS4VlWujNxC7qpi1j2oBX7YsmzGW5eH1AMD7UayuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6dnQqNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6dnQqNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ED41F00893;
	Fri, 29 May 2026 23:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098806;
	bh=1xV0rfNC6oz1s4lBjC2cp7d1JfmvwKVq/d4sQOEQUiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E6dnQqNEOgm2sr4iPyDXADYLoeZI5EE9K756JmqBCDVcs4Yt03XatO6/wTbrOlsSq
	 pbngsFYz+aGMRYvhfu+0KTxfSO5wD66Z/JeKWOJKrQVhJpSfGSkRup2L32UGzmey87
	 GijJDkEzBO7SOEhs+3bttcP7N0UwUGhmS3yLvfZEHSrSn42bDmnEeYODxhkkiXkl0c
	 4Ki5YOPPyPmcFvxHaHPLa1y1dvezyysi5+/EfuRnYPA7PDcS6XsyBAONrrypo+8VNK
	 1rx/w4UwGOCG+Gl9v35AKuysZmQ0uU/eTzLgXsBaAgq98tq5JatPZZ4/Trfo3yfo7i
	 XWOzORK2OfvFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] Bluetooth: Consolidate code around sk_alloc into a helper function
Date: Fri, 29 May 2026 19:53:21 -0400
Message-ID: <20260529235323.1964735-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052843-prankish-sharpener-ccb5@gregkh>
References: <2026052843-prankish-sharpener-ccb5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 6bfa273e533d7b25eee3d74e28a7fe8e6a8e7a93 ]

This consolidates code around sk_alloc into bt_sock_alloc which does
take care of common initialization.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: e83f5e24da74 ("Bluetooth: serialize accept_q access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/bluetooth.h |  2 ++
 net/bluetooth/af_bluetooth.c      | 21 +++++++++++++++++++++
 net/bluetooth/bnep/sock.c         | 10 +---------
 net/bluetooth/hci_sock.c          | 10 ++--------
 net/bluetooth/l2cap_sock.c        | 10 +---------
 net/bluetooth/rfcomm/sock.c       | 13 +++----------
 net/bluetooth/sco.c               | 10 +---------
 7 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7d2bd562da4be..fa37bdd00fa5b 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -314,6 +314,8 @@ int  bt_sock_register(int proto, const struct net_proto_family *ops);
 void bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
+struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
+			   struct proto *prot, int proto, gfp_t prio, int kern);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 0b8400bda73d6..b1d9b75c64853 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -138,6 +138,27 @@ static int bt_sock_create(struct net *net, struct socket *sock, int proto,
 	return err;
 }
 
+struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
+			   struct proto *prot, int proto, gfp_t prio, int kern)
+{
+	struct sock *sk;
+
+	sk = sk_alloc(net, PF_BLUETOOTH, prio, prot, kern);
+	if (!sk)
+		return NULL;
+
+	sock_init_data(sock, sk);
+	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
+
+	sock_reset_flag(sk, SOCK_ZAPPED);
+
+	sk->sk_protocol = proto;
+	sk->sk_state    = BT_OPEN;
+
+	return sk;
+}
+EXPORT_SYMBOL(bt_sock_alloc);
+
 void bt_sock_link(struct bt_sock_list *l, struct sock *sk)
 {
 	write_lock(&l->lock);
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index d515571b2afba..59762d82761c7 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -204,21 +204,13 @@ static int bnep_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &bnep_proto, kern);
+	sk = bt_sock_alloc(net, sock, &bnep_proto, protocol, GFP_ATOMIC, kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
 	sock->ops = &bnep_sock_ops;
-
 	sock->state = SS_UNCONNECTED;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-	sk->sk_state	= BT_OPEN;
-
 	bt_sock_link(&bnep_sk_list, sk);
 	return 0;
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 04db39f67c90e..78c583dd64a6f 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2091,18 +2091,12 @@ static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &hci_sock_ops;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &hci_sk_proto, kern);
+	sk = bt_sock_alloc(net, sock, &hci_sk_proto, protocol, GFP_ATOMIC,
+			   kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-
 	sock->state = SS_UNCONNECTED;
-	sk->sk_state = BT_OPEN;
 	sk->sk_destruct = hci_sock_destruct;
 
 	bt_sock_link(&hci_sk_list, sk);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9e071db3b649f..8df09c084411c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1855,21 +1855,13 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	struct sock *sk;
 	struct l2cap_chan *chan;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &l2cap_proto, kern);
+	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state = BT_OPEN;
-
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 2dcb70f49a68a..977c522404658 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -268,18 +268,16 @@ static struct proto rfcomm_proto = {
 	.obj_size	= sizeof(struct rfcomm_pinfo)
 };
 
-static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio, int kern)
+static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
+				      int proto, gfp_t prio, int kern)
 {
 	struct rfcomm_dlc *d;
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &rfcomm_proto, kern);
+	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	d = rfcomm_dlc_alloc(prio);
 	if (!d) {
 		sk_free(sk);
@@ -298,11 +296,6 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock, int
 	sk->sk_sndbuf = RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10;
 	sk->sk_rcvbuf = RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state    = BT_OPEN;
-
 	bt_sock_link(&rfcomm_sk_list, sk);
 
 	BT_DBG("sk %p", sk);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ce084a184a1cd..cfaaaa7344cf3 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -489,21 +489,13 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 {
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &sco_proto, kern);
+	sk = bt_sock_alloc(net, sock, &sco_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	sk->sk_destruct = sco_sock_destruct;
 	sk->sk_sndtimeo = SCO_CONN_TIMEOUT;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state    = BT_OPEN;
-
 	sco_pi(sk)->setting = BT_VOICE_CVSD_16BIT;
 
 	bt_sock_link(&sco_sk_list, sk);
-- 
2.53.0


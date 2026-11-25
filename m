Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566168;
	b=EwxxRGl3hfFj/KXiNuAsAPDTpbjU5Z10mMHIhmrwDxb7YFLU5yohA+q4mcGWtC8YPqsV
	 MVGIbgmeBX4uJrq5tL5pFqTOaexzodyQbDeN+2O0MoiGLYlLM9XiM5mDIPUzIuUoL3TtS
	 1igLw8K3+/dehtCtvl+zQZvF+dOUAYVfNyn3atoMHnNprl10xo/OCN6/wKO8k2zDuZHer
	 4HLTqpBn5Rcfoqh+8uyIS1Ca6WhaDKRq6NUy8LXZ+QkCN28hgQXfmLsYBSlqB0LARDDA5
	 86EYF9XU98B3WvGCP3o9ghFEAr82+qFk5mIO8mnymFzKUmfRqKXgq6xBXdEguKUCwyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fFHXo58/fNBdfaSZCGyJqa/5U7TOcz5+BW067Fe/1IU=;
	b=3uJ2PNWkj5PLdI6FDGlg7RE2J8KoAZjyyzl14hztE87/QZUMipsM4SqVDh/zls7vEGnk
	 pANMV8Eq4fXp7bvTKd80ai9++fNhArjbgFqyJ9a0YrLVic9MSE5424QGvCj5CPWIYtQBC
	 dNMIPybnKRfL2a+hoDbj0+9EkoBo6owS69kY7STlYH+6W2nPYpvH+TPT9UOVLBJQfehMl
	 l4HKH9VDbYP/MejfDemEXgPbLsxncJHKoj59oQQ8Q5cwcr8ZVkMKKOcfTsxzeTL+jDYE6
	 YWr1gTpjKDM+29kFBJIfkYVbLgciyxPCnt11aoVAlfOfr681Y9ZSyYO9Q3odyLRxs3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Q84vMVwo;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA50606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA50606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Q84vMVwo
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so44565905e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1795566166; x=1796170966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fFHXo58/fNBdfaSZCGyJqa/5U7TOcz5+BW067Fe/1IU=;
        b=Q84vMVwoDZNQgAzJNZlilxcv/iQ1Cb0dv+hHwqGihFxDMueuznGGRUB2dCzO2eaxKJ
         7z8J8NltHhMnbgeRlqLj+XMxqPynj9OdOgEN+34A5kLCaFVUXpqqKPTmD0Drwk9qdwsz
         a35Xe6Vi/fpJmRZpA4mWfUJ4J1iWLqi8doVmg2yj4bHGOtZRmu/gk+mQqz1Dfo5Zm3JK
         46XZMqAHy2ls6Q+BR+PxLtPe2WUnXCUt0EDQj7N439y7sST1rd5TWzJeQrbw/7ZnuZZ1
         uFKHJvLX2jSFgVVlbE0MtrxT/1Cy/3o9h9c23pXwbW8SJArZkS8wnnGFyFmEz/o93V/N
         /dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566166; x=1796170966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fFHXo58/fNBdfaSZCGyJqa/5U7TOcz5+BW067Fe/1IU=;
        b=uPt3BLHmppyADT2CyhqgS6Qh9vOpL9MYeBBE19/NeqxgjQ0SWDOxMvAJTkcvOVqMT5
         SnTmQpdJsB6zGtMbUyykrkijvrpjYqNhBWJCHlROmsd8fEeOdVSVsYjgT9cmV4cY4A9D
         garO0V8BM+/O+Mm1zSP1DUIAMsZs3u68thg45YTY13w8QAFHGmjaGOK+auJXyOVa1Xlw
         p+uJIf/TDDX9t4maPjCuFoAWMSGaNoqhK3wDIbMow2rnJOFp2h8/i+v+IcK4QGI2n9hK
         3pGhGwr96PTDEr/KRCBb/ZZNAI1etVhh0jwKfoM/fOExaTmNRbniKlfyvbP1ZD1i8JrL
         NEDA==
X-Forwarded-Encrypted: i=1; AL+hErGjMXIRl5B+qGbaWo1PiBIMgPF43eMfa4oHqCWe4CiLOo2VX8p2q5tkkU7/kUzGGaj7T3y3Q5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vewew9ctyZlcv76HzZagbBhBj/Gwpr7PUQ02KOQc4dfOKyFe8
	Mea6slws5SnFme7vb28pgoO9qI0T0QJEpMCbGm8HpV0PRxZdWX9syOQA/SKCv7YuHoq7a9WvI74
	JJyDKe0iJBTZ7XL1uPtLMNHQyQd9M9sA1PRYeT1pLaIs64FeQw1s=
X-Gm-Gg: AZFdTZf3mw17IzI/FwPfjecGl7ckIcA//8uoFr0k8XviK2nmplIpWrnuwJX/wtgUoFS
	5K46C3R7hbiErappmQlHEAnxmfriuXOqDNQiT1NNHqx4rStPpMHYDbpEVKb6ZuO3ArOpz0Tdnf6
	7vQAHCrIBhX3p9gymt0qjIxLTHlPE+Y/Hx6OASXmCMBf3/Vv62XcQkI+UUvxPhaD2nT3UKxwuox
	VqD+gZGM/uNMe6qxkTLMhnxRX4mylJwcqJaRXzWiueG9cRhRdZXcWq7Rz36GhTYsgppqWfTHg5i
	Y+Vm97SV3XGFxcnUQAKcft9S1S8lC66EVN/rWgB6i2na8IeCoeZ/foxHFI8Su7iKoZ5JYmnkBMg
	koQwId6FkFvkadnteY0FqZOvzOAc+mHv0WS2V1/0ZkRH0r++r8AHnl+WwIxQa04Q+BDMRK8Qd7s
	QV3aDHBmBXE6qso/cykPwMC9J3zkz/1cDN83NudQ8P9eTbyl49WSdYMc+WTEQPlwXh0IstukBzb
	LeVZJjqSzF4jxVImj8PhpaERCJwYkgXNfZmiVg9FpSCL+YF2m7AjRHMKyiaW+0A3hPZj9CXRmfa
	vTH+tPKpLgWoHVQavUDLVtj1eDMXCOJBkB1P77foierzBn/N5kfz
X-Received: by 2002:a05:6000:4028:b0:4a6:bc53:246c with SMTP id ffacd0b85a97d-4abb3956374mr33601207f8f.42.1795566166626;
        Tue, 24 Nov 2026 16:22:46 -0800 (PST)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:5c82:5cd3:7bc5:2809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm31518448f8f.16.2026.11.24.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:22:45 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 2/7] ovpn: validate sockets before attaching peer transports
Date: Wed, 25 Nov 2026 01:22:33 +0100
Message-ID: <20261125002239.1191542-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125002239.1191542-1-antonio@openvpn.net>
References: <20261125002239.1191542-1-antonio@openvpn.net>
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

From: Ralf Lici <ralf@mandelbit.com>

ovpn accepts a userspace-provided socket and attaches transport-specific
state to it. The current checks use sk_protocol to select the UDP or TCP
attach path, but sk_protocol alone does not identify the socket layout.
For example, a raw socket can have sk_protocol set to IPPROTO_UDP while
its storage is not a struct udp_sock. Passing such a socket to the UDP
attach path would make ovpn read and write udp_sock fields on the wrong
object, potentially accessing memory beyond the actual socket storage.

Reject sockets unless they are real UDP datagram or TCP stream sockets
before attaching them to ovpn in the peer creation path. This lets
netlink report a clear error before calling the socket attach helper.

Also switch ovpn_socket_new to sk_is_tcp and sk_is_udp, matching the
netlink validation performed before the helper is called. This does not
change the accepted socket types, but makes the helper's assumptions
explicit.

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Cc: stable@vger.kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 15 +++++++++++++--
 drivers/net/ovpn/socket.c  | 16 +++++++++-------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 5432bc2eb8e8..1af7e0e624ba 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -448,10 +448,21 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 		goto peer_release;
 	}
 
+	/* sk_protocol is not enough to determine if this is a real UDP or TCP
+	 * socket
+	 */
+	if (!sk_is_udp(sock->sk) && !sk_is_tcp(sock->sk)) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "socket is not TCP or UDP");
+		sockfd_put(sock);
+		ret = -EOPNOTSUPP;
+		goto peer_release;
+	}
+
 	/* Only when using UDP as transport protocol the remote endpoint
 	 * can be configured so that ovpn knows where to send packets to.
 	 */
-	if (sock->sk->sk_protocol == IPPROTO_UDP &&
+	if (sk_is_udp(sock->sk) &&
 	    !attrs[OVPN_A_PEER_REMOTE_IPV4] &&
 	    !attrs[OVPN_A_PEER_REMOTE_IPV6]) {
 		NL_SET_ERR_MSG_FMT_MOD(info->extack,
@@ -465,7 +476,7 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 	 * will just send bytes over it, without the need to specify a
 	 * destination.
 	 */
-	if (sock->sk->sk_protocol == IPPROTO_TCP &&
+	if (sk_is_tcp(sock->sk) &&
 	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
 	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
 		NL_SET_ERR_MSG_FMT_MOD(info->extack,
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 6cbeb2caaeec..4765f4063b71 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -126,13 +126,15 @@ static int ovpn_socket_attach(struct ovpn_socket *ovpn_sock,
 
 /**
  * ovpn_socket_new - create a new socket and initialize it
- * @sock: the kernel socket to embed
+ * @sock: the kernel socket to embed; must be a real UDP or TCP socket
  * @peer: the peer reachable via this socket
  *
  * Return: an openvpn socket on success or a negative error code otherwise
  */
 struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 {
+	const bool tcp = sk_is_tcp(sock->sk);
+	const bool udp = sk_is_udp(sock->sk);
 	struct ovpn_socket *ovpn_sock;
 	struct sock *sk = sock->sk;
 	int ret;
@@ -142,7 +144,7 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	/* a TCP socket can only be owned by a single peer, therefore there
 	 * can't be any other user
 	 */
-	if (sk->sk_protocol == IPPROTO_TCP && sk->sk_user_data) {
+	if (tcp && sk->sk_user_data) {
 		ovpn_sock = ERR_PTR(-EBUSY);
 		goto sock_release;
 	}
@@ -150,7 +152,7 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	/* a UDP socket can be shared across multiple peers, but we must make
 	 * sure it is not owned by something else
 	 */
-	if (sk->sk_protocol == IPPROTO_UDP) {
+	if (udp) {
 		u8 type = READ_ONCE(udp_sk(sk)->encap_type);
 
 		/* socket owned by other encapsulation module */
@@ -212,11 +214,11 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	/* TCP sockets are per-peer, therefore they are linked to their unique
 	 * peer
 	 */
-	if (sk->sk_protocol == IPPROTO_TCP) {
+	if (tcp) {
 		INIT_WORK(&ovpn_sock->tcp_tx_work, ovpn_tcp_tx_work);
 		ovpn_sock->peer = peer;
 		ovpn_peer_hold(peer);
-	} else if (sk->sk_protocol == IPPROTO_UDP) {
+	} else if (udp) {
 		/* in UDP we only link the ovpn instance since the socket is
 		 * shared among multiple peers
 		 */
@@ -237,9 +239,9 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 
 	ret = ovpn_socket_attach(ovpn_sock, sock, peer);
 	if (ret < 0) {
-		if (sk->sk_protocol == IPPROTO_TCP)
+		if (tcp)
 			ovpn_peer_put(peer);
-		else if (sk->sk_protocol == IPPROTO_UDP)
+		else if (udp)
 			netdev_put(peer->ovpn->dev, &ovpn_sock->dev_tracker);
 
 		sock_put(sk);

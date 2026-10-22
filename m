Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671373;
	b=SID1Id551vJvzjhdmFcfiPbmD5A1m3lbmJbQVfje7sUVZcQ1j4YbhEK/ityDQg/Y4lud
	 WdJXqF3Dyqr0xnezvgZXC9XaKHA0EZgE0Q4Swul6e8jKsgk6/m9iWxSgiPsY263dG/Zyf
	 fA4JLQMNUxrWU43nNHpmdzIsifrL5xNPwtx7Y4EmPmi+bUtjUl0DQXuz9hZPbABa9nXU4
	 GhkyVJSO2p3j0wTaSi5zW9TtusTJYvfYWxXJs2cv7KpmT8y/SZXPx8i3f0ZbATz621T77
	 /gz8L8zaQlhVyguAlGbdpxisWyxnfcgdo0MgCBv4WZHO/0inJ/NF4D41fyUklKlV6OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fFHXo58/fNBdfaSZCGyJqa/5U7TOcz5+BW067Fe/1IU=;
	b=tX36xmUQMB+y6CzZkcRfZF7tJbprJZyJ7eJdhhfU3ESyaJ9+kRnA/m8o/eAtQeAC8HuD
	 Wu1dMpo1dKyzT/wL2PLcklT6HDpjc3mRSCdGiWayYS4peUSkQRhajupdwblfOLFYdDZNX
	 upmVJro4iTdUGeRUQZ93SgLBNXbOFQok4MEzWbwAg4RhwGK28Aji4ASyw7Qmr+nQ3u3kj
	 wFWuOnLdQnc78UDbcgo1nbqDkOynwIOl1+5bVp2lRN382PZaHpJdJ5S8kQTpO4zABMjSO
	 m4EzzL9syDf/Y05kZXH+V0181BOL5ps8UvOAOj0INyW24lRhWNYLkZj1YBb0byoSIaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BnO4WPR0;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B3606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 079B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BnO4WPR0
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso14830405e9.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 05:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792671371; x=1793276171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fFHXo58/fNBdfaSZCGyJqa/5U7TOcz5+BW067Fe/1IU=;
        b=BnO4WPR0V8LXOA1MLZrXECmfO/yobMxQoVDztOeTTD4hFO4bKsCeaKqNBX2n40imJz
         QmG+Ifx2WaSHXw+tDRpjgj6e2G12q/XYTytj3+JE2hI/XsF+SdHAKZkL6WmGQpnnBeEM
         F6FoAL/gXHRe0/gw29z0aaqZr8D6J7Qdzfp05Eovv+6NeXn42ABWtuufdVXkWz6izz4I
         EOyB96IXpjq61ewNxjfs6aqJbwmfjTLXYG7UphRQtTixsBDZvahzeF5uarCBAdx1yb9Y
         vNOFYMjZhch8j6TkQCX9EsvT1WCBaC0TrOJF7dbC98LKUWr1yjZGSgFHwO7c1EUCZ00O
         wcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671371; x=1793276171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fFHXo58/fNBdfaSZCGyJqa/5U7TOcz5+BW067Fe/1IU=;
        b=cGmYHltfw/pffcv4HfsRA+N8QXFLHQ0SnaXg2JGf8ugPvEoprP5gsour1hTOK8c161
         P8XisXb+00+bDtO4Fn40RqKbZhPqGAMcvQ65IT8NwqPqvFfuOIT8iI13INvPjx8adQzo
         +ppL4TntjgvwFWFs9zItwWgPtYpJOCSrHWNaUfsM7uGRwHYxPM+bGS+khPdDJg2utucm
         wA9SvSanblYf49WRPGdiRAQ0Z7oksGU33Xh+C7UbMWdBjvj97/PzEnRUHDV6ts9C3XoG
         1LBIKBLx2llGfKKfW6Zn9RWYUuzZ2TvECCfSF+FvmuFgKZZVlX5IsbzhRRGSRYP3TbP9
         ZSXg==
X-Forwarded-Encrypted: i=1; AKwUvBxNuyDsvMyB0bjIohGVUYF44ed1R8pEmkDUgtWJKg22L5fs1+5rF8kjOPDPQ6Ft4Jsar0hqyb8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvPkI1lO5M1bP8GbBoOKI0CgDZdhbZl6QZ5sRZvMFE0KtPXBsn
	53F9tLc/p3rxLdLrbXc0yqL4EIATx2dqW1an4HnDml2Ppbm3NVUA+mIvllV36tmkwmWEc+VpPVM
	3t10oEMTrUQ8gDOi69aHnNmuBgjzuVIl9xjFOfZ9m8IHk2xURWeE=
X-Gm-Gg: AYBFou288mQN9ky/pEJShqa1G+MYVLXA5zpL+xlE8l9iiO3YX0ycX9Lq999yZgLUnPV
	zdpUhnvRZbDcKQAY0iTri0gZPjubJnTieL5teMtZzuTtnCh1I5o/T8xnceUUX6HclJ0smTOeMeY
	p6d3F/GjAS3W6Q4V0rwQItsYkfO72ta2UOE44C05dq2Xl5KUKqcAgAaS7ntu4s0jvgtlRqDlEwV
	XYfpaRdhxRGfP5+DM8LtwokC9SdOhgPafbFDUmVcO20HE1PUaZ8nuLw++f4hV3FOQkl8DNlFRtY
	5jLPgGpdrAgrNqisTxwOkxn4rWpc6dz3KN4wbkmfNH01ikUht0rmMy8xX8e8Tt6aOAv5t1TnNIh
	7ZcWd3Nn75iwneFDrYl9sAWqlp+J9fsA95Y9lW1zc+1HVxlhFDJvi7tEbO84YWGt5YXXNNu4l71
	RPDi0GPx1wOqWWHMPPX96YgpyPWFMINO4kODH6J37EHToumynI+d4l4JJMqhevN7pidDynzNGRd
	D/jvh35dKQL7bB1723yRzmWh/aXvt8jrZUPk0S57B2vwqL4FIC9ifdAua6/Xcl+1C1W
X-Received: by 2002:a05:600c:34c9:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4a1fdd09bebmr92330915e9.26.1792671371361;
        Thu, 22 Oct 2026 05:16:11 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:8826:77b9:4cd:7631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm112485135e9.3.2026.10.22.05.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:10 -0700 (PDT)
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
Date: Thu, 22 Oct 2026 14:15:45 +0200
Message-ID: <20261022121606.732029-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022121606.732029-1-antonio@openvpn.net>
References: <20261022121606.732029-1-antonio@openvpn.net>
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

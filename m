Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566166;
	b=IC22/a1l3IjsS//Dbj8yMgwsgtA6enKPiHctF1cw6/D1uRGj8K7UAjHrPVWt4m7ew6+7
	 wBiYNXJCP/nNDBvIlN9mnlAMpoCM/NuQjfWRtXVPXZ4EY6pjwx7658paEq0OCjm1wafja
	 +8KsiWHkyIun1xQJ8Oi2sRHcm/YbhMqvVLt59SEClLXhWPlyADhRjHZqlSRn+A6pTjssn
	 cjZUUcFN9qbpylNYxy6VGav1R8y/2bdpex9LqX/SZ4hYKe8Q0EWZG0SjpY9PK/PA2Jxyn
	 9b7FI78LWAdn9u2cYqRwgZuIc4Z+EhU2dnShP7VePb5mio7NVQJCHDJCA2Qxl8OWO0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XLVrPWpZdYfK8bbVplRH9n9tMDBXPdcU0nQFv3cf4Is=;
	b=b1avng/IMAsw0IswaovgQYul/ri43jqgRdK+NlYwJBGyPg36WWluocrY1JlrwTQwyMCR
	 EpdwxFUuSsVewdSrewqEkpGHjKXv1eeFww1CEaoR5USNv5S9oE0R9beBk6uGUq4y7xIUU
	 rSYKx5WIUAI1n0l++l6AV0TUxsyhlS5ZMSiCYJ2tGsSFTNPu9csw5SLgStEB/fLHEDoGA
	 7nZeLgsluwk3DgT3kpH0EuDGaKEMT5mA/z1TOGbe072kb1oDTGNHw6TDgc8zV53goWaEB
	 7myNSOsH0CT3292nVb8RBnAfBAx9ZOumDG+M/IFN3eyxiirEvNGjt9TUF1hr2Kdz0kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bxX0P8vj;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D184606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D184606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bxX0P8vj
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb61185057so33554825e9.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1795566164; x=1796170964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XLVrPWpZdYfK8bbVplRH9n9tMDBXPdcU0nQFv3cf4Is=;
        b=bxX0P8vjHRtdhpu0iJnRfsDK1xvAcJW3cwnJH2f8VelxgBFYIXcgI9XDZYlECnnDbi
         mrzc9EsRdIafx1nUpNNTe1HrP0T5IRM2M2p0GMaCuO4aHDeHBiGUq1OiO4F47jvwk5/Z
         oary00REizxgf6Pw3dROgBQVcW6it2+RTPq8UP23jeJQAbLr18D3jtThBum9EsJoXbR6
         ccH2T49bQonkjIipiMmJLYAgM4gsfSecm82EB2swF9WKJEsqepbpGHZpICjlzmCnA1B/
         PWXhLHeR44CqRHglK8PjpLzwMKlz2l7yIvpkmEzH2n9SCUdUxifPogrv+KORNg9HlO5c
         VxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566164; x=1796170964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XLVrPWpZdYfK8bbVplRH9n9tMDBXPdcU0nQFv3cf4Is=;
        b=MRl5d+3M3qAhJjVMPYZX4bLQrUEzq74US7VN0JEYeEyNGExaTKDyFbN7mUyDhqJf9h
         6MNSFKBFFNDNwBLQdX3AF9gBsxuq5XrJ0DdzKW3tGHtNOX/EseFTg2SeHYllPhPYEtOt
         kuCEv3TPt9R0GWbo3Ssketx1tJ0pj2AI7DOH2Q2JFYHOXbMH1uPKxkBqaaXjfbiN02Mi
         vtJB/hYUENztWzkjYSVrKTrVeRBovpU4hx3wx72Q02KW4eliWunKU+twx227W9LbCUKD
         ollUj3q6Pht4igh8bVz25HPEFWYKoPOW1xVqsym9c40qYopwR5/pe5CyOa/+BkiELsYw
         3urw==
X-Forwarded-Encrypted: i=1; AL+hErEs8lB1khQ11P3m4tEYfNlxFk0nAXYTJofd/DTHajxwdUkOdYc9aUi8UuyfwlfYTS8cCeE4fSs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9G3YckwrnKDXHJzaCAtOk1eTek1o9ThO1RV8/gUPC2xLKSqJVk
	IBJG4c4/lJsv+P5HnUXzOWUuJCSmWG2lRAvxXsVK3vOEIOT5K8Z+nHSb5uPsxS1tB4JXDlK8XIq
	+lkdD1luH8pyzUlMSh64sKKBxrHtwlWrT8Y1ph8Gs0+6zjL0+4DQ=
X-Gm-Gg: AZFdTZdMg/xG59MijuOhALASP5NpT4azYymIyczcQTV9o7KShdHlyqKRsnuS41HDJ19
	HuNCjjai4cu5XI9Ldq4Z//jhIHQD2+gUax/IK+h0VZMoaHm/51kxIF4/earR3My8TJzYt5GtgSD
	7vwZaEZoJcSNQzLu7q3p1/jxfTeFwCTyR0+zjpdvzpp6Ft/iJ+senM3Tnqag9tmnx///gYv4H/u
	G1Dy9tniUQy+yPIviYu/oDLG1b5by65/I0fC5Cqeqwe7V6tiw7Tev3NNR+arTaJGjjbx+oZl+Ll
	v85boMcCfFwl5tFXoXV4t6mTONawAaKmi2wx+Y1G1wi0TmkugG3CYE4EgI3nr3EiZ4Z0cm6h4lD
	QdKIJHrO0FZ4UptenDyqibHJ7E+8R2kplN6RyLMsaAnR2Cu0F3/LsHkB6LIzqAPr6+E3kJtTf02
	2LpNeNInXWTmkfzQpIfQNFeCDL+Gp+wLV4bddIxnmFFxs+2eonEuSHP5j5xfiLrV02W9//dhyRJ
	+ep7rtPHXJfWtltXxDcfKwE3l9H8GlJviZkyqFMa/y4/pZZGQtLXKqyTt28PtrclOndp1sFHinO
	EMKyi0+pmzT5HMKudm3weqKyJG98FcNQZK8unkAITbUbYlV0CsQA
X-Received: by 2002:a05:600c:3b1a:b0:4bb:875b:3d91 with SMTP id 5b1f17b1804b1-4bb88820bfamr343299755e9.30.1795566164426;
        Tue, 24 Nov 2026 16:22:44 -0800 (PST)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:5c82:5cd3:7bc5:2809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm31518448f8f.16.2026.11.24.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:22:44 -0800 (PST)
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
Subject: [PATCH net 1/7] ovpn: avoid sending UDP packets with source port 0
Date: Wed, 25 Nov 2026 01:22:32 +0100
Message-ID: <20261125002239.1191542-2-antonio@openvpn.net>
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

ovpn operates on a userspace-owned UDP socket, which may be manipulated
in various ways by userspace. If the socket is never bound, connected,
or used for communication, it may not have a source port assigned.
Similarly, if the socket was connect()'ed to AF_INET or AF_INET6, it can
be disconnected by connect() with AF_UNSPEC, which resets the source
port unless the socket was explicitly bound.

Since we must not transmit packets with source port 0, gate UDP TX on
the presence of a valid source port and drop packets otherwise. To avoid
ambiguity, sample the current source port once before route lookup and
header build and enforce the check on that value.

Emit a ratelimited warning when this drop path is hit so the broken
socket state is visible. Return local UDP output errors to the common TX
completion path so locally dropped packets are not counted as successful
transport TX and do not refresh the peer keepalive timer.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Cc: stable@vger.kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
[antonio: rebased on top of the ovpn_route_key rework: check the
 key.sport snapshot once in ovpn_udp_send_skb()]
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c  |  4 +++-
 drivers/net/ovpn/udp.c | 24 +++++++++++++++++-------
 drivers/net/ovpn/udp.h |  4 ++--
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index f14eb4e6c46a..402a74a2a27b 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -281,7 +281,9 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	switch (sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
-		ovpn_udp_send_skb(peer, sock->sk, skb);
+		ret = ovpn_udp_send_skb(peer, sock->sk, skb);
+		if (unlikely(ret < 0))
+			goto err_unlock;
 		break;
 	case IPPROTO_TCP:
 		ovpn_tcp_send_skb(peer, sock->sk, skb);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 055cdb1bee13..30c7eb261e7b 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -407,7 +407,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  * @key: route key snapshot used for cache validation and flow lookup
  *
  * rcu_read_lock should be held on entry.
- * On return, the skb is consumed.
+ * On success, the skb is passed to the transport stack and consumed. On
+ * error, ownership remains with the caller.
  *
  * Return: 0 on success or a negative error code otherwise
  */
@@ -455,15 +456,26 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
  * @peer: the destination peer
  * @sk: peer socket
  * @skb: the packet to send
+ *
+ * On success, the skb is passed to the transport stack and consumed. On
+ * error, ownership remains with the caller.
+ *
+ * Return: 0 on success or a negative error code otherwise
  */
-void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
-		       struct sk_buff *skb)
+int ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		      struct sk_buff *skb)
 {
 	struct ovpn_route_key key = {
 		.mark = READ_ONCE(sk->sk_mark),
 		.sport = READ_ONCE(inet_sk(sk)->inet_sport),
 	};
-	int ret;
+
+	/* an uninitialized socket or connect(AF_UNSPEC) can cause this */
+	if (unlikely(!key.sport)) {
+		net_warn_ratelimited("%s: peer %u: UDP source port is 0\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		return -EADDRNOTAVAIL;
+	}
 
 	skb->dev = peer->ovpn->dev;
 	skb->mark = key.mark;
@@ -473,9 +485,7 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 	ovpn_dst_cache_check_key(peer, &peer->dst_cache, &key);
 
 	/* crypto layer -> transport (UDP) */
-	ret = ovpn_udp_output(peer, &peer->dst_cache, sk, skb, &key);
-	if (unlikely(ret < 0))
-		kfree_skb(skb);
+	return ovpn_udp_output(peer, &peer->dst_cache, sk, skb, &key);
 }
 
 static void ovpn_udp_encap_destroy(struct sock *sk)
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index fe26fbe25c5a..5b67112162a5 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -19,7 +19,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 			   struct ovpn_priv *ovpn);
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock);
 
-void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
-		       struct sk_buff *skb);
+int ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		      struct sk_buff *skb);
 
 #endif /* _NET_OVPN_UDP_H_ */

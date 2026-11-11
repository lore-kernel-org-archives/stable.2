Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403058;
	b=zf9FMAjD7HsNiOEJDs+hzD4ZRAZcZL+DceNIkly6j2Y2St2igG2lDpLM1rBrtIUUR9PS
	 qWSNMNIWy7zk+K1qSXBA4G+Ggp+vxOcf/XXfJR3wvGDOagt7LC8sFTzYGgCtTL/iEYn04
	 Tz0uj40d4xjNyCYt8a/LCUjYDhfCbLYOpghsbvWwB972RujWlXYqkDaj/u97roFptnHlh
	 WCFIjxf7GEvjYPPwOucEOD7yiHDOuWF+Dw5LwX3HAUl+c6d/F54qa1RdwfDGtb3EC0ULw
	 2BH7mV/Ke/tvPxwdrsMwQlcSN+o0oPqvOhbWW2se/0RZThrfDAhBYPxTD8kBrFWLA6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403058;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+Se76dUN8+sABjNGkLbBDe88PWvDvtFcqcT6IKxdFoI=;
	b=Hi4QndGUxvsgfZb/ohpQOb7nIyUgkn8pgWi3vnB/Jq55xp+TwpANGO3Fx0vrJWStGPU7
	 cXaNOTnkeAqq9M/TiqPlBRQ+pZ0SLd96oYFLeuKU/iLHBRjDODrJ5H0cjaWTFNERmBKcY
	 0OkATw9tmoH5BP3d14lVpzt7+Xhnflk0yF7ShHLpvp5Jokais3N6PNv2lCHoAdDw43HKZ
	 xPIB6oCRvOSYK1jUoyiHUFXyqFC6KFOiumhQfYl6W5QP9OqtckdiYt1N61V3U2NwAcjtn
	 bWoUV0ODOycHftdZXQkysBjQq1QbgtsOKN3F432FoOyDbvs7eRTqRKMo+XCG0L3D4NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANkSSpzW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0556B606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANkSSpzW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA39A1F00A05;
	Wed, 11 Nov 2026 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403057;
	bh=+Se76dUN8+sABjNGkLbBDe88PWvDvtFcqcT6IKxdFoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ANkSSpzW0tEgjoLhjgt+GESPEr1TE0Xi/zUh60voPdmMN6QxOL9WPsf/926YspnnS
	 VB8M3zkqv648jC8uGnlpGkZEZ0W4cwA/BDSs1+uNdl6uBXb6Reyh6ECIsPxPVeBPLc
	 j/0Vj3AKFnCaDX1T4Kb4D2Q30O8xU3azDqm4t0tmPcTM4q1PqJVDqTU7cMXk7XE9So
	 YnCqeY/aMMGNmyK+8cWwWdJdXm6UhwK082peofbAQE9WAqt4yEgPtToRRaL8VoO6ym
	 AXgo+i9Oqeb+ekCPpFfcOqSN+sSaRJ6V1yfe69GRZwi2P7hTlsk+D5j+P6yuuwIVbd
	 nDCKOmto9OO5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Sashiko <netdev-bot+sashiko@kernel.org>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ipmr, ip6mr: validate packets injected into the register vif on xmit
Date: Wed, 11 Nov 2026 08:17:35 -0500
Message-ID: <20261111131451.1234213-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061229-failed-5.15-aa1799e93f5e@kernel.org>
References: <20261107061229-failed-5.15-aa1799e93f5e@kernel.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit aa1799e93f5ebb973252aec649d84d12d9c7fd1c ]

reg_vif_xmit() passes the packet to ipmr_cache_report() which copies its
IP header into the IGMPMSG_WHOLEPKT report that is queued to the mroute
socket. Nothing guarantees that the packet contains a full IP header, so
when a short packet is injected on the register device (e.g., using
AF_PACKET), the copy reads past the end of the packet and a recvmsg() on
the mroute socket leaks the uninitialized bytes to user space [1].

IPv6 has the same problem [2]. Its reg_vif_xmit() does call
pskb_inet_may_pull(), but the helper keys off skb->protocol and does not
pull anything when the protocol is neither IPv4 nor IPv6.

Fix by dropping packets whose protocol does not match the address family
of the register device or that do not contain a full network header.

[1]
BUG: KMSAN: kernel-infoleak in _copy_to_iter
 raw_recvmsg

Uninit was stored to memory at:
 ipmr_cache_report
 reg_vif_xmit
 packet_sendmsg

Uninit was created at:
 __alloc_skb
 sock_alloc_send_pskb
 packet_sendmsg

Bytes 1-3 of 21 are uninitialized

[2]
BUG: KMSAN: kernel-infoleak in _copy_to_iter
 rawv6_recvmsg

Uninit was stored to memory at:
 ip6mr_cache_report
 reg_vif_xmit
 packet_sendmsg

Uninit was created at:
 __alloc_skb
 sock_alloc_send_pskb
 packet_sendmsg

Bytes 8-23 of 41 are uninitialized

Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz%40nebusec.ai
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/20261025071729.34967-3-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adjusted IPv4 patch context to preserve the existing locking layout around the route lookup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c  | 6 ++++++
 net/ipv6/ip6mr.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index dc33f432e0f0c..10394192e2883 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -502,6 +502,12 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
 	};
 	int err;
 
+	if (skb->protocol != htons(ETH_P_IP) || !pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	err = ipmr_fib_lookup(net, &fl4, &mrt);
 	if (err < 0) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index a793dcd24813e..1781287fb5aed 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -601,7 +601,7 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb,
 		.flowi6_mark	= skb->mark,
 	};
 
-	if (!pskb_inet_may_pull(skb))
+	if (skb->protocol != htons(ETH_P_IPV6) || !pskb_inet_may_pull(skb))
 		goto tx_err;
 
 	if (ip6mr_fib_lookup(net, &fl6, &mrt) < 0)
-- 
2.53.0


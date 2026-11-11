Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372728;
	b=rXdwz24E6uQysoScengSlSMipq7wvZEefGQO51BhRu0I/DctIDAwkHooFnoDO7Dv4Lnl
	 7trw/vNTBC5CbIWEc7JUcjz8cuz2p3ocDAKYfiIui5MzadcuD8/n/jV1qTJZ/DgaK1Ya2
	 wYHXFr5ioKUyRjVoOwFsHhkN/LOejS0+MmbUCdXX+rSvU+OK+Vf/p1eUyaWndLvB5lTJz
	 mC0U5m2EmcPCKWi9W2VaEgJMI3JQBaKUoQhudZr1ElBwywHYWqS/fB8bhUDLMY+FcdPu7
	 VeByoF7ZSOaKYHd8meBrumNTL3nGumZhtWQbdRy7n3DPc3HGHnXsEgZlBfhGC4GCFAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372728;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a/HNXoqWDSZ7Qu81iy1RtmIeTUZdqQ/LIQfn6acZCt4=;
	b=f371eUeR+gyjXMLxenrY+TV6BDJpT2NCk3uvxJjL2KhDrDmksilpIvN6saopYGL4iWA0
	 m/KWZVVOm9Tj2bZJkgXcgXuCR/HiaZFrGD93XzLM5ZIICwbbIdP9EWOiUrnIyfvqOrQfm
	 Sy40jGBMWeT4Nf+gzFC1Fxh3MWIAg2rgUTHSqzvOv2++leWZmZvcST+CMLo0zB6t2wx91
	 tG6XjEmxeeNuReWAYuRKX4o21kr8hqe8FyACRRvFXALqiKTVEEitTUmNWBAljg+kd1Zjy
	 cP2n1W1Zej5hDWHvBVUyM+VsqERsaZcnfSmgzf3j1UvUzU9+5waT3QRCwjgeK39pcbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMnIW3CH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F329606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMnIW3CH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF12A1F0093C;
	Wed, 11 Nov 2026 04:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372728;
	bh=a/HNXoqWDSZ7Qu81iy1RtmIeTUZdqQ/LIQfn6acZCt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMnIW3CH2icbcutUHnGVi7gTZB4l1M+aXBNbxE8zXd3b7UaP87o/dia6RFatApNKl
	 atUJ4gMcWAs+2A2r1LmdUbSL80jvwdXBPCboBON/URKF4U1uMRt8KWCwSV1WPiOhzK
	 C/DMVIRHAz+dt4gTxcZb2RhkkbgkIyALF0/UQeyNPEYgQqCRZf1X6h5e5yggNONIp5
	 CNX4vzjtFMz1QD5GxM15E0pvlQxtOKEZivdGtKw8vCzYFLejUBg/Kh4raWgA83ZnA+
	 tfB+k3ox3pNTsB19BMUs4Ev/h1eRtjEG96p9Vv8CoPc23DYJ3Es0YARJEA2+aKFzqq
	 7kvklKfDg+aQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Sashiko <netdev-bot+sashiko@kernel.org>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ipmr, ip6mr: validate packets injected into the register vif on xmit
Date: Tue, 10 Nov 2026 23:52:05 -0500
Message-ID: <20261111045050.1179137-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111045050.1179137-1-sashal@kernel.org>
References: <20261107052652-failed-6.12-aa1799e93f5e@kernel.org>
 <20261111045050.1179137-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c  | 6 ++++++
 net/ipv6/ip6mr.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 6ebbd83b01306..8fadd5281c5e4 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -513,6 +513,12 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
 	};
 	int err;
 
+	if (skb->protocol != htons(ETH_P_IP) || !pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	rcu_read_lock();
 	err = ipmr_fib_lookup(net, &fl4, &mrt);
 	if (err < 0) {
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 9a1d04e197ff4..0ecb6af344fbc 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -616,7 +616,7 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb,
 		.flowi6_mark	= skb->mark,
 	};
 
-	if (!pskb_inet_may_pull(skb))
+	if (skb->protocol != htons(ETH_P_IPV6) || !pskb_inet_may_pull(skb))
 		goto tx_err;
 
 	if (ip6mr_fib_lookup(net, &fl6, &mrt) < 0)
-- 
2.53.0


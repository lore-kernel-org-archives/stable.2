Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404430;
	b=2A77E6ad+q84b3POSRNbSoD2ofzQl3FsRpBiGNZXIhPJGLtm+eK3uwJEOJpk5sBoXrIf
	 9el/D0Exxd9deqiODmVchi4Uo2r/+MRhfROfglprTOi60Ho/ZWeag836SDrQBAWjaXrzC
	 1GOXWgNbItvrbTifIhdUrVglF7zTPevcpjSDBdXmd7vQsIRT6Vrg/yX96xHCwW5Fk6hc/
	 517661ZfY8vg4qBjDSNlW3znChoEbCKJEmiA0KqcBFTjlViQzmpe0tYGJG9mV7j126WKt
	 Y4Var5Y4d0pmiTuKf6Tbc8koXxU5hTT9BXEPKT9morThZ8n8uTEVxrgJI4nqx1DpTtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404430;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=upJ/nNJu16fuhgSruGz9+s853fZA3uyq96CmGKls4YQ=;
	b=rBCkLNqLqOql6zh18NhraAkcCLNB8ZziogZGFyKkPGja2z9awchP3BcSj1KPo8YAWpLC
	 4oeFlVKHSxuB9ZSbQuYp35gtTGMR0AzD+r+qdcQlXm6WIoTz19tprlX/zov0TtQTdy6qo
	 Zbs6f57kNFbeuZXuVRE8lXXDWt1ty0/7wRiMX4aHpeAnm6vzyuNP/SP3sa/ENTrh15a7T
	 kxxME2xWHdlWd2JwmwpG7Wl+cQfKx/sEg4xHAvLVqE3ycdNaVacBm55MittwYh7RIbOi8
	 wq4tTwHkfBndFQPMwViP0XwN6S1+0BFNahy321XxbpvAUjmOt6f7HGGXkH71WrxateA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKr42UAn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D9606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKr42UAn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C5B1F00A05;
	Wed, 11 Nov 2026 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404429;
	bh=upJ/nNJu16fuhgSruGz9+s853fZA3uyq96CmGKls4YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BKr42UAnBkCixgjZ7bEOBntp3iOQzKMud5Tzqag82xZGo24lJ0WGEA5AC+3p9P8ZX
	 QYH6XG3iBJDxzKhvvYgsckif9BjV96BwSDjmaulSBHChFjYqO5x+AHBMgKhrIynecZ
	 EkzpUKQtTvcjeO598IvMU/A3KzP+JQ52XvbiLtiPsa3qyCuDR5I98RgR2FDYUZ5DC0
	 Uqxwrxi0le8Nn7XT9hrMkpgQ+ZdZffs6lXZWhPzee0Oav0OEkuZ1FanPvxOcGp33Yf
	 E0VtBnegjrpMqebN1WeS2Cvodst30CkVntORvVYKgKLaxUCRIWUwOi0OMsw/bfaC5s
	 V6ylkB+KvHE3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Sashiko <netdev-bot+sashiko@kernel.org>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ipmr, ip6mr: validate packets injected into the register vif on xmit
Date: Wed, 11 Nov 2026 08:40:27 -0500
Message-ID: <20261111133943.1668342-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062928-failed-5.10-aa1799e93f5e@kernel.org>
References: <20261107062928-failed-5.10-aa1799e93f5e@kernel.org>
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
[ sashal: adjusted context for missing rcu_read_lock() calls before multicast FIB lookups ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c  | 6 ++++++
 net/ipv6/ip6mr.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index ad49b3a9f7a2e..c2efc0c7504c0 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -514,6 +514,12 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
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
index 43bb75ea93898..d5d027d77f2fa 100644
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


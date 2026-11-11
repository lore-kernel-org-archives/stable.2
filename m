Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373209;
	b=s6XJxCYKgRCe+GicfHaMLgPdnyrzUiFOvR1x+wufubUOSssajWFKfEXpBprf42sKRKeX
	 UaMa5F41GrwKL/aXf1pm96aOWEjMiDTLQNU0/40mK+uOih9hrHroHOhL0ob6+uRbjOSmy
	 mx7OsD0IhMvrO+3ONv74OIeZN1YWOGewJyphGOyODuSxL27K8VVSgGPlujlfB7/A0i/zS
	 agvHFInJ4vc/LXJNETqTC5ChY2/Z6gkp1N89LXMBzgrbdPqYLTcFGqw/Zh4nY1jCgnwkf
	 /jkZafjL6tawzpUTRKP4Jj70d7wbvX3nECtvr3yLcJEfS2xAx1HpHM2gL/rH5bQGO4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cObYUf3l6pYw/k5l1+/ToQTWEzrBR62Vt4yL7AKFgAg=;
	b=euVtGya1UFpOzuawnMkZw8obymZBlt+nME2HABZE51ZCBpKiUkFLDORo+K7RU+I5iGWq
	 dis5Zgsoms9LZLvKcfBZBL7PzE8NuxJQAoiBGAUoKafAF95g1D9RatrEMpnfg6FVClnJr
	 /Ts6veTuNubwTmm4l6XHj85+91ORqGcSv8eZbM9nmHOo5dYMBdDyKtgbhSZLh7eVQgrfE
	 CftaWVow6Fe/RFP9G4bWBifIty9FpiRrePceycR4fABPnK8ZrPs2dlk2GHfSSdQsViKJi
	 GvZMHuEXZ1+Htauzs6zWg0V4VjVOUzp21teORL0iIk0LYuMRl4vgu2yqCRKB0QOQIQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ciz6T2vT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD1606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ciz6T2vT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA171F00A00;
	Wed, 11 Nov 2026 05:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373208;
	bh=cObYUf3l6pYw/k5l1+/ToQTWEzrBR62Vt4yL7AKFgAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ciz6T2vTTYq5q9WaF1KSV88RyP7Wbzmrc6KMr7z7o01UicTx5KhD3Cb+Dpnn645Lb
	 OeILA+ncR9ddzZ99DfWxc33VViqB0X76qc6uSEMRSI6ep1VBSTvOWlRI2yM0EhKjqR
	 eqI8AygGviJRiMQ2wxo8vRB3ZaM14xT5aAn2XBDNnHVsIF15Pnhd7q2Y4z6LP/mzf3
	 Cy8iD0uheEmQ9/s1e4jIhE0nhXJXB9TbAqLFWUHjgeQZqLPZBks/kmbTzA/M9yzUdx
	 yj958TlUs1EWeNY0vnvpRx7BCwGr6csv2d3hHhl6PY66HZVHdlWveElE6ZU+j/ed6R
	 BWaat+Es5B3IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Sashiko <netdev-bot+sashiko@kernel.org>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ipmr, ip6mr: validate packets injected into the register vif on xmit
Date: Wed, 11 Nov 2026 00:00:05 -0500
Message-ID: <20261111045954.1204061-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111045954.1204061-1-sashal@kernel.org>
References: <20261107053939-failed-6.6-aa1799e93f5e@kernel.org>
 <20261111045954.1204061-1-sashal@kernel.org>
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
index d831d89a9b0aa..dd4c570a0e04f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -512,6 +512,12 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
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
index 38446928f1c45..f24ebb942c64e 100644
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419112;
	b=Lm6fGdx4ph6GVgSiX72DYGYUN4nsRElBxDPpNZsxazME4qSWo1HN6XEzx1ktCuEsIu5+
	 RpBLgUToVSC/Eq22lxVBC1/Sb6Hbr2kONjXHcjR4Tzdk6LpUHoZl3gpEeIhqQPfuisq4+
	 e73CLMMAFqJZjLQluB5hjNJHCFEZH8no1CoUlwizXUu5FylLpbRkYnwELK5OBdzFqQEK6
	 5yTaOmbSpACf23PavYBL1G8Pnzb9v/0pw2yMWw0WBvwdltS0AmO+1+u8jVp/dtiVR7i1l
	 +PWhgRfP61OWp1e/mhH9wvUUJIPfrHDjcSFRcGS2axKVXCnmUl3bVjwkGLp2uDonEQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419112;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uw9g4Eupr/+A/3rq7B4qYuoT2jG/1G/M+rvcp5cOYmQ=;
	b=mZI50P06fWl+m9TJR0f7aTMHIQYBLBSNKqjKM1Vu2/pahIaUmHzKdvRfowCayFjdkifO
	 WDS5J/U+PHLW7SI099kbYpNTaqIOJ0CUJdmaO8Y/nKHUYpPxbOH9eeqpiCOIVXTmnV3Jd
	 K0nkC/fAiRUiQ5MaFbADRCRPBHEetiYVMcBqm66E0XtEZ7DHPvBzD9/D+kjsfIoARIS63
	 6GlDWNEg0fWaR3r+4c3Uug+gXA0540w2hR/wB8c/SM6EvgdAqDNZdNg0iZaHEr0cbM7V6
	 pwZ68zjc6kd8uqw6JUZ6BrtWNtjT9gIoFegrnmc4Ihsm8OzNMoxGeFWSgVSDECQoTmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hjai1VgS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE5606B4DB
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hjai1VgS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBA91F00A06;
	Wed, 11 Nov 2026 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419112;
	bh=uw9g4Eupr/+A/3rq7B4qYuoT2jG/1G/M+rvcp5cOYmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hjai1VgSEIIYccDfEZagzaVrnm8fYD4Fr6/45P23Y+xgxzZ+zZopo4gvMC9E4inAB
	 wGMGcE3kR6dPtUxaXIsekFZW8s61xRuiZ+P789RLbysLBQK0O7RmI+QQZ4v3ZR0YHG
	 bx3IDBPxhpjkjStE3pBcESwS9lviDoG2+6zd9XLxFQJ93L2nWiE2/AdnJpy6prfZlZ
	 WpD27TGPM6Tw+xzeQ1c9qfNcGVRh1h8GD/DnaF01Kon+ZfdNYCM9yCj94uQIbTcrwN
	 6o4UVyVgbkBs43mrrK4VBslVuSZwEUf747Wqd+hJd/y7QPM3HNboCqv18Qu8rLcIMr
	 ZgX9AleAkQkBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ipmr: only copy pktinfo to cache reports
Date: Wed, 11 Nov 2026 12:45:09 -0500
Message-ID: <20261111174441.3663023-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111174441.3663023-1-sashal@kernel.org>
References: <20261107053830-failed-6.6-94a6736bb5ab@kernel.org>
 <20261111174441.3663023-1-sashal@kernel.org>
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

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 94a6736bb5abe6b2ef38490d0cab19c1c6a7c71f ]

ipmr_cache_report() prepares IP_PKTINFO on the original skb. The
ipv4_pktinfo_prepare() helper updates skb->cb and clears the pktinfo fields
when packet info is disabled. Since the skb can continue through the data
path, preserve and restore its original control block around the helper.

The original implementation copies the entire control block to the report
skb. For synthetic RTM_GETROUTE packets, NETLINK_CB data is interpreted as
IPCB by the raw IPv4 receive path. With IP_RECVOPTS or IP_RETOPTS enabled,
corrupted option offsets cause out-of-bounds reads or a stack buffer
overflow. WHOLEPKT and WRVIFWHOLE reports also inherit stale IP option
offsets when their header is prepended.

Clear the report skb control block. Only prepare and copy pktinfo when the
input skb has an IPv4 header. Synthetic route-query skbs use NETLINK_CB,
not IPCB, so leave their report control block zeroed. Restore pkt->cb after
preparing pktinfo for regular IPv4 packets.

Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/netdev/20260903113055.GA90787@shredder/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 391b0152d6c85..04e7688868fde 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1030,6 +1030,7 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
+	unsigned char pkt_cb[sizeof(pkt->cb)];
 	const int ihl = ip_hdrlen(pkt);
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
@@ -1085,8 +1086,6 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
@@ -1097,6 +1096,15 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		skb->transport_header = skb->network_header;
 	}
 
+	memset(skb->cb, 0, sizeof(skb->cb));
+	/* Route queries from ipmr_get_route() carry NETLINK_CB, not IPCB. */
+	if (ip_hdr(pkt)->version) {
+		memcpy(pkt_cb, pkt->cb, sizeof(pkt_cb));
+		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
+		*PKTINFO_SKB_CB(skb) = *PKTINFO_SKB_CB(pkt);
+		memcpy(pkt->cb, pkt_cb, sizeof(pkt_cb));
+	}
+
 	igmpmsg_netlink_event(mrt, skb);
 
 	/* Deliver to mrouted */
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418747;
	b=l7uzsex/MV6Wod+m1kDigPArp+N2BUajET0KNoHkTlXpNzJWRHDsBvfEYuV5cqJGiT77
	 NrNdHlbWFcl8jNqvvHXl4r6KNNwlxz5UcQs7b415Se+enY5SluLFBs3T5pSJP56jUD1h/
	 kpLc3E8DdBky6U9Bw5lHijicrAn7QdBODFQBB6Vbe3Fzbk+VoCcRhO0mfszQlP6Asb+Hq
	 j3xvSPUssASvEZCqQqDM1uZXNUVEsX/Y55eoR+zDTAb4hIQqhxoAut+ZSFnnQQuqAJ/7V
	 2q5GudVpKO0JwQ92vMzHjQxuOL2XBOWpH9bQqoPeRn8TSSWAo6bfafFPskrGyeFxCog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ye+GamAIkwRsS7lfLWyClWk1RlyUgiTp+w+5rtQRr7I=;
	b=P1905/26JssQ8647yZrMDBsFl+XPFQJyOZh5YR8O3e2G5BGqUHM1ugGmqyatBqHZcyoX
	 T4Lnor8WxC1qUmjEoOdSiCAkyoIGuVxpp+HHU10/7hRcZEUqbqce0K41tzrENb7UpzniF
	 QqONpeISWkTQPZIV276l/rH0kM0jRKby6SOCJPnj1biyiRcxWEqOIqrj9v4n8X9+xodqH
	 69meDuM92rBmgpaMZw0yEC33eWC4PVt4MjWHqZ+sI4px4G9yCdY3aqXMbyvVlHKFfCteC
	 dmlIKxvF8YhP3cuoFgyPvoXG4OHuIevoS2KUgHZGFi8aL+ixwy4Oi1c03YZHalG3U2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJ6BVQna;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BC606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJ6BVQna
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3682B1F00A07;
	Wed, 11 Nov 2026 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418747;
	bh=Ye+GamAIkwRsS7lfLWyClWk1RlyUgiTp+w+5rtQRr7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KJ6BVQnazUSuAkf0pfAFflfmeTPORsX4PD21A/IjKzxgnUeZrtqVjQxIEN2GwAsTE
	 C/5ETwDB4Wg/dFj2k9o9knqsTD19iF3bPYH9fLCy00Y9j7gJOQMRmqe8Jj07h4ZJeE
	 BVeRPsSGBXigUGvve2Que3adaGLUOR4ymlPv9hVzOSfrKKNYcRk/IuaG8aRmhx4mU/
	 BI/YqobMwWWR59wCCCLKxbbCGBhrTZGU50rTpNMRToRsTq906Y3oJNtxbSNFxJ50OM
	 6e0q6pKo4doZwqPaM1+HYK63by5mwYcpye6PXnvtxwf+M+7H1UmXAxJgFFpniLAyCl
	 NNAxH8dZuLvgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ipmr: only copy pktinfo to cache reports
Date: Wed, 11 Nov 2026 12:39:04 -0500
Message-ID: <20261111173836.3630034-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111173836.3630034-1-sashal@kernel.org>
References: <20261107052532-failed-6.12-94a6736bb5ab@kernel.org>
 <20261111173836.3630034-1-sashal@kernel.org>
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
index fec7012a62e45..f5334bc04dac9 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1031,6 +1031,7 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
+	unsigned char pkt_cb[sizeof(pkt->cb)];
 	const int ihl = ip_hdrlen(pkt);
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
@@ -1086,8 +1087,6 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
@@ -1098,6 +1097,15 @@ static int ipmr_cache_report(const struct mr_table *mrt,
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


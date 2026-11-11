Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418382;
	b=5UjTgXRxffa/wWiLIox4Q8FqVN+laPGS4FI1Nco7bcTWqL4Evi/fgfjohe11cjoR9hCK
	 Ao7oCnrD2iI+d3FncuXw4BcAUcayGfEZ3iyplJhGfrPgxaiV8kY9yxZZOE0jEFhu2C7CU
	 147CZ+yy6MTctc6nhNnX/Vvja2CVtn94wby+yMn3qguXlUFW7SOuS08HZJb8wLaA326Sf
	 raiewrJzqxVrNV0zMy4lf/xARXw3/K4P28AOYYd01D24bPlojWOxfrN5HrQCWnFEOZxx0
	 AL2tZt/3IFv50VUn7YsHxyTZmObjkorLMuyC6mEz3ZOsouDoJxeRZV8tGunP8+bOWDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418382;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ywORb/Z6YEAmgYh74eUnuaruD5UsTfS2gJmv1QuiYUc=;
	b=m+LXjazFjIivbCLGVci7y8Ul2hk/a5N4djlbwYCr1z4WcBSWFppajLqkWNXQYn7/XkGI
	 S++4NfKihY6InSbDLd/1AqvpIg0NfYO4tIbM4CG8W3JLbnQEYq2xNiniOEML4M8/EpkrM
	 29SVMgVqPGMs19hTtXHTvXuemjbzorOxDGxjoeHY4pLb0jjW4L7FTVxkPD9SMiJwxVKxU
	 VodSoCYsR04F7A8YD8edperO53jl9qW8vHiPTLT8aMBzE9lUrBErhV4UOLjpQYEb10yjq
	 8epuesYYYPncnWMO9Bbea2hRArPzlNYEo5rbKuZUMy1p/4JywOX/ea8AaP3yTsp3M9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq+itu9x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C7606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq+itu9x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0331F00A06;
	Wed, 11 Nov 2026 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418382;
	bh=ywORb/Z6YEAmgYh74eUnuaruD5UsTfS2gJmv1QuiYUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lq+itu9xTl/ROUFKbLGEveWcm3WM7PNE6dBqVV11LVTW6RB7QOIwpwDEZ9gXuweGt
	 yQyXbTJhpWUEG0e97L9sHk/ddQ2wCj1SH0HcMl2MoaM+1fuO5j30xTNIms2OppGEjl
	 LZVN8Qhfjll4ybat6+atv7G6ZJV3+i/1ubruTn+gUJtCL6M1XL7MRpc/cIzYDnTWQC
	 La2+SC1O+CZMPjMAW/tPEYZm+LC1oKK2UcKYtiQp++f3Xk1pMRHjjiKHf9gilrLern
	 MdF01m3PLPtRpbODcSZCwU/L0fa2yv1w0/oDZEtQ1GH1w6obW3MbWgzYyALwclFMVo
	 eGVBfyFcHJaog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ipmr: only copy pktinfo to cache reports
Date: Wed, 11 Nov 2026 12:32:59 -0500
Message-ID: <20261111173235.3591073-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111173235.3591073-1-sashal@kernel.org>
References: <20261107051350-failed-6.18-94a6736bb5ab@kernel.org>
 <20261111173235.3591073-1-sashal@kernel.org>
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
index cd587d84f388e..5133fd14029e2 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1055,6 +1055,7 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
+	unsigned char pkt_cb[sizeof(pkt->cb)];
 	const int ihl = ip_hdrlen(pkt);
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
@@ -1110,8 +1111,6 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
@@ -1122,6 +1121,15 @@ static int ipmr_cache_report(const struct mr_table *mrt,
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


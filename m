Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01190400DE2
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525898; cv=none; b=NXZ3O3yLbxD4PTMvAbzJhJ4OmqKj5TKJOcIAE/yBDmzJiN3T+rkbjhu4CQBg0GzE+BEL0wlBlUDm05xOjZLZV0facHJRWZU/xLeWgM6GHQwHNP0iiniXkS6utJ4qjKnUjVopsgelxLXMJNoFn1bRxpvfVzJ+On0P/0LVRDM5ins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525898; c=relaxed/simple;
	bh=gtYqy+OQ2HvCMpqhoP8ZxcMHHo3+DwpQPIVYkqSDC2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqr2Ng/v9uarH1Bn1ezq33JsPQ2rp6UqjmkiVu5nu1kpxcUuk1vCRs8JTQVxNOyMvTlehc9vNc2G1DihRGObiyFJyf0NudYKsmdvYBINYqTBSEnWOtiL7L1IwbK+BFPIPBxcdCQNrp/IZ0h2rbYbQ2rs5XC+EaV9nc25ynEy2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJet8B0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJet8B0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1593B1F00AC4;
	Wed, 12 Aug 2026 09:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525892;
	bh=gr/LDc5WmntNOLfBZjuBgSI3Zhc2oeFiTNi6C2vkpPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fJet8B0hyfSAxBv63CH5mPUEppGb6wgTc85fIh5RZqzNDZOrArxVFKyuNKEdrU9qV
	 oKjCS2B80wsMIEnZMrr4mCXWuB6FdXRQk6kad5SWtxsIgCj3skfonxTgsEzu26dn2X
	 C+QGfe2X9gN4hG+LglbGXCsX4Huobc2YGPcewDzNAD81Y23jHhf2umxv3uu8UR9TQM
	 DfW6skIMeYzMErDCf7RX6pcHq5RNzksSS7YfSnCt2EAX3OG1RVLJtR0CPLgQ88XgWi
	 OsaEywCA9Ja+mbecngYYSpoaxUOXiY68kHItgYtud/tY28MZVaj+9XcnBQ7WgzgErh
	 +RDectr3/lM4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] vxlan: use pskb_network_may_pull() for transmit path header pulls
Date: Wed, 12 Aug 2026 05:11:27 -0400
Message-ID: <20260812091127.1349673-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812091127.1349673-1-sashal@kernel.org>
References: <2026080500-gloomily-getup-2a3e@gregkh>
 <20260812091127.1349673-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b9553558b48db54ac9273e6b98d7263ef5c1a329 ]

In vxlan_xmit(), arp_reduce(), and vxlan_mdb_entry_skb_get(), pskb_may_pull() was
being called to verify the availability of network layer headers (ARP, IPv6/ND,
IP/IPv6 MDB keys).

However, during transmit skb->data points to the MAC header, so skb_network_offset(skb)
is ETH_HLEN (14 bytes). Using pskb_may_pull(skb, len) only checks len bytes from skb->data
rather than skb_network_offset(skb) + len, which can leave part of the network header
in non-linear frags.

Replace these remaining pskb_may_pull() calls with pskb_network_may_pull() to properly
account for the MAC header offset.

Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
Fixes: f564f45c4518 ("vxlan: add ipv6 proxy support")
Fixes: 0f83e69f44bf ("vxlan: Add MDB data path support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260723144249.759100-6-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 6 +++---
 drivers/net/vxlan/vxlan_mdb.c  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d27f3ef2a0fb2..5718433862af0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1857,7 +1857,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	if (dev->flags & IFF_NOARP)
 		goto out;
 
-	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
+	if (!pskb_network_may_pull(skb, arp_hdr_len(dev))) {
 		dev_dstats_tx_dropped(dev);
 		vxlan_vnifilter_count(vxlan, vni, NULL,
 				      VXLAN_VNI_STATS_TX_DROPS, 0);
@@ -2831,8 +2831,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			return arp_reduce(dev, skb, vni);
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
-			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
-					    sizeof(struct nd_msg)) &&
+			 pskb_network_may_pull(skb, sizeof(struct ipv6hdr) +
+						    sizeof(struct nd_msg)) &&
 			 ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
 			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
 
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 73c128c3d90de..eb919fc05cdf9 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1326,7 +1326,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
 			return NULL;
 		group.dst.sa.sa_family = AF_INET;
 		group.dst.sin.sin_addr.s_addr = ip_hdr(skb)->daddr;
@@ -1335,7 +1335,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
 			return NULL;
 		group.dst.sa.sa_family = AF_INET6;
 		group.dst.sin6.sin6_addr = ipv6_hdr(skb)->daddr;
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7CD204F8B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493353; cv=none; b=p0pJly8za870iW4tpmfDTC2a7bM0VFsLuG/UMJfdiUdAJEXy5nEm8upAeiAXjCK6ZM4wKnK0UmEM5TDWhB5ohYBtMP0CiNDX2qwy4kiZYoRS6GYfQS3s2tcQQJkfrC1UDEWNX5DXCG9V90QnBzEWwBNBU/Xa6KlaNdCpStHuCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493353; c=relaxed/simple;
	bh=lIrulEVjOSE1as6XagMvc/yRIS0lIkQUjos0Dblbxlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdkyVzub3+AlC5Q7TrdDkcwGUO3146p0jPs+Ys3ZyHBxY+0rbAnrHEOEB4LjRq3OyySDV59BH2t1w+NxDXm3XqB8gFOf4NXr7i92qTvihSqGY6x5OpwW0qQEzTFxR2eBgH7XO0JCtdCOR5nZdPhaDAsO8DjzE7u72VdYbrdF1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjLJgcMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjLJgcMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856911F00A3D;
	Wed, 12 Aug 2026 00:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493352;
	bh=LcnOuF7X7xJ+TLvRFZ4nyUeaeklU9nJ4RR9XVs/nO4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DjLJgcMg1LuBFTSrqOaSXLURAYZt+HjzPh3DHOw1WlM8CHMNKKfVkvyAZOATtyq8f
	 jqx/eB6PpDU3vsgGV8pP/6UoQo0IXpQUNZeziVGpCU727kn7oS6gQ4K7Qe+W9LAukz
	 7ENFeYbcrQ/gG2YTgOAV/iqZO0pjWLMDZrCCSYhKOBJ2Qa/U10qVNaAaD0Ak1ICHq6
	 2djce4hWx50CRNM1NbW8a/60cOaJ99ybcS3DsrkGlCPdvwoM/WmBlQltSTenQIHNLJ
	 WeH5Vw0GUSAb0ubPUKDS3fyuoIH1ciuudJeoAaI8iBEUZSJvoVS1W+Jzhi/p0PzQ0j
	 Pp6NXLhFiaWJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] vxlan: use pskb_network_may_pull() for transmit path header pulls
Date: Tue, 11 Aug 2026 20:09:08 -0400
Message-ID: <20260812000908.4156424-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812000908.4156424-1-sashal@kernel.org>
References: <2026080559-twins-crimson-3764@gregkh>
 <20260812000908.4156424-1-sashal@kernel.org>
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
index add0f56a8f8f7..7cf7487bf732f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1875,7 +1875,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	if (dev->flags & IFF_NOARP)
 		goto out;
 
-	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
+	if (!pskb_network_may_pull(skb, arp_hdr_len(dev))) {
 		dev_dstats_tx_dropped(dev);
 		vxlan_vnifilter_count(vxlan, vni, NULL,
 				      VXLAN_VNI_STATS_TX_DROPS, 0);
@@ -2757,8 +2757,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
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
index 165b9f4a8eef6..e15a8536dae9b 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1631,7 +1631,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
 			return NULL;
 		group.dst.sa.sa_family = AF_INET;
 		group.dst.sin.sin_addr.s_addr = ip_hdr(skb)->daddr;
@@ -1640,7 +1640,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
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

